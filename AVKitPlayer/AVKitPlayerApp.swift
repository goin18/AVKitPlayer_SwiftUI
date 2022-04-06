//
//  AVKitPlayerApp.swift
//  AVKitPlayer
//
//  Created by Marko Budal on 26/03/2022.
//

import SwiftUI

@main
struct AVKitPlayerApp: App {
    
    @StateObject var audioManager = AudioManager()
    
    var body: some Scene {
        WindowGroup {
            MedidationView(meditationVM: ARKitPlayerViewModel(meditation: Meditation.data))
                .environmentObject(audioManager)
        }
    }
}
