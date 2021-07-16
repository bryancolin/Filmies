//
//  FilmiesApp.swift
//  Filmies
//
//  Created by bryan colin on 7/9/21.
//

import SwiftUI

@main
struct FilmiesApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
