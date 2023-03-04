//
//  RailroadTimeBookApp.swift
//  RailroadTimeBook
//
//  Created by Matthew Hayward on 10/21/22.
//

import SwiftUI
import Firebase

@main
struct RailroadTimeBookApp: App {
    @StateObject var dataManager = DataManager()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ListView()
                .environmentObject(dataManager)
        }
    }
}
