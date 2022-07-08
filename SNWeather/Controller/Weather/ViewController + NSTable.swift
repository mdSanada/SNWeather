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
    
    internal func configureTableMenu() {
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Delete", action: #selector(tableViewDeleteItemClicked(_:)), keyEquivalent: ""))
        tableView.menu = menu
    }
    
    func tableView(_ tableView: NSTableView, rowActionsForRow row: Int, edge: NSTableView.RowActionEdge) -> [NSTableViewRowAction] {
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
    
    @objc private func tableViewDeleteItemClicked(_ sender: AnyObject) {
        deleteRow()
    }
    
    private func fixedRow(_ row: Int? = nil) {
        var actionRow: Int {
            if let row = row {
                return row
            } else {
                return tableView.clickedRow
            }
        }
        guard actionRow >= 0 else { return }
        let item = cityDataSource[actionRow]
        tableView.beginUpdates()
        cityDataSource.remove(at: actionRow)
        tableView.removeRows(at: IndexSet(integer: actionRow), withAnimation: .effectFade)
        cityDataSource.insert(item, at: 0)
        tableView.insertRows(at: IndexSet(integer: 0), withAnimation: .effectFade)
        tableView.endUpdates()
        tableView.reloadData()
    }
    
    private func deleteRow(_ row: Int? = nil) {
        var actionRow: Int {
            if let row = row {
                return row
            } else {
                return tableView.clickedRow
            }
        }
        guard actionRow >= 0 else { return }
        let item = cityDataSource[actionRow]
        CoreDataHelper.delete(weather: item)
        tableView.beginUpdates()
        tableView.removeRows(at: IndexSet(integer: actionRow), withAnimation: .effectGap)
        tableView.endUpdates()
        
        cityDataSource.remove(at: actionRow)
        tableView.reloadData()
        
        lastIndex = -1
    }
    
    internal func configureTable() {
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        configureTableMenu()
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
                        time: DateHelper.getDate(secondsFromGMT: cityDataSource[row].timezone))
            return cell
        }
        return nil
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        let row = tableView.selectedRow
        onChanged(index: row)
    }
}
