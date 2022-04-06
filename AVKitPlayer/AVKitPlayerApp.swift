//
//  AVKitPlayerApp.swift
//  AVKitPlayer
//
//  Created by Marko Budal on 26/03/2022.
//

import SwiftUI

@main
struct AVKitPlayerApp: App {
    
    @StateObject var audioMenager = AudioMenager()
    
    var body: some Scene {
        WindowGroup {
            MedidationView(meditationVM: ARKitPlayerViewModel(meditation: Meditation.data))
                .environmentObject(audioMenager)
        }
    }
}
