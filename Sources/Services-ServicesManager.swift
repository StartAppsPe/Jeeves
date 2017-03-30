//
//  Services-ServicesManager.swift
//  Jeeves
//
//  Created by Gabriel Lanata on 27/3/17.
//
//

import Foundation
import StartAppsKitLogger
import Jessie

extension Services {
    
    private static let filePath = "file:/Users/Gabriel/Dropbox/Projects/Jeeves/services.json"
    
    // Singleton
    private static var _sharedServices: Services?
    public static var shared: Services {
        if _sharedServices == nil {
            try! Services.load()
        }
        return _sharedServices!
    }
    
    public static func load() throws {
        Log.debug("Services Loading")
        let servicesFile = URL(string: Services.filePath)!
        let servicesData = try Data(contentsOf: servicesFile)
        let servicesJson = try Json.parse(data: servicesData)
        let services = try Services(json: servicesJson)
        _sharedServices = services
        Log.info("Services Loaded")
    }
    
}
