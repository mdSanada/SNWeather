//
//  WeatherModel.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 05/07/22.
//

import Foundation

// MARK: - WeatherModel
struct WeatherModel: Codable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let rain: Rain?
    let snow: Snow?
    let dt: Int?
    let sys: Sys?
    let timezone, id: Int?
    let name: String?
    let cod: Int?
}

extension WeatherModel {
    static func mock() -> WeatherModel {
        return WeatherModel(coord: nil,
                            weather: nil,
                            base: nil,
                            main: Main(temp: 30, feelsLike: 32, tempMin: 29, tempMax: 70, pressure: 1023, humidity: 20),
                            visibility: 12000,
                            wind: Wind(speed: 1.5, deg: nil),
                            clouds: Clouds(all: 3),
                            rain: Rain(hour: 40),
                            snow: Snow(hour: 20),
                            dt: -10800,
                            sys: Sys(type: nil, id: nil, message: nil, country: nil, sunrise: 1560343627, sunset: 1560396563),
                            timezone: -10800,
                            id: nil,
                            name: nil,
                            cod: nil)
        
    }
    
    func condition() -> [WeatherCondition] {
        let listId = self.weather?.map { $0.id }
        var conditions: [WeatherCondition] = []
        listId?.forEach { id in
            switch id {
            case 200:
                conditions.insert(contentsOf: [.rain(weight: .light), .thunderstorm(weight: .light)], at: 0)
            case 201:
                conditions.insert(contentsOf: [.rain(weight: .moderate), .thunderstorm(weight: .moderate)], at: 0)
            case 202:
                conditions.insert(contentsOf: [.rain(weight: .heavy), .thunderstorm(weight: .heavy)], at: 0)
            case 210:
                conditions.insert(contentsOf: [.thunderstorm(weight: .light)], at: 0)
            case 211:
                conditions.insert(contentsOf: [.thunderstorm(weight: .moderate)], at: 0)
            case 212:
                conditions.insert(contentsOf: [.thunderstorm(weight: .heavy)], at: 0)
            case 221:
                conditions.insert(contentsOf: [.thunderstorm(weight: .heavy)], at: 0)
            case 230:
                conditions.insert(contentsOf: [.thunderstorm(weight: .light), .drizzle(weight: .light)], at: 0)
            case 231:
                conditions.insert(contentsOf: [.thunderstorm(weight: .moderate), .drizzle(weight: .moderate)], at: 0)
            case 232:
                conditions.insert(contentsOf: [.thunderstorm(weight: .heavy), .drizzle(weight: .heavy)], at: 0)
            case 300:
                conditions.insert(contentsOf: [.drizzle(weight: .light)], at: 0)
            case 301:
                conditions.insert(contentsOf: [.drizzle(weight: .moderate)], at: 0)
            case 302:
                conditions.insert(contentsOf: [.drizzle(weight: .heavy)], at: 0)
            case 310:
                conditions.insert(contentsOf: [.drizzle(weight: .light), .rain(weight: .light)], at: 0)
            case 311:
                conditions.insert(contentsOf: [.drizzle(weight: .moderate), .rain(weight: .moderate)], at: 0)
            case 312:
                conditions.insert(contentsOf: [.drizzle(weight: .heavy), .rain(weight: .heavy)], at: 0)
            case 313:
                conditions.insert(contentsOf: [.drizzle(weight: .heavy), .rain(weight: .heavy), .clouds(weight: .light)], at: 0)
            case 314:
                conditions.insert(contentsOf: [.drizzle(weight: .heavy), .rain(weight: .heavy), .clouds(weight: .moderate)], at: 0)
            case 321:
                conditions.insert(contentsOf: [.drizzle(weight: .heavy), .rain(weight: .heavy), .clouds(weight: .moderate)], at: 0)
            case 500:
                conditions.insert(contentsOf: [.rain(weight: .light)], at: 0)
            case 501:
                conditions.insert(contentsOf: [.rain(weight: .moderate)], at: 0)
            case 502:
                conditions.insert(contentsOf: [.rain(weight: .heavy)], at: 0)
            case 503:
                conditions.insert(contentsOf: [.rain(weight: .heavy)], at: 0)
            case 504:
                conditions.insert(contentsOf: [.rain(weight: .heavy), .rain(weight: .heavy)], at: 0)
            case 511:
                conditions.insert(contentsOf: [.rain(weight: .heavy), .snow(weight: .light)], at: 0)
            case 520:
                conditions.insert(contentsOf: [.rain(weight: .heavy), .clouds(weight: .light)], at: 0)
            case 522:
                conditions.insert(contentsOf: [.rain(weight: .heavy), .clouds(weight: .moderate)], at: 0)
            case 531:
                conditions.insert(contentsOf: [.rain(weight: .heavy), .clouds(weight: .heavy)], at: 0)
            case 600:
                conditions.insert(contentsOf: [.snow(weight: .light)], at: 0)
            case 601:
                conditions.insert(contentsOf: [.snow(weight: .moderate)], at: 0)
            case 602:
                conditions.insert(contentsOf: [.snow(weight: .heavy)], at: 0)
            case 611:
                conditions.insert(contentsOf: [.clouds(weight: .light), .rain(weight: .light)], at: 0)
            case 612:
                conditions.insert(contentsOf: [.clouds(weight: .moderate), .rain(weight: .moderate)], at: 0)
            case 613:
                conditions.insert(contentsOf: [.clouds(weight: .heavy), .rain(weight: .heavy)], at: 0)
            case 615:
                conditions.insert(contentsOf: [.rain(weight: .light), .snow(weight: .light)], at: 0)
            case 616:
                conditions.insert(contentsOf: [.rain(weight: .moderate), .snow(weight: .moderate)], at: 0)
            case 620:
                conditions.insert(contentsOf: [.clouds(weight: .light), .rain(weight: .light), .snow(weight: .light)], at: 0)
            case 621:
                conditions.insert(contentsOf: [.clouds(weight: .moderate), .rain(weight: .moderate), .snow(weight: .moderate)], at: 0)
            case 622:
                conditions.insert(contentsOf: [.clouds(weight: .heavy), .rain(weight: .heavy), .snow(weight: .heavy)], at: 0)
            case 701:
                conditions.insert(contentsOf: [.mist(weight: .moderate)], at: 0)
            case 711:
                conditions.insert(contentsOf: [.smoke(weight: .moderate)], at: 0)
            case 721:
                conditions.insert(contentsOf: [.fog(weight: .light)], at: 0)
            case 731:
                conditions.insert(contentsOf: [.dust(weight: .light)], at: 0)
            case 741:
                conditions.insert(contentsOf: [.fog(weight: .heavy)], at: 0)
            case 751:
                conditions.insert(contentsOf: [.dust(weight: .moderate)], at: 0)
            case 761:
                conditions.insert(contentsOf: [.dust(weight: .heavy)], at: 0)
            case 762:
                conditions.insert(contentsOf: [.ash(weight: .moderate)], at: 0)
            case 771:
                conditions.insert(contentsOf: [.tornado(weight: .light)], at: 0)
            case 781:
                conditions.insert(contentsOf: [.tornado(weight: .heavy)], at: 0)
            case 800:
                conditions.insert(contentsOf: [.clear], at: 0)
            case 801:
                conditions.insert(contentsOf: [.clouds(weight: .light)], at: 0)
            case 802:
                conditions.insert(contentsOf: [.clouds(weight: .moderate)], at: 0)
            case 803:
                conditions.insert(contentsOf: [.clouds(weight: .moderate)], at: 0)
            case 804:
                conditions.insert(contentsOf: [.clouds(weight: .heavy)], at: 0)
            default:
                conditions.insert(contentsOf: [], at: 0)
            }
        }
        return conditions
    }
}

struct Rain: Codable {
    let hour: Int?
    
    enum CodingKeys: String, CodingKey {
        case hour = "1h"
    }
}

struct Snow: Codable {
    let hour: Int?
    
    enum CodingKeys: String, CodingKey {
        case hour = "1h"
    }
}


// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double?
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, humidity: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int?
    let message: Double?
    let country: String?
    let sunrise, sunset: Int?
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int?
    let main, weatherDescription, icon: String?

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double?
    let deg: Int?
}
