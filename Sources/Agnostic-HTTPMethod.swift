//
//  Agnostic-HTTPMethod.swift
//  Jeeves
//
//  Created by Gabriel Lanata on 28/12/16.
//
//

public enum HTTPMethod: Hashable, CustomStringConvertible {

    case options
    case get
    case head
    case post
    case put
    case delete
    case trace
    case connect
    case custom(String)
    
    public static func from(string: String) -> HTTPMethod {
        switch string {
        case "OPTIONS": return .options
        case "GET":     return .get
        case "HEAD":    return .head
        case "POST":    return .post
        case "PUT":     return .put
        case "DELETE":  return .delete
        case "TRACE":   return .trace
        case "CONNECT": return .connect
        default:        return .custom(string)
        }
    }
    
    /// Method String hash value
    public var hashValue: Int {
        return self.description.hashValue
    }
    
    /// The method as a String
    public var description: String {
        switch self {
        case .options:  return "OPTIONS"
        case .get:      return "GET"
        case .head:     return "HEAD"
        case .post:     return "POST"
        case .put:      return "PUT"
        case .delete:   return "DELETE"
        case .trace:    return "TRACE"
        case .connect:  return "CONNECT"
        case .custom(let s): return s
        }
    }
}

/// Compare two HTTP methods
public func == (lhs: HTTPMethod, rhs: HTTPMethod) -> Bool {
    return lhs.description == rhs.description
}
