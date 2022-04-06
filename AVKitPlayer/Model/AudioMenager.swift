//
//  AudioMenager.swift
//  AVKitPlayer
//
//  Created by Marko Budal on 29/03/2022.
//

import Foundation
import AVKit

//class AudioManager {
//    static let shared = AudioManager()
//
//    var player: AVAudioPlayer?
//
//    func startPlayer(track: String, isPreview: Bool = false) {
//        guard let url = Bundle.main.url(forResource: track, withExtension: "mp3") else {
//            print("Resource not found: \(track)")
//            return
//        }
//
//        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
//            try AVAudioSession.sharedInstance().setActive(true)
//            player = try AVAudioPlayer(contentsOf: url)
//
//            if isPreview {
//                player?.prepareToPlay()
//            } else {
//                player?.play()
//            }
//        } catch {
//            print("Fail to init player!", error)
//        }
//    }
//}

class AudioManager: ObservableObject {
    var player: AVAudioPlayer?
    @Published private(set) var isPlaying: Bool = false {
        didSet {
            print("isPlaing: \(isPlaying)")
            return
        }
    }
    
    @Published private(set) var isLooping: Bool = false
    
    func startPlayer(track: String, isPreview: Bool = false) {
        guard let url = Bundle.main.url(forResource: track, withExtension: "mp3") else {
            print("Resource not found: \(track)")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url)
            
            if isPreview {
                player?.prepareToPlay()
            } else {
                player?.play()
                isPlaying = true
            }
        } catch {
            print("Fail to init player!", error)
        }
    }
    
    func playPause() {
        guard let player = player else {
            return
        }
        
        if player.isPlaying {
            player.pause()
            isPlaying = false
        } else {
            player.play()
            isPlaying = true
        }
    }
    
    func stop() {
        guard let player = player else { return }
        if player.isPlaying {
            player.stop()
            isPlaying = false
        }
    }
    
    func toggleLoop() {
        guard let player = player else { return }
        
        player.numberOfLoops = player.numberOfLoops == 0 ? -1 : 0
        isLooping = player.numberOfLoops != 0
        print("isLooping", isLooping)
    }
}

