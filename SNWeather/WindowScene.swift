//
//  WindowScene.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 04/07/22.
//

import Cocoa

class WindowController: NSWindowController {
    
    override func windowDidLoad() {
        super.windowDidLoad()
        window?.titlebarAppearsTransparent = true
        window?.styleMask.insert(.fullSizeContentView)
        window?.titleVisibility = .hidden
        window?.styleMask.insert(.fullSizeContentView)
        window?.contentView?.wantsLayer = true
        if #available(OSX 10.14, *) {
            window?.appearance = NSAppearance(named: .darkAqua)
        }
    }
    
}
