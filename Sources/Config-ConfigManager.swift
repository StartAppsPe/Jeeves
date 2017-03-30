//
//  Config-ConfigManager.swift
//  Jeeves
//
//  Created by Gabriel Lanata on 16/10/16.
//
//

import Foundation
import StartAppsKitLogger
import Jessie

extension Config {
    
    private static let filePath = "file:/Users/Gabriel/Dropbox/Projects/Jeeves/config.json"
    
    // Singleton
    private static var _sharedConfig: Config?
    public static var shared: Config {
        if _sharedConfig == nil {
            try! Config.load()
        }
        return _sharedConfig!
    }
    
    public static func exists() -> Bool {
        let configFile = URL(string: Config.filePath)!
        if let data = try? Data(contentsOf: configFile), data.count > 0 {
            return true
        } else {
            return false
        }
    }
    
    private static func create() throws {
        Log.debug("Config Creating")
        let config = Config.initWithDefaults()
        Log.info("Config Created")
        try config.save()
        _sharedConfig = config
        Log.info("Config Loaded")
    }
    
    public static func load() throws {
        guard Config.exists() else {
            try Config.create()
            return
        }
        Log.debug("Config Loading")
        let configFile = URL(string: Config.filePath)!
        let configData = try Data(contentsOf: configFile)
        let configJson = try Json.parse(data: configData)
        let config = try Config(json: configJson)
        _sharedConfig = config
        Log.info("Config Loaded")
    }
    
    public func save() throws {
        Log.debug("Config Saving")
        let configFile = URL(string: Config.filePath)!
        try toJson().rawString(pretty: true).write(to: configFile, atomically: true, encoding: .utf8)
        Log.info("Config Saved")
    }
    
}
