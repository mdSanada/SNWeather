//
//  WeatherService.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 09/07/22.
//

import Foundation

enum WeatherService {
    case weather(lat: Double, lon: Double)
}

extension WeatherService: SNNetworkTask {
    var baseURL: SNNetworkBaseURL {
        return .url(URL(string: "https://api.openweathermap.org/data/2.5/")!)
    }

    var path: String {
        switch self {
        case .weather:
            return "weather"
        }
    }
    
    var method: SNNetworkMethod {
        switch self {
        case .weather:
            return .get
        }
    }

    var params: [String : Any] {
        switch self {
        case let .weather(lat, lon):
            var param: [String: Any] = [:]
            param["lat"] = String(lat)
            param["lon"] = String(lon)
            param["appid"] = "2150350500cc755d7f60182823511e26"
            param["lang"] = "pt_br"
            param["units"] = "metric"
            return param
        }
    }
    
    var encoding: EncodingMethod {
        switch self {
        case .weather:
            return .queryString
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .weather:
            return [:]
        }
    }
}
