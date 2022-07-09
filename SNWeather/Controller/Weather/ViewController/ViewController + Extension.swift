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
        guard let section = tableView.getActualSection(for: index) else { return }
        labelTitle.cell?.title = viewModel.dataSource[section][index].city
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
    
    internal func addWeatherAnimation(_ conditions: [WeatherCondition]) {
        skWeather?.removeAllConditions()
        skWeather = WeatherSKView(frame: CGRect(x: 0, y: 0, width: 1920, height: 1080))
        skWeather?.addConditions(conditions)
        weatherView.addSubview(skWeather!, positioned: .above, relativeTo: imageView)
        skWeather?.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
    }
}
