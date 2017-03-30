//
//  Agnostic-Server.swift
//  Jeeves
//
//  Created by Gabriel Lanata on 27/12/16.
//
//

let DefaultPort = 8080
let DefaultHost = "0.0.0.0"

protocol AgnosticServer {
    
    var port: Int { get }
    var host: String { get }
    
    func start(port: Int, host: String) throws
    
}
