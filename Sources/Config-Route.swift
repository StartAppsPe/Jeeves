//
//  Config-Route.swift
//  Jeeves
//
//  Created by Gabriel Lanata on 27/3/17.
//
//

import Foundation
import Jessie

enum Route: JsonConvertible {
    case `static`(path: String, destination: String)
    case proxy(path: String, destination: String)
    
    init(json: Json) throws {
        let routeType: String = try json <~ ["type"]
        switch routeType {
        case "static":
            let path: String = try json <~ ["path"]
            let destination: String = try json <~ ["destination"]
            self = .`static`(path: path, destination: destination)
        case "proxy":
            let path: String = try json <~ ["path"]
            let destination: String = try json <~ ["destination"]
            self = .proxy(path: path, destination: destination)
        default:
            throw App.AppParseError.invalidRouteType(routeType)
        }
    }
    
    public func toJson() -> Json {
        switch self {
        case .`static`(let path, let destination):
            return Json(
                [
                    "type": "static",
                    "path": path,
                    "destination": destination
                ]
            )
        case .proxy(let path, let destination):
            return Json(
                [
                    "type": "proxy",
                    "path": path,
                    "destination": destination
                ]
            )
        }
    }
    
}
