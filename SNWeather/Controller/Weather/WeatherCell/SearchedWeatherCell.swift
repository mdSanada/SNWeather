//
//  SearchedWeatherCell.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 05/07/22.
//

import Cocoa

protocol SearchedWeather {
    func didAdd(weather: WeatherDTO)
}

class SearchedWeatherCell: NSTableCellView {
    @IBOutlet weak var labelTitle: NSTextField!
    var weather: WeatherDTO? = nil
    var delegate: SearchedWeather? = nil
    @IBOutlet weak var spacer: NSBox!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    @IBAction func actionAdd(_ sender: Any) {
        guard let weather = weather else {
            return
        }
        delegate?.didAdd(weather: weather)
    }
    
    func render(weather: WeatherDTO, delegate: SearchedWeather, isFirst: Bool) {
        labelTitle.cell?.title = weather.city + ", " + weather.countryCode
        self.weather = weather
        self.delegate = delegate
        self.spacer.isHidden = !isFirst
    }
}
