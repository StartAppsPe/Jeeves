//
//  Nginx-NginxManager.swift
//  Jeeves
//
//  Created by Gabriel Lanata on 29/3/17.
//
//

import Foundation
import StartAppsKitLogger
import Jessie

extension Nginx {
    
    static var configPath: String {
        return "file:\(Config.shared.nginxConfigPath)"
    }
    
    private static func exists() -> Bool {
        let nginxFile = URL(string: configPath)!
        if let data = try? Data(contentsOf: nginxFile), data.count > 0 {
            return true
        } else {
            return false
        }
    }
    
    public static func update() throws {
        Log.debug("Nginx Saving")
        guard exists() else {
            throw NginxError.configNotFound
        }
        guard let nginxFile = URL(string: configPath) else {
            throw NginxError.invalidConfigPath
        }
        try nginxRaw.write(to: nginxFile, atomically: true, encoding: .utf8)
        Log.info("Nginx Saved")
    }
    
}


extension Nginx {
    
    static var nginxRaw: String {
        let config = Config.shared
        
        var raw = "" +
            "worker_processes  \(config.nginxWorkerInstances);\n" +
            "events {\n" +
            "    worker_connections  \(config.nginxWorkerConnections);\n" +
            "}\n" +
            "\n" +
            "http {\n" +
            "    include       mime.types;\n" +
            "    default_type  application/octet-stream;\n" +
            "    sendfile        on;\n" +
            "    keepalive_timeout  65;\n" +
            "    \n" +
            "    server {\n" +
            "        listen       \(config.nginxPort);\n" +
            "        server_name  \(config.nginxHost);\n" +
            "        \n" +
        ""
        
        for app in config.apps {
            for route in app.routes {
                switch route {
                case .proxy(let path, let destination):
                    raw += "" +
                        "        location \(path) {\n" +
                        "            proxy_pass \(destination);\n" +
                        "        }\n" +
                    ""
                case .static(let path, let destination):
                    raw += "" +
                        "        location \(path) {\n" +
                        "            root \(app.rootDir)\(destination);\n" +
                        "        }\n" +
                    ""
                }
            }
        }
        
        raw += "" +
            "    }\n" +
            " }\n" +
        ""
        
        return raw
    }
    
}
