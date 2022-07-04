//
//  WeatherCondition.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 04/07/22.
//

import Foundation
import SpriteKit

enum WeatherWeight {
    case light
    case moderate
    case heavy
}

enum WeatherCondition: Equatable, Hashable {
    case clouds(weight: WeatherWeight?)
    case rain(weight: WeatherWeight?)
    case thunderstorm(weight: WeatherWeight?)
    case snow(weight: WeatherWeight?)
    case mist(weight: WeatherWeight?)
    case drizzle(weight: WeatherWeight?)
    case smoke(weight: WeatherWeight?)
    case dust(weight: WeatherWeight?)
    case fog(weight: WeatherWeight?)
    case ash(weight: WeatherWeight?)
    case tornado(weight: WeatherWeight?)
    case clear
    
    internal var rawValue: String {
        switch self {
        case .clouds:
            return "Clouds"
        case .rain:
            return "Rain"
        case .thunderstorm:
            return "Thunderstorm"
        case .snow:
            return "Snow"
        case .mist:
            return "Mist"
        case .drizzle:
            return "Drizzle"
        case .smoke:
            return "Smoke"
        case .dust:
            return "Dust"
        case .fog:
            return "Fog"
        case .ash:
            return "Ash"
        case .tornado:
            return "Tornado"
        case .clear:
            return "Clear"
        }
    }

    static func ==(lhs: WeatherCondition, rhs: WeatherCondition) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
    
    func getNode() -> SKEmitterNode? {
        switch self {
        case .clouds:
            return SKEmitterNode(fileNamed: "Cloud.sks")
        case .rain:
            return SKEmitterNode(fileNamed: "Rain.sks")
        case .thunderstorm:
            return SKEmitterNode(fileNamed: "Rain.sks")
        case .snow:
            return SKEmitterNode(fileNamed: "Snow.sks")
        case .mist:
            return SKEmitterNode(fileNamed: "Smoke.sks")
        case .drizzle:
            return SKEmitterNode(fileNamed: "Rain.sks")
        case .smoke:
            return SKEmitterNode(fileNamed: "Smoke.sks")
        case .dust:
            return SKEmitterNode(fileNamed: "Dust.sks")
        case .fog:
            return SKEmitterNode(fileNamed: "Smoke.sks")
        case .ash:
            return SKEmitterNode(fileNamed: "Ashes.sks")
        case .tornado:
            return SKEmitterNode(fileNamed: "Wind.sks")
        case .clear:
            return nil
        }
    }
    
    func getAttributes() -> WeatherNodeAttributes {
        switch self {
        case .clouds(let weight):
            switch weight {
            case .heavy:
                return WeatherNodeAttributes(birthrate: 40, acceleration: 15)
            case .light:
                return WeatherNodeAttributes(birthrate: 10, acceleration: 8)
            default:
                return WeatherNodeAttributes(birthrate: 20, acceleration: 10)
            }
        case .rain(let weight):
            switch weight {
            case .heavy:
                return WeatherNodeAttributes(birthrate: 600, acceleration: -350)
            case .light:
                return WeatherNodeAttributes(birthrate: 200, acceleration: -200)
            default:
                return WeatherNodeAttributes(birthrate: 350, acceleration: -200)
            }
        case .thunderstorm(let weight):
            switch weight {
            case .heavy:
                return WeatherNodeAttributes(birthrate: 600, acceleration: -350)
            case .light:
                return WeatherNodeAttributes(birthrate: 200, acceleration: -200)
            default:
                return WeatherNodeAttributes(birthrate: 350, acceleration: -200)
            }
        case .snow(let weight):
            switch weight {
            case .heavy:
                return WeatherNodeAttributes(birthrate: 350, acceleration: -100)
            case .light:
                return WeatherNodeAttributes(birthrate: 40, acceleration: -10)
            default:
                return WeatherNodeAttributes(birthrate: 120, acceleration: -50)
            }
        case .mist(let weight):
            switch weight {
            case .heavy:
                return WeatherNodeAttributes(birthrate: 20, acceleration: 20)
            case .light:
                return WeatherNodeAttributes(birthrate: 2, acceleration: 10)
            default:
                return WeatherNodeAttributes(birthrate: 5, acceleration: 15)
            }
        case .drizzle(let weight):
            switch weight {
            case .heavy:
                return WeatherNodeAttributes(birthrate: 20, acceleration: 20)
            case .light:
                return WeatherNodeAttributes(birthrate: 2, acceleration: 10)
            default:
                return WeatherNodeAttributes(birthrate: 5, acceleration: 15)
            }
        case .smoke(let weight):
            switch weight {
            case .heavy:
                return WeatherNodeAttributes(birthrate: 20, acceleration: 20)
            case .light:
                return WeatherNodeAttributes(birthrate: 2, acceleration: 10)
            default:
                return WeatherNodeAttributes(birthrate: 5, acceleration: 15)
            }
        case .dust(let weight):
            switch weight {
            case .heavy:
                return WeatherNodeAttributes(birthrate: 20, acceleration: 20)
            case .light:
                return WeatherNodeAttributes(birthrate: 2, acceleration: 10)
            default:
                return WeatherNodeAttributes(birthrate: 5, acceleration: 15)
            }
        case .fog(let weight):
            switch weight {
            case .heavy:
                return WeatherNodeAttributes(birthrate: 20, acceleration: 20)
            case .light:
                return WeatherNodeAttributes(birthrate: 2, acceleration: 10)
            default:
                return WeatherNodeAttributes(birthrate: 5, acceleration: 15)
            }
        case .ash(let weight):
            switch weight {
            case .heavy:
                return WeatherNodeAttributes(birthrate: 20, acceleration: 20)
            case .light:
                return WeatherNodeAttributes(birthrate: 2, acceleration: 10)
            default:
                return WeatherNodeAttributes(birthrate: 5, acceleration: 15)
            }
        case .tornado(let weight):
            switch weight {
            case .heavy:
                return WeatherNodeAttributes(birthrate: 200, acceleration: 0)
            case .light:
                return WeatherNodeAttributes(birthrate: 100, acceleration: 0)
            default:
                return WeatherNodeAttributes(birthrate: 150, acceleration: 0)
            }
        case .clear:
            return WeatherNodeAttributes(birthrate: 0, acceleration: 0)
        }
    }
}
