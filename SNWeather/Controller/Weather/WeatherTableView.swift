//
//  WeatherTableView.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 08/07/22.
//

import Cocoa

protocol WeatherTableViewInterface {
    var viewModel: WeatherViewModel { get }
    func onChanged(section: Int, index: Int)
    func dataSource(section: Int, remove: Int)
    func dataSource(section: Int, append: Int, item: WeatherDTO?)
}

class WeatherTableView: NSTableView, NSTableViewDelegate, NSTableViewDataSource {
    var interface: WeatherTableViewInterface?
    var searchedDelegate: SearchedWeather?
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    fileprivate enum CellIdentifiers {
        static let WeatherCell = "WeatherCell"
        static let SearchedWeatherCell = "SearchedWeatherCell"
    }
        
    internal func configureTable(interface: WeatherTableViewInterface, searchedDelegate: SearchedWeather) {
        self.backgroundColor = .clear
        self.delegate = self
        self.dataSource = self
        self.interface = interface
        self.searchedDelegate = searchedDelegate
        configureTableMenu()
        self.reloadData()
    }
    
    private func configureTableMenu() {
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Delete", action: #selector(tableViewDeleteItemClicked(_:)), keyEquivalent: ""))
        self.menu = menu
    }
    
    @objc private func tableViewDeleteItemClicked(_ sender: AnyObject) {
        deleteRow()
    }
    
    func getActualSection(for row: Int) -> Int? {
        var counter = 0
        var section: Int? = nil
        guard let dataSource = interface?.viewModel.dataSource else { return nil }
        for (index, array) in dataSource.enumerated() {
            let maxRow = array.count + counter
            if row < maxRow {
                section = index
                break
            }
            counter = maxRow
        }
        return section
    }
    
    func getRowInSection(_ row: Int) -> Int? {
        var counter: Int? = nil
        guard let dataSource = interface?.viewModel.dataSource else { return nil }
        for array in dataSource {
            let size = (array.count + (counter ?? 0))
            if row >= size {
                counter = size
            } else {
                break
            }
        }
        return row - (counter ?? 0)
    }

    
    func tableView(_ tableView: NSTableView, rowActionsForRow row: Int, edge: NSTableView.RowActionEdge) -> [NSTableViewRowAction] {
        if getActualSection(for: row) != 0 { return [] }
        if edge == .trailing {
            let deleteAction = NSTableViewRowAction(style: .destructive, title: "Delete", handler: { (rowAction, row) in
                self.deleteRow(row)
            })
            deleteAction.backgroundColor = NSColor.red
            return [deleteAction]
        } else if edge == .leading {
            let blankAction = NSTableViewRowAction(style: .regular, title: "Top", handler: { (rowAction, row) in
                self.fixedRow(row)
            })
            blankAction.backgroundColor = NSColor.systemBlue
            return row == 0 || row != tableView.selectedRow ? [] : [blankAction]
        }
        return []
    }
    
    private func fixedRow(_ row: Int? = nil) {
        var actionRow: Int {
            if let row = row {
                return row
            } else {
                return self.clickedRow
            }
        }
        guard actionRow >= 0, let section = getActualSection(for: actionRow) else { return }
        let item = interface?.viewModel.dataSource[section][actionRow]
        self.beginUpdates()
        interface?.dataSource(section: section, remove: actionRow)
        self.removeRows(at: IndexSet(integer: actionRow), withAnimation: .effectFade)
        interface?.dataSource(section: section, append: 0, item: item)
        self.insertRows(at: IndexSet(integer: 0), withAnimation: .effectFade)
        self.endUpdates()
        self.reloadData()
    }
    
    private func deleteRow(_ row: Int? = nil) {
        var actionRow: Int {
            if let row = row {
                return row
            } else {
                return self.clickedRow
            }
        }
        guard actionRow >= 0, let section = getActualSection(for: actionRow) else { return }
        guard let item = interface?.viewModel.dataSource[section][actionRow] else { return }
        CoreDataHelper.delete(weather: item)
        self.beginUpdates()
        self.removeRows(at: IndexSet(integer: actionRow), withAnimation: .effectGap)
        self.endUpdates()
        
        interface?.dataSource(section: section, remove: actionRow)
        self.reloadData()
        interface?.viewModel.lastIndex = -1
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return (interface?.viewModel.dataSource[0].count ?? 0) + (interface?.viewModel.dataSource[1].count ?? 0)
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return getActualSection(for: row) == 0
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let section = getActualSection(for: row) else { return nil }
        guard let rowInSection = getRowInSection(row) else { return nil }
        guard let weather = interface?.viewModel.dataSource[section][rowInSection] else { return nil }
        if section == 0 {
            if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: CellIdentifiers.WeatherCell), owner: nil) as? WeatherCell {
                cell.render(title: weather.city,
                            time: DateHelper.getDate(secondsFromGMT: weather.timezone))
                return cell
            }
        } else if section == 1 {
            guard let searchedDelegate = searchedDelegate else { return nil }
            if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: CellIdentifiers.SearchedWeatherCell), owner: nil) as? SearchedWeatherCell {
                cell.render(title: weather.city, delegate: searchedDelegate, isFirst: rowInSection == 0)
                return cell
            }
        }
        return nil
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        let row = self.selectedRow
        guard let section = getActualSection(for: row) else { return }
        if section == 0 {
            interface?.onChanged(section: section, index: row)
        }
    }
}
