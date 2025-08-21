//
//  HighlightButton.swift
//  My Furnace Backups
//
//  Created by Diggo Silva on 19/05/25.
//

import Cocoa

class HighlightButton: NSButton {

    private var defaultBackgroundColor: NSColor = .systemBlue
    private var highlightedBackgroundColor: NSColor = .systemBlue.withAlphaComponent(0.7)

    override func updateLayer() {
        super.updateLayer()
        layer?.backgroundColor = isHighlighted
            ? highlightedBackgroundColor.cgColor
            : defaultBackgroundColor.cgColor
    }

    func setBackgroundColor(_ color: NSColor) {
        defaultBackgroundColor = color
        highlightedBackgroundColor = color.withAlphaComponent(0.7)
        wantsLayer = true
        layer?.backgroundColor = color.cgColor
        layer?.cornerRadius = 5
        layer?.masksToBounds = true
    }
}
