//
//  ViewController + NSTable.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 05/07/22.
//

import Cocoa

extension ViewController: NSTableViewDataSource, NSTableViewDelegate {
    fileprivate enum CellIdentifiers {
        static let WeatherCell = "WeatherCell"
    }
    
    internal func configureTable() {
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return cityDataSource.count
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: CellIdentifiers.WeatherCell), owner: nil) as? WeatherCell {
            cell.render(title: cityDataSource[row].city,
                        time: DateHelper.getDate(secondsFromGMT: cityDataSource[row].gmt))
            return cell
        }
        return nil
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        let row = tableView.selectedRow
        onChanged(index: row)
        print(row)
    }
}
