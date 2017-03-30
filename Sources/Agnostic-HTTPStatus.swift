//
//  Jasper-Errors.swift
//  Aprils-App-Backend
//
//  Created by Gabriel Lanata on 18/10/16.
//
//

enum HTTPStatus {
    
    // ### Custom
    case custom(code: Int, message: String)
    
    // 100 Informational
    case `continue`
    case switchingProtocols
    case processing
    
    // 200 Success
    case ok
    case created
    case accepted
    case nonAuthoritativeInformation
    case noContent
    case resetContent
    case partialContent
    case multiStatus
    case alreadyReported
    
    // 300 Redirection
    case multipleChoices
    case movedPermanently
    case found
    case seeOther
    case notModified
    case useProxy
    case temporaryRedirect
    case permanentmRedirect
    
    // 400 Client Error
    case badRequest
    case unauthorized
    case paymentRequired
    case forbidden
    case notFound
    case methodNotAllowed
    case notAcceptable
    case proxyAuthenticationRequired
    case requestTimeout
    case conflict
    case gone
    case lengthRequired
    case preconditionFailed
    case payloadTooLarge
    case requestUriTooLong
    case unsupportedMediaType
    case requestedRangeNotSatisfiable
    case expectationFailed
    case imATeapot
    case misdirectedRequest
    case unprocessableEntity
    case locked
    case failedDependency
    case upgradeRequired
    case preconditionRequired
    case tooManyRequests
    case requestHeaderFieldsToo
    case connectionClosedWithoutResponse
    case unavailableForLegalReasons
    case clientClosedRequest
    
    // 500 Server Error
    case internalServerError
    case notImplemented
    case badGateway
    case serviceUnavailable
    case gatewayTimeout
    case httpVersionNotSupported
    case variantAlsoNegotiates
    case insufficientStorage
    case loopDetected
    case notExtended
    case networkAuthenticationRequired
    case networkConnectTimeoutError

    public var description: String {
        switch self {
        case .continue:                         return "\(code) Continue"
        case .switchingProtocols:               return "\(code) Switching Protocols"
        case .processing:                       return "\(code) Processing"
        case .ok:                               return "\(code) OK"
        case .created:                          return "\(code) Created"
        case .accepted:                         return "\(code) Accepted"
        case .nonAuthoritativeInformation:      return "\(code) Non-authoritative Information"
        case .noContent:                        return "\(code) No Content"
        case .resetContent:                     return "\(code) Reset Content"
        case .partialContent:                   return "\(code) Partial Content"
        case .multiStatus:                      return "\(code) Multi-Status"
        case .alreadyReported:                  return "\(code) Already Reported"
        case .multipleChoices:                  return "\(code) Multiple Choices"
        case .movedPermanently:                 return "\(code) Moved Permanently"
        case .found:                            return "\(code) Found"
        case .seeOther:                         return "\(code) See Other"
        case .notModified:                      return "\(code) Not Modified"
        case .useProxy:                         return "\(code) Use Proxy"
        case .temporaryRedirect:                return "\(code) Temporary Redirect"
        case .permanentmRedirect:               return "\(code) PermanentmRedirect"
        case .badRequest:                       return "\(code) Bad Request"
        case .unauthorized:                     return "\(code) Unauthorized"
        case .paymentRequired:                  return "\(code) Payment Required"
        case .forbidden:                        return "\(code) Forbidden"
        case .notFound:                         return "\(code) Not Found"
        case .methodNotAllowed:                 return "\(code) Method Not Allowed"
        case .notAcceptable:                    return "\(code) Not Acceptable"
        case .proxyAuthenticationRequired:      return "\(code) Proxy Authentication Required"
        case .requestTimeout:                   return "\(code) Request Timeout"
        case .conflict:                         return "\(code) Conflict"
        case .gone:                             return "\(code) Gone"
        case .lengthRequired:                   return "\(code) Length Required"
        case .preconditionFailed:               return "\(code) Precondition Failed"
        case .payloadTooLarge:                  return "\(code) Payload Too Large"
        case .requestUriTooLong:                return "\(code) Request-URI Too Long"
        case .unsupportedMediaType:             return "\(code) Unsupported Media Type"
        case .requestedRangeNotSatisfiable:     return "\(code) Requested Range Not Satisfiable"
        case .expectationFailed:                return "\(code) Expectation Failed"
        case .imATeapot:                        return "\(code) I'm a Teapot"
        case .misdirectedRequest:               return "\(code) Misdirected Request"
        case .unprocessableEntity:              return "\(code) Unprocessable Entity"
        case .locked:                           return "\(code) Locked"
        case .failedDependency:                 return "\(code) Failed Dependency"
        case .upgradeRequired:                  return "\(code) Upgrade Required"
        case .preconditionRequired:             return "\(code) Precondition Required"
        case .tooManyRequests:                  return "\(code) Too Many Requests"
        case .requestHeaderFieldsToo:           return "\(code) Request Header Fields Too"
        case .connectionClosedWithoutResponse:  return "\(code) Connection Closed Without Response"
        case .unavailableForLegalReasons:       return "\(code) Unavailable For Legal Reasons"
        case .clientClosedRequest:              return "\(code) Client Closed Request"
        case .internalServerError:              return "\(code) Internal Server Error"
        case .notImplemented:                   return "\(code) Not Implemented"
        case .badGateway:                       return "\(code) Bad Gateway"
        case .serviceUnavailable:               return "\(code) Service Unavailable"
        case .gatewayTimeout:                   return "\(code) Gateway Timeout"
        case .httpVersionNotSupported:          return "\(code) HTTP Version Not Supported"
        case .variantAlsoNegotiates:            return "\(code) Variant Also Negotiates"
        case .insufficientStorage:              return "\(code) Insufficient Storage"
        case .loopDetected:                     return "\(code) Loop Detected"
        case .notExtended:                      return "\(code) Not Extended"
        case .networkAuthenticationRequired:    return "\(code) Network Authentication Required"
        case .networkConnectTimeoutError:       return "\(code) Network Connect Timeout Error"
        case .custom(let code, let message):    return "\(code) \(message)"
        }
    }
    
