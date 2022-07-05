//
//  ViewController.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 04/07/22.
//

import Cocoa
import SnapKit

class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    @IBOutlet weak var weatherView: NSView!
    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var titleCard: NSVisualEffectView!
    @IBOutlet weak var tempCard: NSVisualEffectView!
    var skWeather: WeatherSKView!

    override func viewDidLoad() {
        super.viewDidLoad()
//        addVisualEffect()
        
        addAnimation()
        imageView.imageScaling = .scaleAxesIndependently
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        
//        let visualEffect = NSVisualEffectView()
//        visualEffect.blendingMode = .behindWindow
//        visualEffect.state = .active
//        visualEffect.material = .popover
//        titleCard?.addSubview(visualEffect)
        titleCard.alphaValue = 0.8
        tempCard.alphaValue = 0.98
        
        tempCard.wantsLayer = true
        tempCard.layer?.cornerRadius = 30
        tempCard.layer?.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear() {
    }

    override var representedObject: Any? {
        didSet {
        }
    }

    private func addAnimation() {
        skWeather = WeatherSKView(frame: CGRect(x: 0, y: 0, width: 1920, height: 1080))
        skWeather.addConditions([.snow(weight: .heavy)])
        weatherView.addSubview(skWeather)
        weatherView.addSubview(skWeather, positioned: .above, relativeTo: imageView)
        skWeather.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
    }

    func numberOfRows(in tableView: NSTableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        50
    }
}

