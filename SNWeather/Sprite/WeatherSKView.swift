//
//  WeatherSKView.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 04/07/22.
//

import UIKit
import SpriteKit

class WeatherSKView: SKView {
    init(frame: CGRect, scene: GameScene) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.ignoresSiblingOrder = true
        self.showsFPS = false
        self.showsNodeCount = false
        self.presentScene(scene)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
