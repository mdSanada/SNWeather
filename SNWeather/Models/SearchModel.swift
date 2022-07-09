//
//  SearchModel.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 09/07/22.
//

import Foundation

// MARK: - SearchModel
struct SearchModel: Codable {
    let data: [SeachInfo]?
}

// MARK: - Datum
struct SeachInfo: Codable {
    let name: String?
    let country, countryCode, region, regionCode: String?
    let latitude, longitude: Double?
}
