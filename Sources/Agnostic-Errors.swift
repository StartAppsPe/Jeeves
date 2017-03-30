//
//  Agnostic-Errors.swift
//  Aprils-App-Backend
//
//  Created by Gabriel Lanata on 18/10/16.
//
//

enum ServerError: Error, CustomStringConvertible {
    case networkError(String)
    
    public var description: String {
        switch self {
        case .networkError(let message): return message
        }
    }
}

struct Abort: Error, CustomStringConvertible {
    
    let status: HTTPStatus
    let message: String?
    
    init(_ status: HTTPStatus, _ message: String? = nil) {
        self.status = status
        self.message = message
    }
    
    public var description: String {
        return message ?? status.description
    }
    
}
