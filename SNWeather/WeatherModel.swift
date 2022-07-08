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
