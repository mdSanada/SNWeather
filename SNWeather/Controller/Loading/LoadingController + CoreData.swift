//
//  LoadingController + CoreData.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 07/07/22.
//

import Cocoa
import CoreData

extension LoadingController {
    func getFavoritesWeathers() -> [WeatherDTO] {
        let weathers = CoreDataHelper.fetch()
        return weathers.map { WeatherDTO(city: $0.city, countryCode: $0.countryCode, lat: $0.lat, lon: $0.lon, timezone: $0.timezone, uuid: $0.uuid) }
    }
}
