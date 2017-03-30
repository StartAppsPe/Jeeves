//
//  PerfectExtensions.swift
//  Lanata-App-Backend
//
//  Created by Gabriel Lanata on 11/10/16.
//
//

import PerfectHTTP
import PerfectCURL
import cURL
import Jessie

public extension PerfectHTTP.HTTPRequest {
    
    var postJson: Jessie.Json {
        guard let postBodyBytes = postBodyBytes else {
            return Json.null
        }
        guard let json = try? Json.parse(bytes: postBodyBytes) else {
            var json = Jessie.Json([:])
            for (key, value) in postParams {
                json[key] = Json(value)
            }
            return json
        }
        return json
    }
    
    var queryJson: Jessie.Json {
        var json = Jessie.Json([:])
        for (key, value) in queryParams {
            json[key] = Json(value)
        }
        return json
    }
    
}


public extension PerfectHTTP.HTTPResponse {
    
    func send(_ string: String) {
        self.setHeader(.contentType, value: "text/html")
        self.appendBody(string: string)
        self.completed()
    }
    
    func send(_ json: Jessie.Json, pretty: Bool = false, encoding: String.Encoding = .utf8) {
        let jsonString = json.rawString(pretty: pretty)
        self.setHeader(.contentType, value: "application/json")
        self.setBody(string: jsonString)
        self.completed()
    }
    
    func send(_ status: HTTPResponseStatus) {
        self.status = status
        self.completed()
    }
    
    func send(_ error: Error, message: String? = nil) {
        self.send(.internalServerError, error, message)
    }
    
    func send(_ status: HTTPResponseStatus = .internalServerError, _ error: Error, _ message: String? = nil) {
        let fullMessage: String
        if let message = message {
            fullMessage = "\(message). \(error)"
        } else {
            fullMessage = "\(error)"
        }
        self.setHeader(.contentType, value: "application/json")
        try! self.setBody(json: ["error": true, "message": fullMessage])
        self.status = status
        self.completed()
    }
    
}

fileprivate var CurlPostBodies: [String: [UInt8]] = [:]

extension CURL {
    
    func setHeaders(_ headers: [String: Any]) {
        var curlHeaders = UnsafeMutablePointer<curl_slist>(nil as OpaquePointer?)
        for header in headers {
            curlHeaders = curl_slist_append(curlHeaders, "\(header.key): \(header.value)");
        }
        setOption(CURLOPT_HTTPHEADER, v: curlHeaders!)
    }
    
    func setPostBody(_ body: [UInt8]) {
        CurlPostBodies["A"] = body // TODO: Fix This
        setOption(CURLOPT_POSTFIELDS, v: UnsafeMutableRawPointer(mutating: body))
        setOption(CURLOPT_POSTFIELDSIZE, int: body.count)
    }
    
    func setPostBody(_ body: String) {
        setPostBody([UInt8](body.utf8))
    }
    
    func setPostBody(_ body: Json) {
        setPostBody((try? body.bytes()) ?? [UInt8]())
    }
    
}
