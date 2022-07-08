//
//  WeatherCell.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 05/07/22.
//

import Cocoa

class WeatherCell: NSTableCellView {
    @IBOutlet weak var labelTitle: NSTextField!
    @IBOutlet weak var labelHour: NSTextField!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    func render(title: String, time: String) {
        labelTitle.cell?.title = title
        labelHour.cell?.title = time
    }
}
