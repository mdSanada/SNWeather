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
                    return WeatherDTO(city: name, countryCode: countryCode, lat: lat, lon: lon, timezone: 0, uuid: UUID(), details: nil)
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
    func getWeather(weather: WeatherDTO) {
        weatherManager.request(.weather(lat: weather.lat, lon: weather.lon),
                               map: WeatherModel.self) { loading in
            self.isAddLoading = loading
        } onSuccess: { weatherDetail in
            var _weather = weather
            print(weather)
            if let timezone = weatherDetail.timezone {
                _weather.timezone = timezone
            }
            _weather.details = weatherDetail
            self.output?.didSaveWeather()
            CoreDataHelper.save(weather: _weather)
            self.cityDataSource.append(_weather)
            self.output?.reloadData()
        } onError: { error in
            self.output?.didSaveWeather()
            self.output?.reloadData()
        }
    }
}
