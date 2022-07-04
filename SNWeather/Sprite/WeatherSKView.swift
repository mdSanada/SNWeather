//
//  WeatherSKView.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 04/07/22.
//

import UIKit
import SpriteKit

class WeatherSKView: SKView {
    private let weatherScene: GameScene = GameScene()
    private var nodes: Set<WeatherNode> = []

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.ignoresSiblingOrder = true
        self.showsFPS = false
        self.showsNodeCount = false
        self.configureScene(size: frame.size)
    }
    
    internal func addConditions(_ conditions: [WeatherCondition]) {
        conditions.forEach { condition in
            let node = WeatherNode(condition: condition)
            addAnimation(condition: node)
            addNode(node)
            nodes.insert(node)
        }
    }
    
    internal func removeCondition(_ condition: WeatherCondition) {
        nodes
            .filter { $0.condition == condition }
            .enumerated()
            .forEach { (index, node) in
                if node.condition == .thunderstorm(weight: nil) {
                    weatherScene.stopThunderAnimation()
                }
                node.node?.removeAllActions()
                node.node?.removeFromParent()
                node.node = nil
                nodes.remove(node)
            }
    }
    
    internal func removeAllConditions() {
        nodes.forEach { node in
            if node.condition == .thunderstorm(weight: nil) {
                weatherScene.stopThunderAnimation()
            }
            node.node?.removeAllActions()
            node.node?.removeFromParent()
            node.node = nil
        }
        nodes.removeAll()
    }

    private func configureScene(size: CGSize) {
        weatherScene.configure(size: size)
        self.presentScene(weatherScene)
    }
    
    private func addNode(_ node: WeatherNode) {
        guard let node = node.node else { return }
        weatherScene.addChild(node)
    }
    
    private func addAnimation(condition: WeatherNode) {
        switch condition.condition {
        case .clouds:
            weatherScene.addCloudAnimation(emmiter: condition.node)
        case .rain:
            weatherScene.addRainAnimation(emmiter: condition.node)
        case .thunderstorm(let weight):
            weatherScene.addRainAnimation(emmiter: condition.node)
            let witdhBound = self.frame.width / 4
            weatherScene.addThunderAnimation(starting: CGPoint(x: CGFloat.random(in: (-witdhBound)...(witdhBound)),
                                                               y: self.frame.height / 2),
                                             weight: weight)
        case .snow:
            weatherScene.addSnowAnimation(emmiter: condition.node)
        case .mist:
            weatherScene.addSmokeAnimation(emmiter: condition.node)
        case .drizzle:
            weatherScene.addRainAnimation(emmiter: condition.node)
        case .smoke:
            weatherScene.addSmokeAnimation(emmiter: condition.node)
        case .dust:
            weatherScene.addDustAnimation(emmiter: condition.node)
        case .fog:
            weatherScene.addSmokeAnimation(emmiter: condition.node)
        case .ash:
            weatherScene.addAshesAnimation(emmiter: condition.node)
        case .tornado:
            weatherScene.addWindAnimation(emmiter: condition.node)
        case .clear:
            break
        }
    }
    
}
