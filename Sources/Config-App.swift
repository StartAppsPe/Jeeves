//
//  Config-App.swift
//  Jeeves
//
//  Created by Gabriel Lanata on 30/10/16.
//
//

import Foundation
import Jessie

class App: JsonConvertible, CustomStringConvertible {
    
    enum AppParseError: Error {
        case invalidServiceType(String), invalidRouteType(String), missingParameter(String)
    }
    
    struct Parameter: JsonConvertible {
        var key: String
        var val: String
        init(key: String, val: String) {
            self.key = key
            self.val = val
            
        }
        init(json: Json) throws {
            self.key = try json <~ ["key"]
            self.val = try json <~ ["val"]
            
        }
        func toJson() -> Json {
            return Json(
                [
                    "key": self.key,
                    "val": self.val
                ]
            )
        }
    }
    
    var name: String
    var owner: String
    
    var order: Int
    
    var rootDir: String
    
    var git: String?
    
    var dateAdded: Date = Date()
    var dateModified: Date = Date()
    
    var token: String?
    
    var routes: [Route] = []
    
    var service: Service?
    var parameters: [Parameter] = []
    
    init(name: String, owner: String, rootDir: String? = nil, order: Int = 100) {
        self.name = name
        self.owner = owner
        self.order = order
        self.rootDir = rootDir ?? "\(Config.shared.mainRootDir)\(name)/"
    }
    
    required init(json: Json) throws {
        self.name = try json <~ ["name"]
        self.owner = try json <~ ["owner"]
        self.order = try json <~ ["order"]
        self.rootDir = try json <~ ["rootDir"]
        self.git = try json <~ ["git"]
        self.dateAdded = try json <~ ["dateAdded"]
        self.dateModified = try json <~ ["dateModified"]
        self.token = try json <~ ["token"]
        self.routes = try json <~ ["routes"]
        if let serviceIdentifier = (try json <~ ["service"] as String?)?.clean() {
            self.service = try Service(identifier: serviceIdentifier)
        }
        self.parameters = try json <~ ["parameters"]
        
    }
    
    public func toJson() -> Json {
        return Json(
            [
                "name": self.name,
                "owner": self.owner,
                "order": self.order,
                "rootDir": self.rootDir,
                "git": self.git,
                "dateAdded": self.dateAdded,
                "dateModified": self.dateModified,
                "token": self.token,
                "routes": self.routes.toJson(),
                "service": self.service?.identifier,
                "parameters": self.parameters.toJson()
            ]
        )
    }
    
    public var description: String {
        var description = "JeevesApp"
        description += "\n  - name: \(name)"
        description += "\n  - owner: \(owner)"
        description += "\n  - order: \(order)"
        description += "\n  - rootDir: \(rootDir)"
        description += "\n  - git: \(git ?? "NONE")"
        description += "\n  - dateAdded: \(dateAdded)"
        description += "\n  - dateModified: \(dateModified)"
        description += "\n  - token: \(token ?? "NONE")"
        description += "\n  - routes: \(routes)"
        description += "\n  - service: \(service?.name ?? "NONE")"
        description += "\n  - parameters: \(parameters)"
        return description
    }
    
}
