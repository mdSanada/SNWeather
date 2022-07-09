//
//  ViewController + Search.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 08/07/22.
//

import Foundation

extension WeatherViewModel {
    // TODO: - Fazer o request de PESQUISA da cidade
    func search(city: String) {
        if city.count < 3 || isSearchLoading { return }
        
        
        searchManager.request(.search(city: city),
                              map: SearchModel.self) { loading in
            self.isSearchLoading = loading
        } onSuccess: { searched in
            guard let data = searched.data else { return }
            let response = data.map { info -> WeatherDTO? in
                if let name = info.name, let countryCode = info.countryCode, let lon = info.longitude, let lat = info.latitude {
                    return WeatherDTO(city: name, countryCode: countryCode, lat: lat, lon: lon, timezone: 0, uuid: UUID())
                } else {
                    return nil
                }
            }.compactMap { $0 }
            self.searchedItems = response
            self.output?.reloadData()
        } onError: { error in
            self.searchedItems = []
            self.output?.reloadData()
        }
    }
    
    // TODO: - Add request do TEMPO da cidade e retirar mock
    func getWeather(city: String) -> WeatherModel {
        isAddLoading = true
        let weather = WeatherModel.mock()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isAddLoading = false
            self.output?.didSaveWeather()
//            let weather = WeatherDTO(city: city, timezone: 0, uuid: UUID()) // MOCK
//            CoreDataHelper.save(weather: weather)
//            self.cityDataSource.append(weather)
            self.output?.reloadData()
        }
        return weather
    }
}
