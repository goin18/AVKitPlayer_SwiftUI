//
//  PlayerView.swift
//  AVKitPlayer
//
//  Created by Marko Budal on 26/03/2022.
//

import SwiftUI

struct PlayerView: View {
    @EnvironmentObject var audioMengaer: AudioMenager
    var meditationVM: ARKitPlayerViewModel
    var isPreview: Bool = false
    @State private var value: Double = 0.0
    @State private var isEditiong = false
    
    @Environment(\.dismiss) var dismiss
    
    let timer = Timer
        .publish(every: 0.5, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        ZStack {
            Image("image_2")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width)
                .ignoresSafeArea()
            
            Rectangle()
                .background(.thinMaterial)
                .opacity(0.25)
                .ignoresSafeArea()
            
            VStack(spacing: 32) {
                HStack {
                    Button {
                        audioMengaer.stop()
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size:  36))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                }
                
                Text(meditationVM.meditation.title)
                    .font(.title)
                    .foregroundColor(.white)
                
                Spacer()
                
                if let player = audioMengaer.player {
                    VStack(spacing: 5) {
                        Slider(value: $value, in: 0...player.duration) { editing in
                            isEditiong = editing
                            if !editing {
                                player.currentTime = value
                            }
                        }
                            .accentColor(.white)
                        
                        HStack {
                            Text(DateComponentsFormatter.positional.string(from: player.currentTime) ?? "0:00")
                            Spacer()
                            Text(DateComponentsFormatter.positional.string(from: player.duration - player.currentTime) ?? "0:00")
                        }
                        .font(.caption)
                        .foregroundColor(.white)
                    }
                    
                    HStack {
                        let color: Color = audioMengaer.isLooping ? .teal : .white
                        PlaybackControlButton(systemName: "repeat", color: color) {
                            audioMengaer.toggleLoop()
                        }
                        
                        Spacer()
                        
                        PlaybackControlButton(systemName: "gobackward.10") {
                            player.currentTime -= 10
                        }
                        
                        Spacer()
                        
                        PlaybackControlButton(systemName: audioMengaer.isPlaying ? "pause.circle.fill":"play.circle.fill", fontSize: 44) {
                            audioMengaer.playPause()
                        }
                        
                        Spacer()
                        
                        PlaybackControlButton(systemName: "goforward.10") {
                            player.currentTime += 10
                        }
                        
                        Spacer()
                        
                        PlaybackControlButton(systemName: "stop.fill") {
                            audioMengaer.stop()
                            dismiss()
                        }
                    }
                    .padding(20)
                }
               
                }
            .padding()
        }
        .onAppear {
//            AudioMenager.shared.startPlayer(track: meditationVM.meditation.track, isPreview: isPreview)
            audioMengaer.startPlayer(track: meditationVM.meditation.track, isPreview: isPreview)
        }
        .onReceive(timer) { _ in
            guard let player = audioMengaer.player, !isEditiong else { return }
            value = player.currentTime
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static let meditationVM = ARKitPlayerViewModel(meditation: Meditation.data)
    static var previews: some View {
        PlayerView(meditationVM: meditationVM, isPreview: true)
            .environmentObject(AudioMenager())
    }
}
