//
//  SystemSoundPlayer.swift
//  My Furnace Backups
//
//  Created by Diggo Silva on 12/06/25.
//

import AppKit

struct SystemSoundPlayer {
    
    static func play(named name: String) {
        NSSound(named: NSSound.Name(name))?.play()
    }
    
    static func playSuccess() {
        play(named: "Glass")
    }
    
    static func playError() {
        play(named: "Basso")
    }
}
