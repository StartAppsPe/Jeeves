//
//  Api-Routes.swift
//  Jeeves
//
//  Created by Gabriel Lanata on 31/10/16.
//
//

import PerfectHTTP
import StartAppsKitExtensions
import Jessie

var ApiRoutesApps: Routes {
    
    var routes = Routes(baseUri: "/api")
    
    routes.add(method: .get, uri: "/apps/list") { request, response in
        response.send(Config.shared.apps.toJson())
    }
    
    routes.add(method: .post, uri: "/apps/add") { request, response in
        do {
            guard let name = request.postJson["name"].string?.clean() else { throw Abort(.badRequest) }
            guard let owner = request.postJson["owner"].string?.clean() else { throw Abort(.badRequest) }
            for existingApp in Config.shared.apps {
                guard existingApp.name != name else {
                    throw Abort(.badRequest, "App already exists with same name")
                }
            }
            
            let app = App(name: name, owner: owner)
            
            if let order = request.postJson["order"].int {
                app.order = order
            }
            
            if let git = request.postJson["git"].string?.clean() {
                app.git = git
            }
            
            if let routesJson = request.postJson["routes"].array {
                for routeJson in routesJson {
                    let route = try Route(json: routeJson)
                    app.routes.append(route)
                }
            }
            
            if let serviceIdentifier = request.postJson["service"].string?.clean() {
                app.service = try Service(identifier: serviceIdentifier)
            }
            
            if let parametersJson = request.postJson["parameters"].array {
                for parameterJson in parametersJson {
                    let parameter = try App.Parameter(json: parameterJson)
                    app.parameters.append(parameter)
                }
            }
            
            Config.shared.apps.append(app)
            try Config.shared.save()
            
            response.send(["message":"Successfully added app","app":app.toJson()])
        } catch {
            response.send(error)
        }
    }
    
    routes.add(method: .post, uri: "/apps/update") { request, response in
        do {
            guard let existingName = request.postJson["existingName"].string?.clean() else { throw Abort(.badRequest) }
            guard let app = Config.shared.apps.find({ $0.name == existingName }) else {
                throw Abort(.badRequest, "Existing app not found")
            }
            
            if let name = request.postJson["name"].string?.clean(), name != existingName {
                for existingApp in Config.shared.apps {
                    guard existingApp.name != name else {
                        throw Abort(.badRequest, "App already exists with same name")
                    }
                }
                app.name = name
            }
            
            if let owner = request.postJson["owner"].string?.clean() {
                app.owner = owner
            }
            
            if let git = request.postJson["git"].string?.clean() {
                app.git = git
            }
            
            if let order = request.postJson["order"].int {
                app.order = order
            }
            
            if let routesJson = request.postJson["routes"].array {
                app.routes = []
                for routeJson in routesJson {
                    let route = try Route(json: routeJson)
                    app.routes.append(route)
                }
            }
            
            if let serviceIdentifier = request.postJson["service"].string?.clean() {
                app.service = try Service(identifier: serviceIdentifier)
            }
            
            if let parametersJson = request.postJson["parameters"].array {
                app.parameters = []
                for parameterJson in parametersJson {
                    let parameter = try App.Parameter(json: parameterJson)
                    app.parameters.append(parameter)
                }
            }
            
            try Config.shared.save()
            
            response.send(["message":"Successfully updated app","app":app.toJson()])
        } catch {
            response.send(error)
        }
    }
    
    routes.add(method: .post, uri: "/apps/delete") { request, response in
        do {
            guard let existingName = request.postJson["existingName"].string?.clean() else { throw Abort(.badRequest) }
            guard let _ = Config.shared.apps.find({ $0.name == existingName }) else {
                throw Abort(.badRequest, "Existing app not found")
            }
            
            Config.shared.apps = Config.shared.apps.filter({ $0.name != existingName })
            try Config.shared.save()
            
            response.send(["message":"Successfully deleted app"])
        } catch {
            response.send(error)
        }
    }
    
    routes.add(method: .get, uri: "/apps/listStatus") { request, response in
        let apps = Config.shared.apps
        var appsJson = apps.toJson()
        for i in 0..<apps.count {
            appsJson[i]["status"] = apps[i].statusJson
        }
        response.send(appsJson)
    }
    
    routes.add(method: .post, uri: "/nginx/update") { request, response in
        do {
            try Nginx.update()
            response.send(["message":"Successfully updated Nginx"])
        } catch {
            response.send(error)
        }
    }
    
    return routes
    
}
