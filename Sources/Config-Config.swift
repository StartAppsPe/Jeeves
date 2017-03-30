//
//  Config-Config.swift
//  Jeeves
//
//  Created by Gabriel Lanata on 30/10/16.
//
//

import Jessie

final class Config: JsonConvertible, CustomStringConvertible {
    
    var name: String
    
    var jeevesHost: String
    var jeevesPort: Int
    
    var nginxHost: String
    var nginxPort: Int
    var nginxConfigPath: String
    var nginxWorkerInstances: Int
    var nginxWorkerConnections: Int
    
    
    var mainRootDir: String
    
    var apps: [App]
    
    init(json: Json) throws {
        self.name = try json <~ ["name"]
        self.jeevesHost = try json <~ ["jeevesHost"]
        self.jeevesPort = try json <~ ["jeevesPort"]
        self.nginxHost = try json <~ ["nginxHost"]
        self.nginxPort = try json <~ ["nginxPort"]
        self.nginxConfigPath = try json <~ ["nginxConfigPath"]
        self.nginxWorkerInstances = try json <~ ["nginxWorkerInstances"]
        self.nginxWorkerConnections = try json <~ ["nginxWorkerConnections"]
        self.mainRootDir = try json <~ ["mainRootDir"]
        self.apps = try json <~ ["apps"]
    }
    
    public func toJson() -> Json {
        return Json(
            [
                "name": self.name,
                "jeevesHost": self.jeevesHost,
                "jeevesPort": self.jeevesPort,
                "nginxHost": self.nginxHost,
                "nginxPort": self.nginxPort,
                "nginxConfigPath": self.nginxConfigPath,
                "nginxWorkerInstances": self.nginxWorkerInstances,
                "nginxWorkerConnections": self.nginxWorkerConnections,
                "mainRootDir": self.mainRootDir,
                "apps": self.apps.toJson()
            ]
        )
    }
    
    public var description: String {
        var description = "JeevesConfig"
        description += "\n  - name: \(name)"
        description += "\n  - jeevesHost: \(jeevesHost)"
        description += "\n  - jeevesPort: \(jeevesPort)"
        description += "\n  - nginxHost: \(nginxHost)"
        description += "\n  - nginxPort: \(nginxPort)"
        description += "\n  - nginxConfigPath: \(nginxConfigPath)"
        description += "\n  - nginxWorkerInstances: \(nginxWorkerInstances)"
        description += "\n  - nginxWorkerConnections: \(nginxWorkerConnections)"
        description += "\n  - mainRootDir: \(mainRootDir)"
        description += "\n  - apps: \(apps)"
        return description
    }
    
    private init() { // Defaults
        
        name = "Jeeves"
        jeevesHost = "localhost"
        jeevesPort = 8765
        nginxHost = "localhost"
        nginxPort = 80
        nginxConfigPath = "/usr/local/etc/nginx/nginx.conf"
        nginxWorkerInstances = 1
        nginxWorkerConnections = 1024
        mainRootDir = "/Users/Gabriel/Dropbox/Projects/"
        
        let jeevesApp = App(name: "Jeeves", owner: "Administrator", rootDir: "\(mainRootDir)Jeeves/")
        jeevesApp.git = "git@github.com:StartAppsPe/Jeeves.git"
        jeevesApp.routes.append(Route.proxy(path: "/jeeves", destination: "http://\(jeevesHost):\(jeevesPort)/"))
        jeevesApp.service = try! Service(identifier: "swift")
        jeevesApp.parameters = [App.Parameter(key: "script", val: "main.swift")]
        jeevesApp.order = 1
        
        let nginxApp = App(name: "Nginx", owner: "Administrator", rootDir: "/usr/local/nginx/")
        nginxApp.routes.append(Route.static(path: "/nginx", destination: "html"))
        nginxApp.service = try! Service(identifier: "nginx")
        nginxApp.order = 0
        
        apps = [jeevesApp, nginxApp]
    }
    
    static func initWithDefaults() -> Config {
        return Config()
    }
    
}
