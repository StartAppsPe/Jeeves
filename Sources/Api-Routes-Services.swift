//
//  Api-Routes-Services.swift
//  Jeeves
//
//  Created by Gabriel Lanata on 28/3/17.
//
//

import PerfectHTTP
import StartAppsKitExtensions
import Jessie

var ApiRoutesServices: Routes {
    
    var routes = Routes(baseUri: "/api")
    
    routes.add(method: .post, uri: "/apps/command") { request, response in
        do {
            guard let name = request.postJson["name"].string?.clean() else { throw Abort(.badRequest) }
            guard let commandIdentifier = request.postJson["command"].string?.clean() else { throw Abort(.badRequest) }
            
            guard let app = Config.shared.apps.find({ $0.name == name }) else {
                throw Abort(.badRequest, "App not found")
            }
            guard let command = try? Command(identifier: commandIdentifier) else {
                throw Abort(.badRequest, "Command not found")
            }
            
            let result = try command.run(forApp: app)
            
            response.send(["message":"Successfully ran command","result":result])
        } catch {
            response.send(error)
        }
    }
    
    return routes
    
}
