//
//  SearchService.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 09/07/22.
//

import Foundation

//class SearchService {
//    let url = "https://wft-geo-db.p.rapidapi.com/v1/geo/cities?namePrefix="
//https://wft-geo-db.p.rapidapi.com/v1/geo/cities?namePrefix=new
//    let headers = [
//        "X-RapidAPI-Key": "a48415d00fmsh229ca4dc569e5eap1d082ejsnb1f86cc68127",
//        "X-RapidAPI-Host": "wft-geo-db.p.rapidapi.com"
//    ]
//
//}
//
enum SearchService {
    case search(city: String)
}

extension SearchService: SNNetworkTask {
    var baseURL: SNNetworkBaseURL {
        return .url(URL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo")!)
    }

    var path: String {
        switch self {
        case .search:
            return "cities"
        }
    }
    
    var method: SNNetworkMethod {
        switch self {
        case .search:
            return .get
        }
    }

    var params: [String : Any] {
        switch self {
        case let .search(city):
            var param: [String: Any] = [:]
            param["namePrefix"] = city
            param["languageCode"] = "pt-br"
            return param
        }
    }
    
    var encoding: EncodingMethod {
        switch self {
        case .search:
            return .queryString
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .search:
            let headers = [
                "X-RapidAPI-Key": "a48415d00fmsh229ca4dc569e5eap1d082ejsnb1f86cc68127",
                "X-RapidAPI-Host": "wft-geo-db.p.rapidapi.com"
            ]
            return headers
        }
    }
}
