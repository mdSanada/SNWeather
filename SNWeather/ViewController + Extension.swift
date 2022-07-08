//
//  ViewController + Extension.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 05/07/22.
//

import Cocoa

extension ViewController {
    internal func configureCards() {
        tempCard.configureFXCard()
        tempRangeCard.configureFXCard()
        infosCard.configureFXCard(corner: false)
    }
    
    internal func configureBackground(image: NSImage?) {
        imageView.imageScaling = .scaleAxesIndependently
        imageView.image = image
    }
    
    internal func setTitle(for index: Int) {
        labelTitle.cell?.title = cityDataSource[index].city
    }
    
    internal func configureLongDate(index: Int) {
        let pattern = "HH:mm ' - ' EEEE ', ' dd ' de ' MMMM ' de ' yyyy"
        labelLongDate.cell?.title = DateHelper.getDate(secondsFromGMT: cityDataSource[index].gmt, pattern: pattern)
    }
    
    internal func configureTemp(_ weather: WeatherModel) {
        labelTemp.cell?.title = weather.main?.temp?.toCelsiusDegrees() ?? ""
        labelTempMax.cell?.title = weather.main?.tempMax?.toCelsiusDegrees() ?? ""
        labelTempMin.cell?.title = weather.main?.tempMin?.toCelsiusDegrees() ?? ""
    }
    
    internal func configureInfos(_ weather: WeatherModel) {
        labelFeelsLike.cell?.title = weather.main?.feelsLike?.toCelsiusDegrees() ?? ""
        labelPressure.cell?.title = weather.main?.pressure?.toPressure() ?? ""
        labelHumidity.cell?.title = weather.main?.humidity?.toPercentage() ?? ""
        labelVisibility.cell?.title = weather.visibility?.toKilometers() ?? ""
        labelWind.cell?.title = weather.wind?.speed?.toSpeed() ?? ""
        labelRain.cell?.title = weather.rain?.hour?.toMilimiters() ?? ""
        labelClouds.cell?.title = weather.clouds?.all?.toPercentage() ?? ""
        labelSnow.cell?.title = weather.snow?.hour?.toMilimiters() ?? ""
        labelSunrise.cell?.title = weather.sys?.sunrise?.date(with: weather.timezone ?? 0) ?? ""
        labelSunset.cell?.title = weather.sys?.sunset?.date(with: weather.timezone ?? 0) ?? ""
    }
    
}
