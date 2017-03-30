////
////  Routes-Apps.swift
////  Jeeves
////
////  Created by Gabriel Lanata on 28/3/17.
////
////
//
//import Foundation
//import PerfectHTTP
//import PerfectCURL
//import cURL
//import StartAppsKitExtensions
//import StartAppsKitLogger
//import Jessie
//
//var AppRoutes: Routes {
//    
//    var routes = Routes()
//    
//    for app in Config.shared.apps {
//        
//        for route in app.routes {
//            
//            switch route {
//            case .proxy(var path, var destination):
//                path = path.addLeadingSlash()
//                destination = destination.removeLeadingSlash()
//                routes.add(method: .get, uri: path, handler: { request, response in
//                    if let routeTrailingWildcard = request.urlVariables[routeTrailingWildcardKey] {
//                        request.path = routeTrailingWildcard
//                    }
//                    let handler = ProxyHandler(forwardUrl: "\(destination)")
//                    handler.handleRequest(request: request, response: response)
//                })
//            case .static(var path, var destination):
//                path = path.addLeadingSlash()
//                destination = destination.removeLeadingSlash()
//                routes.add(method: .get, uri: path, handler: { request, response in
//                    if let routeTrailingWildcard = request.urlVariables[routeTrailingWildcardKey] {
//                        request.path = routeTrailingWildcard
//                    }
//                    let handler = StaticFileHandler(documentRoot: "\(app.rootDir)\(destination)")
//                    handler.handleRequest(request: request, response: response)
//                })
//            }
//            
//        }
//        
//    }
//    
//    return routes
//    
//}
//
//public struct ProxyHandler {
//    
//    let forwardUrl: String
//    
//    /// Public initializer given a document root.
//    /// If allowResponseFilters is false (which is the default) then the file will be sent in
//    /// the most effecient way possible and output filters will be bypassed.
//    public init(forwardUrl: String) {
//        self.forwardUrl = forwardUrl
//    }
//    
//    /// Main entry point. A registered URL handler should call this and pass the request and response objects.
//    /// After calling this, the StaticFileHandler owns the request and will handle it until completion.
//    public func handleRequest(request: HTTPRequest, response: HTTPResponse) {
//        var path = request.path
//        
//        // Create request
//        let curl = CURL(url: forwardUrl)
//        curl.setOption(CURLOPT_USERAGENT, s: "Jeeves CURL")
//        curl.setOption(CURLOPT_VERBOSE, int: 1)
//        
//        // Set headers
//        var headers: [String:String] = [:]
//        for headerRaw in request.headers {
//            headers[headerRaw.0.standardName] = headerRaw.1
//        }
//        curl.setHeaders(headers)
//        
//        // Set body
//        if let postBody = request.postBodyBytes {
//            curl.setPostBody(postBody)
//        }
//        
//        Log.info("Proxy performing request to \(forwardUrl)")
//        curl.perform { code, header, body in
//            Log.info("Proxy finished request to \(self.forwardUrl)")
//            do {
//                let response = try String(data: Data(body))
//                print("responseresponse",response)
//                guard code == 0 else {
//                    throw Abort(.badRequest, "Error enviando alarma, Codigo de resultado \(code) inválido")
//                }
//                
//                response.
//                completion(nil)
//            } catch {
//                completion(error)
//                
//                response.send
//            }
//        }
//        
//        
//        
//        
//        do {
//            try file.open(.read)
//            self.sendFile(request: request, response: response, file: file)
//        } catch {
//            return fnf(msg: "The file \(path) could not be opened \(error).")
//        }
//    }
//    
//    
//    
//    
//    
//    
//}
//
//extension String {
//    
//    func addLeadingSlash() -> String {
//        var newString = self
//        if newString.characters.first != "/" {
//            return "/\(newString)"
//        }
//        return newString
//    }
//    
//    func removeLeadingSlash() -> String {
//        var newString = self
//        if newString.characters.first == "/" {
//            newString.characters = newString.characters.dropFirst()
//        }
//        return newString
//    }
//    
//}
