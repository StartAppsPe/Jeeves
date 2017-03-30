//
//  Command-CommandManager.swift
//  Jeeves
//
//  Created by Gabriel Lanata on 30/10/16.
//
//

import Foundation
import SwiftShell
import StartAppsKitLogger

enum Bash {
    
    struct BashError: Error {
        let message: String
        var localizedDescription: String {
            return message
        }
    }
    
    static func run(_ bash: String, expected: String? = nil) throws -> String {
        Log.verbose("Bash will run command \"\(bash)\"")
        
//        
//        
//        let output = SwiftShell.run(bash)
//        if let expected = expected, !output.contains(expected) {
//            throw BashError(message: "Output does not contain expected: \(expected)")
//        }
//        return output
//        
//        
        
        let task = runAsync(bash: bash)
        do {
            try task.finish()
            let output = task.stdout.read()
            Log.info("Bash OUTPUT1: |\(output)|")
            if let expected = expected?.clean(), !output.contains(expected) {
                throw BashError(message: "Output does not contain expected: \(expected)")
            }
            return output
        } catch {
            let output = task.stderror.read().trimmingCharacters(in: .whitespacesAndNewlines)
            throw BashError(message: output)
        }
    }
    
    static func test() {
        let result = try! run("cd /Users/Gabriel/Desktop/JeevesTests && mkdir Hola2 && ls")
        print("result",result)
    }
    
}
