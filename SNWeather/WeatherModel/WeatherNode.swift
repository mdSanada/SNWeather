//
//  WeatherNode.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 04/07/22.
//

import SpriteKit

class WeatherNode: Hashable {
    var condition: WeatherCondition
    var node: SKEmitterNode?
    var hashValue: Int { return condition.hashValue }
    
    init(condition: WeatherCondition) {
        self.condition = condition
        self.node = condition.getNode()
        let attributes = condition.getAttributes()
        self.node?.particleBirthRate = attributes.birthrate
        self.node?.yAcceleration = attributes.acceleration
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(condition.rawValue)
    }

    static func == (lhs: WeatherNode, rhs: WeatherNode) -> Bool {
        return lhs.condition == rhs.condition
    }
}


struct WeatherNodeAttributes {
    let birthrate: CGFloat, acceleration: CGFloat
}
