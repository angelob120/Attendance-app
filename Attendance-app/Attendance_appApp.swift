//
//  Attendance_appApp.swift
//  Attendance-app
//
//  Created by AB on 9/11/24.
//

import SwiftUI
import SwiftData

@main
struct Attendance_appApp: App {
    @StateObject var clubManagerVM = clubManager()
  ///  The model container sets up the data persistence layer for the app. It's placed in the App struct because of the shared ModelContainer for your the  app, and the App struct is the entry point of SwiftUI app.
    ///
    ///  Wtihout the Model container there will be loss of data persistence and functionality loss.
    ///
    ///  Application will likely crash on occasions
    ///
    ///  Loss of schema.
    
    
    
    
    
    
    

    var body: some Scene {
        WindowGroup {
            ContentMainView()
            
                .environmentObject(clubManagerVM)

        }
        
    }
}
