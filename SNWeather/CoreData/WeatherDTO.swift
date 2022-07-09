//
//  WeatherDTO.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 07/07/22.
//

import Foundation

struct WeatherDTO {
    let city: String
    let countryCode: String
    let lat: Double
    let lon: Double
    var timezone: Int
    let uuid: UUID
}
