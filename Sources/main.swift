    
import Foundation
import StartAppsKitLogger

do {
    
    // Set log level
    Log.level = .verbose
    Log.info("Logging level: \(Log.level)")
    
    // Load config and services files
    try Services.load()
    try Config.load()
    
    // Create HTTP server.
    let server: Server = Server()
    
    // Add the routes to the server.
    Log.debug("Jeeves adding API routes")
    server.addRoutes(ApiRoutesGeneral)
    server.addRoutes(ApiRoutesApps)
    server.addRoutes(ApiRoutesServices)
    Log.info("Jeeves added API routes")
    
//    Log.debug("Server adding APP routes")
//    server.addRoutes(AppRoutes)
//    Log.info("Server added APP routes")
    
    //Command.test()
    
    // Initialize server
    let host = Config.shared.jeevesHost
    let port = Config.shared.jeevesPort
    Log.info("Jeeves starting: \(host):\(port)")
    try server.start(port: port, host: host)
    Log.info("Jeeves started: \(host):\(port)")
    
} catch {
    
    Log.error("Jeeves error thrown: \(error)")
    //abort() // Crash
    
}





