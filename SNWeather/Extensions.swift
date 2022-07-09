//
//  Extensions.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 05/07/22.
//

import Cocoa
import SpriteKit

extension Double {
    func toCelsiusDegrees() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = .current
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.numberStyle = .decimal
        guard let value = numberFormatter.string(from: NSNumber(value: self)) else { return "" }
        return value + "ºC"
    }
    
    func toSpeed() -> String {
        String(format: "%.0f", self) + " km/h"
    }
}

extension Int {
    func toPressure() -> String {
        "\(self) hPA"
    }
    
    func toPercentage() -> String {
        "\(self)%"
    }
    
    func toKilometers() -> String {
        "\(self/1000) km"
    }
    
    func toMilimiters() -> String {
        "\(self) mm"
    }
    
    func date(with timeZone: Int) -> String {
        return DateHelper.getDate(timeIntervalSince1970: self, secondsFromGMT: timeZone)
    }
}

extension NSVisualEffectView {
    internal func configureFXCard(corner: Bool = true) {
        self.alphaValue = 0.9
        self.wantsLayer = true
        if corner {
            self.layer?.cornerRadius = 15
            self.layer?.masksToBounds = true
        }
    }
}

extension NSTextField {
    internal func addShadow() {
        self.wantsLayer = true
        self.layer?.shadowColor = .black.copy(alpha: 0.5)
        self.layer?.shadowRadius = 3
        self.layer?.shadowOpacity = 1
        self.layer?.shadowOffset = CGSize(width: 4, height: 4)
        self.layer?.masksToBounds = false
    }
}

extension NSTableView {

    func reloadDataKeepingSelection() {
        let selectedRowIndexes = self.selectedRowIndexes
        self.reloadData()
        self.selectRowIndexes(selectedRowIndexes, byExtendingSelection: false)
    }
}

extension Dictionary {
    public var data: Data? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return jsonData
        } catch {
            return nil
        }
    }
}

extension Data {
    public func map<D: Decodable>(to type: D.Type) -> D? {
        do {
            let response = try JSONDecoder().decode(type.self, from: self)
            return response
        } catch let jsonErr {
            return nil
       }
    }
    
    public var dictionary: [String: Any]? {
        do {
            let json = try JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? [String:Any]
            return json
        } catch let jsonErr {
            return nil
       }
    }
    
    public var prettyJson: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding:.utf8) else { return nil }

        return prettyPrintedString
    }
}

