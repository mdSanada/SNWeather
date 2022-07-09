//
//  WeatherViewModel.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 08/07/22.
//

import Cocoa

protocol WeatherOutput {
    func onChanged(index: Int)
    func addLoading(loading: Bool)
    func searchLoading(loading: Bool)
    func didSaveWeather()
    func reloadData()
}

class WeatherViewModel {
    internal let weatherManager = ACNetworkManager<WeatherService>()
    internal let searchManager = ACNetworkManager<SearchService>()
    internal var lastIndex: Int?
    internal var ignoreSelection: Bool = false
    internal var isAddLoading: Bool = false {
        didSet {
            output?.addLoading(loading: isAddLoading)
        }
    }
    internal var isSearchLoading: Bool = false {
        didSet {
            output?.searchLoading(loading: isSearchLoading)
        }
    }

    var output: WeatherOutput?
    
    var cityDataSource: [WeatherDTO] = [] {
        didSet {
            dataSource[0] = cityDataSource
        }
    }
    var searchedItems: [WeatherDTO] = [] {
        didSet {
            dataSource[1] = searchedItems
        }
    }
    var dataSource: [[WeatherDTO]] = [[], []]
    
    init() {
    }
    
    func configure(output: WeatherOutput) {
        getFavoritesWeathers(in: &cityDataSource)
        self.output = output
    }

    internal func configureLongDate(section: Int, index: Int) -> String? {
        if section != 0 || index < 0 || dataSource[0].count <= 0 { return nil }
        let pattern = "HH:mm ' - ' EEEE ', ' dd ' de ' MMMM ' de ' yyyy"
        return DateHelper.getDate(secondsFromGMT: dataSource[section][index].timezone, pattern: pattern)
    }

}

extension WeatherViewModel: SearchedWeather {
    // TODO: - utilizar o response
    func didAdd(weather: WeatherDTO) {
        if isAddLoading { return }
        getWeather(weather: weather)
    }
}

extension WeatherViewModel: WeatherTableViewInterface {
    var viewModel: WeatherViewModel {
        self
    }
    
    func onChanged(section: Int, index: Int) {
        if index < 0 || section != 0 { return }
        if ignoreSelection { return }
        if lastIndex != index {
            output?.onChanged(index: index)
        }
        lastIndex = index
    }
    
    func dataSource(section: Int, remove: Int) {
        cityDataSource.remove(at: remove)
    }
    
    func dataSource(section: Int, append: Int, item: WeatherDTO?) {
        guard let item = item else { return }
        cityDataSource.insert(item, at: append)
    }
}
