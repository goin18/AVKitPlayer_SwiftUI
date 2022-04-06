//
//  ARKitPlayerViewModel.swift
//  AVKitPlayer
//
//  Created by Marko Budal on 29/03/2022.
//

import Foundation

struct Meditation {
    let id = UUID()
    let title: String
    let description: String
    let duration: TimeInterval
    let track: String
    let image: String
    
    static let data = Meditation(title: "1 Minute Relaxing Meditation", description: "In the first part of this course, I’ll show you how to build a meditation app. It could be a music player app too, the concept is the same.", duration: 70, track: "meditation1", image: "image_2")
}

class ARKitPlayerViewModel: ObservableObject {
    private(set) var meditation: Meditation
    
    init(meditation: Meditation) {
        self.meditation = meditation
    }
}
