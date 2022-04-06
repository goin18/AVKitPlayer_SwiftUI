//
//  MedidationView.swift
//  AVKitPlayer
//
//  Created by Marko Budal on 26/03/2022.
//

import SwiftUI

struct MedidationView: View {
    
    @StateObject var meditationVM: ARKitPlayerViewModel
    @State private var showPlayer = false
    
    var body: some View {
        VStack(spacing: 0) {
            Image(meditationVM.meditation.image)
                .resizable()
                .scaledToFill()
                .frame(height: UIScreen.main.bounds.height / 3)
            
            //MARK: Meditation details
            
            ZStack {
                Color(red: 24/255, green: 23/255, blue: 22/255)
                
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Music")
                        
                        Text(DateComponentsFormatter.abbreviated.string(from: meditationVM.meditation.duration) ?? meditationVM.meditation.duration.formatted() + "s")
                    }
                    .font(.subheadline)
                    .textCase(.uppercase)
                    .opacity(0.7)
                    
                    Text(meditationVM.meditation.title)
                        .font(.title)
                    
                    Button {
                        showPlayer = true
                    } label: {
                        Label("Play", systemImage: "play.fill")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .cornerRadius(20)
                    }

                    
                    Text(meditationVM.meditation.description)
                        
                    Spacer()
                }
                .foregroundColor(.white)
                .padding(20)
            }
            .frame(height: UIScreen.main.bounds.height * 2 / 3)
        }
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $showPlayer) {
            PlayerView(meditationVM: meditationVM)
        }
    }
}

struct MedidationView_Previews: PreviewProvider {
    static let meditationVM = ARKitPlayerViewModel(meditation: Meditation.data)
    static var previews: some View {
        MedidationView(meditationVM: meditationVM)
            .environmentObject(AudioManager())
    }
}
