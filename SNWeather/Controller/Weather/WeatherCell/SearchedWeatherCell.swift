//
//  SearchedWeatherCell.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 05/07/22.
//

import Cocoa

protocol SearchedWeather {
    func didAdd(city: String)
}

class SearchedWeatherCell: NSTableCellView {
    @IBOutlet weak var labelTitle: NSTextField!
    var city: String? = nil
    var delegate: SearchedWeather? = nil
    @IBOutlet weak var spacer: NSBox!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    @IBAction func actionAdd(_ sender: Any) {
        guard let city = city else {
            return
        }
        delegate?.didAdd(city: city)
    }
    
    func render(title: String, delegate: SearchedWeather, isFirst: Bool) {
        labelTitle.cell?.title = title
        self.city = title
        self.delegate = delegate
        self.spacer.isHidden = !isFirst
    }
}
