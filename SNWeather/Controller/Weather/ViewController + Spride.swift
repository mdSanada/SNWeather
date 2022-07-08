//
//  ViewController + Spride.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 05/07/22.
//

import Cocoa
import SpriteKit
import SnapKit

extension ViewController {
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
//        let emmiter = SKEmitterNode(fileNamed: "Rain.sks")!
//        let weatherScene = WeatherSKView(frame: tempCard.frame)
//
//        weatherScene.weatherScene.addChild(emmiter)
//
//
//        emmiter.position.x = tempCard.frame.minX + 10
//        emmiter.position.y = tempCard.frame.maxY + 10
//        emmiter.particlePositionRange.dx = tempCard.frame.width
//
//
//        weatherView.addSubview(weatherScene)

//        weatherScene.snp.makeConstraints { make in
//            make.leading.equalTo(tempCard.snp.leading)
//            make.trailing.equalTo(tempCard.snp.trailing)
//            make.top.equalTo(tempCard.snp.top)
//        }
// Do any additional setup after loading the view.
