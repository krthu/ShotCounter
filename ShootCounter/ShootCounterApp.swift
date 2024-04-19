//
//  ShootCounterApp.swift
//  ShootCounter
//
//  Created by Kristian Thun on 2024-04-18.
//

import SwiftUI
import SwiftData

@main
struct ShootCounterApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Game.self)
    }
    
    
}
