//
//  Commands-Commands.swift
//  Jeeves
//
//  Created by Gabriel Lanata on 27/3/17.
//
//

import Foundation
import StartAppsKitExtensions
import StartAppsKitLogger
import Jessie

enum ServiceError: Error {
    case parameterNotFound(String)
}

struct Services: JsonConvertible, CustomStringConvertible {
    
    var services: [Service]
    
    init(json: Json) throws {
        self.services = try json <~ ["services"]
    }
    
    public func toJson() -> Json {
        return Json(
            [
                "services": self.services.toJson(),
                ]
        )
    }
    
    public var description: String {
        var description = "JeevesServices"
        description += "\n\(services)"
        return description
    }
    
}


struct Service: JsonConvertible, CustomStringConvertible {
    
    var name: String
    var identifier: String
    var commands: [Command]
    
    init(identifier: String) throws {
        if let service = Services.shared.services.find({ $0.identifier == identifier }) {
            self = service
        } else {
            throw App.AppParseError.invalidServiceType(identifier)
        }
    }
    
    init(json: Json) throws {
        self.name = try json <~ ["name"]
        self.identifier = try json <~ ["identifier"]
        self.commands = try json <~ ["commands"]
    }
    
    public func toJson() -> Json {
        return Json(
            [
                "name": self.name,
                "identifier": self.identifier,
                "commands": self.commands.toJson(),
                ]
        )
    }
    
    public var description: String {
        var description = "  - name: \(name)"
        description += "\n    - identifier: \(identifier)"
        description += "\n    - commands: \(commands)"
        return description
    }
    
}

struct Command: JsonConvertible, CustomStringConvertible {
    
    enum CommandType: String {
        case start, stop, restart, reload, deploy, other
    }
    
    var name: String
    var identifier: String
    var type: CommandType
    var bash: String
    var expected: String?
    var parameters: [CommandParameter]
    
    func run(forApp app: App) throws -> String {
        Log.debug("Service will run command \"\(identifier)\"")
        
        // Find parameters
        var foundParameters: [App.Parameter] = []
        for parameter in parameters {
            var paremeterFound = false
            for appParameter in app.parameters {
                if parameter.key == appParameter.key {
                    foundParameters.append(appParameter)
                    paremeterFound = true
                    break
                }
            }
            if !paremeterFound {
                throw App.AppParseError.missingParameter(parameter.key)
            }
        }
        
        // Get bash command
        var newBash = self.bash
        let requiredParameters = newBash.matchingRegex(regex: "\\[(.*?)\\]")
        for requiredParameter in requiredParameters {
            var foundValue: String?
            switch requiredParameter {
            case  "_mainRootDir": foundValue = Config.shared.mainRootDir
            case  "_name": foundValue = app.name
            case  "_owner": foundValue = app.owner
            case  "_rootDir": foundValue = app.rootDir
            case  "_git": foundValue = app.git
            default: foundValue = app.parameters.find({ $0.key == requiredParameter })?.val
            }
            guard foundValue != nil else {
                throw ServiceError.parameterNotFound(requiredParameter)
            }
            newBash = newBash.replacingOccurrences(of: "[\(requiredParameter)]", with: foundValue!)
        }
        
        // Run command
        let result = try Bash.run(newBash, expected: expected)
        Log.info("Service ran command \"\(identifier)\"")
        Log.info("  - Result: \(result)")
        return result
    }
    
    init(identifier: String) throws {
        if let command = Services.shared.services.flatMap({ $0.commands }).find({ $0.identifier == identifier }) {
            self = command
        } else {
            throw App.AppParseError.invalidServiceType(identifier)
        }
    }
    
    init(json: Json) throws {
        self.name = try json <~ ["name"]
        self.identifier = try json <~ ["identifier"]
        self.type = CommandType(rawValue: try json <~ ["type"]) ?? .other
        self.bash = try json <~ ["bash"]
        self.expected = try json <~ ["expected"]
        self.parameters = try json <~ ["parameters"]
    }
    
    public func toJson() -> Json {
        return Json(
            [
                "name": self.name,
                "identifier": self.identifier,
                "type": self.type.rawValue,
                "bash": self.bash,
                "expected": self.expected,
                "parameters": self.parameters.toJson(),
                ]
        )
    }
    
    public var description: String {
        var description = "    - name: \(name)"
        description += "\n    - identifier: \(identifier)"
        description += "\n    - type: \(type.rawValue)"
        description += "\n    - bash: \(bash)"
        description += "\n    - expected: \(expected ?? "NONE")"
        description += "\n    - parameters: \(parameters)"
        return description
    }
    
    //    func run() throws -> String {
    //        return try Bash.run(bash)
    //    }
    
}

struct CommandParameter: JsonConvertible, CustomStringConvertible {
    
    var key: String
    var info: String
    
    
    init(json: Json) throws {
        self.key = try json <~ ["key"]
        self.info = try json <~ ["info"]
    }
    
    public func toJson() -> Json {
        return Json(
            [
                "key": self.key,
                "info": self.info
            ]
        )
    }
    
    public var description: String {
        return "\n      - \(key): (\(info))"
    }
    
}

extension String {
    
    func matchingRegex(regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let matches = regex.matches(in: self, options: [], range: NSMakeRange(0, utf16.count))
            let results = matches.map { result -> String in
                let hrefRange = result.rangeAt(1)
                let start = String.UTF16Index(hrefRange.location)
                let end = String.UTF16Index(hrefRange.location + hrefRange.length)
                return String(utf16[start..<end])!
            }
            return results
        } catch let error as NSError {
            Log.error("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
}
