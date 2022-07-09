//
//  ViewController + CoreData.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 07/07/22.
//

import Cocoa
import CoreData

extension WeatherViewModel {
    func getFavoritesWeathers(in data: inout [WeatherDTO]) {
        let weathers = CoreDataHelper.fetch()
        data = weathers
    }
}
