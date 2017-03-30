//
//  Config-App-Status.swift
//  Jeeves
//
//  Created by Gabriel Lanata on 30/3/17.
//
//

import Foundation
import StartAppsKitLogger
import Jessie

extension App {
    
    enum Status: Int {
        case ok = 100, warning = 60, error = 30, disabled = 0
    }
    
    var statusGit: Status {
        guard git != nil else { return .disabled }
        do {
            let response = try Bash.run("cd \(rootDir) && git status", expected: nil)
            if response.contains("up-to-date") { return .ok }
            if response.contains("ahead") || response.contains("behind") { return .warning }
            return .error
        } catch {
            Log.error(error)
            return .error
        }
    }
    
    var statusJson: Json {
        return Json(
            [
                "git":statusGit.rawValue
            ]
        )
    }
    
}
