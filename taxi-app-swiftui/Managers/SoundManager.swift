//
//  SoundManager.swift
//  taxi-app-swiftui
//
//  Created by Nikolai Margenov on 4.11.24.
//

import Foundation
import AVFoundation

class SoundManager{
    static let shared = SoundManager()
    var player: AVAudioPlayer!
    
    private init() {}

    func playSound(_ name: String,_ fileType: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: fileType) else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}
