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
    @IBOutlet weak var tableView: WeatherTableView!
    
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
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    
    var skWeather: WeatherSKView?
    var viewModel = WeatherViewModel()
    var timer: Timer?
    let debouncer = Debouncer(timeInterval: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        labelTitle.addShadow()
        configureCards()
        configureTimer()
        configureViewModel()
        configureWeather(index: 0)
        configureScreen(index: 0)
        searchField.delegate = self
        progressIndicator.controlTint = .blueControlTint
        progressIndicator.isHidden = true
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
    }
    
    override var representedObject: Any? {
        didSet {
        }
    }
    
    private func configureViewModel() {
        viewModel.configure(output: self)
        tableView.configureTable(interface: viewModel,
                                 searchedDelegate: viewModel)
    }
    
    fileprivate func configureTimer() {
        TimerHelper.configureTimer { timer in
            self.timer = timer
        } handler: {
            self.attDate()
        }
    }
        
    fileprivate func attDate() {
        viewModel.ignoreSelection = true
        tableView.reloadDataKeepingSelection()
        let index = viewModel.lastIndex ?? 0
        guard let section = tableView.getActualSection(for: index) else { return }
        labelLongDate.cell?.title = viewModel.configureLongDate(section: section, index: index) ?? ""
        viewModel.ignoreSelection = false
    }
}

extension ViewController: WeatherOutput {
    func onChanged(index: Int) {
        configureScreen(index: index)
        configureWeather(index: index)
        guard let section = tableView.getActualSection(for: index) else { return }
        labelLongDate.cell?.title = viewModel.configureLongDate(section: section, index: index) ?? ""
        setTitle(for: index)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func searchLoading(loading: Bool) {
        DispatchQueue.main.async {
            self.progressIndicator.isHidden = !loading
            if loading {
                self.progressIndicator.startAnimation(self)
            } else {
                self.progressIndicator.stopAnimation(nil)
            }
        }
    }
    
    func addLoading(loading: Bool) {
        DispatchQueue.main.async {
            self.progressIndicator.isHidden = !loading
            if loading {
                self.progressIndicator.startAnimation(self)
            } else {
                self.progressIndicator.stopAnimation(nil)
            }
        }
    }
    
    func didSaveWeather() {
        searchField.cell?.title = ""
        searchField.resignFirstResponder()
        viewModel.searchedItems = []
        tableView.reloadDataKeepingSelection()
    }
    
    fileprivate func configureScreen(index: Int) {
        configureBackground(image: NSImage(named: "placeholder"))
    }
    
    // TODO: - Add response do weather e configurar a scene
    fileprivate func configureWeather(index: Int) {
        let weatherTest = WeatherModel.mock()
        configureInfos(weatherTest)
        configureTemp(weatherTest)
        addWeatherAnimation([.thunderstorm(weight: .heavy), .clouds(weight: .moderate), .rain(weight: .heavy), .fog(weight: .moderate)])
    }

}

extension ViewController: NSSearchFieldDelegate {
    func searchFieldDidStartSearching(_ sender: NSSearchField) {
        print("didStart")
    }

    func searchFieldDidEndSearching(_ sender: NSSearchField) {
        viewModel.searchedItems = []
        tableView.reloadDataKeepingSelection()
    }
    
    func controlTextDidChange(_ obj: Notification) {
        debouncer.renewInterval()
        debouncer.handler = {
            let searchField: NSSearchField? = obj.object as? NSSearchField
            guard let city = searchField?.cell?.title else { return }
            self.viewModel.search(city: city)
        }
    }
}
