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
    
    private init() {} // Make the initializer private to enforce singleton

    func playSound(_ name: String,_ fileType: String) {
        if let url = Bundle.main.url(forResource: name, withExtension: fileType){
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
