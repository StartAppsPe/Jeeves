//
//  Api-Routes-General.swift
//  Jeeves
//
//  Created by Gabriel Lanata on 28/3/17.
//
//

import PerfectHTTP
import StartAppsKitExtensions
import Jessie

var ApiRoutesGeneral: Routes {
    
    var routes = Routes(baseUri: "/api")
    
    routes.add(method: .get, uri: "/alive") { request, response in
        response.send("Hello Jeeves")
    }
        
    return routes
    
}