    public init(code: Int) {
        switch code {
        case 100: self = .continue
        case 101: self = .switchingProtocols
        case 102: self = .processing
        case 200: self = .ok
        case 201: self = .created
        case 202: self = .accepted
        case 203: self = .nonAuthoritativeInformation
        case 204: self = .noContent
        case 205: self = .resetContent
        case 206: self = .partialContent
        case 207: self = .multiStatus
        case 208: self = .alreadyReported
        case 300: self = .multipleChoices
        case 301: self = .movedPermanently
        case 302: self = .found
        case 303: self = .seeOther
        case 304: self = .notModified
        case 305: self = .useProxy
        case 307: self = .temporaryRedirect
        case 308: self = .permanentmRedirect
        case 400: self = .badRequest
        case 401: self = .unauthorized
        case 402: self = .paymentRequired
        case 403: self = .forbidden
        case 404: self = .notFound
        case 405: self = .methodNotAllowed
        case 406: self = .notAcceptable
        case 407: self = .proxyAuthenticationRequired
        case 408: self = .requestTimeout
        case 409: self = .conflict
        case 410: self = .gone
        case 411: self = .lengthRequired
        case 412: self = .preconditionFailed
        case 413: self = .payloadTooLarge
        case 414: self = .requestUriTooLong
        case 415: self = .unsupportedMediaType
        case 416: self = .requestedRangeNotSatisfiable
        case 417: self = .expectationFailed
        case 418: self = .imATeapot
        case 421: self = .misdirectedRequest
        case 422: self = .unprocessableEntity
        case 423: self = .locked
        case 424: self = .failedDependency
        case 426: self = .upgradeRequired
        case 428: self = .preconditionRequired
        case 429: self = .tooManyRequests
        case 431: self = .requestHeaderFieldsToo
        case 444: self = .connectionClosedWithoutResponse
        case 451: self = .unavailableForLegalReasons
        case 499: self = .clientClosedRequest
        case 500: self = .internalServerError
        case 501: self = .notImplemented
        case 502: self = .badGateway
        case 503: self = .serviceUnavailable
        case 504: self = .gatewayTimeout
        case 505: self = .httpVersionNotSupported
        case 506: self = .variantAlsoNegotiates
        case 507: self = .insufficientStorage
        case 508: self = .loopDetected
        case 510: self = .notExtended
        case 511: self = .networkAuthenticationRequired
        case 599: self = .networkConnectTimeoutError
        default:  self = .custom(code: code, message: "Custom")
        }
    }
    
    public var code: Int {
        switch self {
        case .continue:                         return 100
        case .switchingProtocols:               return 101
        case .processing:                       return 102
        case .ok:                               return 200
        case .created:                          return 201
        case .accepted:                         return 202
        case .nonAuthoritativeInformation:      return 203
        case .noContent:                        return 204
        case .resetContent:                     return 205
        case .partialContent:                   return 206
        case .multiStatus:                      return 207
        case .alreadyReported:                  return 208
        case .multipleChoices:                  return 300
        case .movedPermanently:                 return 301
        case .found:                            return 302
        case .seeOther:                         return 303
        case .notModified:                      return 304
        case .useProxy:                         return 305
        case .temporaryRedirect:                return 307
        case .permanentmRedirect:               return 308
        case .badRequest:                       return 400
        case .unauthorized:                     return 401
        case .paymentRequired:                  return 402
        case .forbidden:                        return 403
        case .notFound:                         return 404
        case .methodNotAllowed:                 return 405
        case .notAcceptable:                    return 406
        case .proxyAuthenticationRequired:      return 407
        case .requestTimeout:                   return 408
        case .conflict:                         return 409
        case .gone:                             return 410
        case .lengthRequired:                   return 411
        case .preconditionFailed:               return 412
        case .payloadTooLarge:                  return 413
        case .requestUriTooLong:                return 414
        case .unsupportedMediaType:             return 415
        case .requestedRangeNotSatisfiable:     return 416
        case .expectationFailed:                return 417
        case .imATeapot:                        return 418
        case .misdirectedRequest:               return 421
        case .unprocessableEntity:              return 422
        case .locked:                           return 423
        case .failedDependency:                 return 424
        case .upgradeRequired:                  return 426
        case .preconditionRequired:             return 428
        case .tooManyRequests:                  return 429
        case .requestHeaderFieldsToo:           return 431
        case .connectionClosedWithoutResponse:  return 444
        case .unavailableForLegalReasons:       return 451
        case .clientClosedRequest:              return 499
        case .internalServerError:              return 500
        case .notImplemented:                   return 501
        case .badGateway:                       return 502
        case .serviceUnavailable:               return 503
        case .gatewayTimeout:                   return 504
        case .httpVersionNotSupported:          return 505
        case .variantAlsoNegotiates:            return 506
        case .insufficientStorage:              return 507
        case .loopDetected:                     return 508
        case .notExtended:                      return 510
        case .networkAuthenticationRequired:    return 511
        case .networkConnectTimeoutError:       return 599
        case .custom(let code, _):              return code
        }
    }
    
}
