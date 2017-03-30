//
//  Agnostic-Perfect-Server.swift
//  Jeeves
//
//  Created by Gabriel Lanata on 27/12/16.
//
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

public typealias Server = PerfectHTTPServer.HTTPServer

extension Server: AgnosticServer {
    
    public var port: Int {
        return Int(serverPort)
    }
    public var host: String {
        return serverAddress
    }
    
    public func start(port: Int = DefaultPort, host: String = DefaultHost) throws {
        serverPort = UInt16(port)
        serverAddress = host
        try start()
    }
    
}

//public typealias RouteGroup = PerfectHTTP.Routes

//extension RouteGroup: AgnosticRouteGroup {

    
//    func addRosute(_ route: Route) {
//        let newRoute: PerfectHTTP.Route = PerfectHTTP.Route(method: .get, uri: "") { (request, response) in
//            route.handler(request, response)
//        }
//        let newRoutes: PerfectHTTP.Routes = Routes(baseUri: "/", routes: [newRoute])
//        addRoutes(newRoutes)
//    }
    
//    func addRoute(method: HTTPMethod, uri: String, handler: @escaping Route.RouteHandler) {
//        routes.append(Route(method: method, uri: uri, handler: handler))
//    }
//    
//    func addRouteGroup(_ routeGroup: RouteGroup) {
//        routeGroups.append(routeGroup)
//    }
//    
//    func addRouteGroup(baseUri: String? = nil, routes: RouteAdder) {
//        routeGroups.append(RouteGroup(baseUri: baseUri, routes: routes))
//    }
//    
//}
