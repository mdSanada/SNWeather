//
//  ViewController.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 04/07/22.
//

import Cocoa
import SnapKit
import SpriteKit

class ViewController: NSViewController {
    @IBOutlet weak var weatherView: NSView!
    // MARK: - Title
    @IBOutlet weak var labelTitle: NSTextField!
    
    @IBOutlet weak var searchField: NSSearchField!
    
    // MARK: - Background Image
    @IBOutlet weak var imageView: NSImageView!
    
    // MARK: - Table View Citys
    @IBOutlet weak var tableView: NSTableView!
    
    // MARK: - Card Temperature
    @IBOutlet weak var tempCard: NSVisualEffectView!
    @IBOutlet weak var labelTemp: NSTextField!
    
    // MARK: - Card Range (Max / Min) Temperature
    @IBOutlet weak var tempRangeCard: NSVisualEffectView!
    @IBOutlet weak var labelTempMin: NSTextField!
    @IBOutlet weak var labelTempMax: NSTextField!
    
    // MARK: - Card General Informations
    @IBOutlet weak var infosCard: NSVisualEffectView!
    
    // MARK: First Section Feels Like
    @IBOutlet weak var labelFeelsLike: NSTextField!
    
    // MARK: Second Section Pressure, Humidity and Visibility
    @IBOutlet weak var labelPressure: NSTextField!
    @IBOutlet weak var labelHumidity: NSTextField!
    @IBOutlet weak var labelVisibility: NSTextField!
    
    // MARK: Third Section Wind, Rain, Clouds and Snow
    @IBOutlet weak var labelWind: NSTextField!
    @IBOutlet weak var labelRain: NSTextField!
    @IBOutlet weak var labelClouds: NSTextField!
    @IBOutlet weak var labelSnow: NSTextField!
    
    // MARK: Fourth Section Sunrise and Sunset
    @IBOutlet weak var labelSunrise: NSTextField!
    @IBOutlet weak var labelSunset: NSTextField!
    
    // MARK: Footer Long Date
    @IBOutlet weak var labelLongDate: NSTextField!
    
    var skWeather: WeatherSKView?
    var cityDataSource: [WeatherDTO] = []
    var timer: Timer?
    internal var lastIndex: Int?
    internal var ignoreSelection: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        getFavoritesWeathers(in: &cityDataSource)
        labelTitle.addShadow()
        configureCards()
        configureTable()
        configureTimer()
        
        configureWeather(index: 0)
        configureScreen(index: 0)
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
    }
    
    override var representedObject: Any? {
        didSet {
        }
    }
    
    fileprivate func configureTimer() {
        TimerHelper.configureTimer { timer in
            self.timer = timer
        } handler: {
            self.attDate()
        }
    }
    
    internal func onChanged(index: Int) {
        if index < 0 { return }
        if ignoreSelection { return }
        if lastIndex != index {
            configureScreen(index: index)
            configureWeather(index: index)
            configureLongDate(index: index)
            setTitle(for: index)
        }
        lastIndex = index
    }
    
    fileprivate func configureScreen(index: Int) {
        configureBackground(image: NSImage(named: "placeholder"))
    }
    
    fileprivate func configureWeather(index: Int) {
        let weatherTest = WeatherModel.mock() // should be changed to item in array
        configureInfos(weatherTest)
        configureTemp(weatherTest)
        addWeatherAnimation([.thunderstorm(weight: .heavy), .clouds(weight: .moderate), .rain(weight: .heavy), .fog(weight: .moderate)])
    }
    
    fileprivate func attDate() {
        ignoreSelection = true
        tableView.reloadDataKeepingSelection()
        configureLongDate(index: tableView.selectedRow)
        ignoreSelection = false
    }
}
