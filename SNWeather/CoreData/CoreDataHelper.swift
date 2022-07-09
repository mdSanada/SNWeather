//
//  CoreDataHelper.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 07/07/22.
//

import Cocoa
import CoreData
import CoreStore

class CoreDataHelper {
    static let dataStack = DataStack(xcodeModelName: "WeatherCoreData") // keep reference to the stack

    static func start(onSuccess: @escaping (() -> ()), onError: @escaping (() -> ())) {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let path = paths[0] + "/LocalStore.sqlite"
        print(path.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))


        do {
            try dataStack.addStorageAndWait()
            onSuccess()
        } catch {
            onError()
            debugPrint("🌐 Error")
        }
    }
    
    static func mock() {
//        deleteAll()

        CoreDataHelper.save(weather: WeatherDTO(city: "Guarulhos", countryCode: "BR", lat: -46.53333, lon: -46.53333, timezone: -10800, uuid: UUID()))
//        CoreDataHelper.save(weather: WeatherDTO(city: "Nova York", timezone: -14400, uuid: UUID()))
//        CoreDataHelper.save(weather: WeatherDTO(city: "Londres", timezone: 3600, uuid: UUID()))
    }
    
    static func save(weather: WeatherDTO) {
        do {
            try dataStack.perform { transaction in
                let item = try transaction.fetchOne(From<WeatherCD>().where(\.city == weather.city && \.timezone == Int16(weather.timezone)))
                if item == nil {
                    debugPrint("🌐 Saving")
                    let weatherCD = transaction.create(Into<WeatherCD>())
                    weatherCD.city = weather.city
                    weatherCD.timezone = Int16(weather.timezone)
                    weatherCD.id = UUID()
                    weatherCD.updatedDate = Date()
                }
            }
            debugPrint("🌐 Already saved")
        } catch {
            debugPrint("🌐 Error")
        }
    }
    
    static func deleteAll() {
        try! dataStack.perform { transaction in
            try! transaction.deleteAll(
                From<WeatherCD>()
            )
        }
    }
    
    static func delete(weather: WeatherDTO) {
        do {
            let weather = try dataStack.perform { transaction in
                try transaction.fetchOne(From<WeatherCD>().where(\.id == weather.uuid))
            }
            dataStack.perform(
                asynchronous: { transaction in
                    return transaction.delete(weather)
                },
                success: { (numberOfDeletedObjects) -> Void in
                    print("success! Deleted \(numberOfDeletedObjects) objects")
                },
                failure: { (error) -> Void in
                    print(error)
                }
            )
        } catch {
            debugPrint("🌐 Error")
        }
    }
    
    static func fetch() -> [WeatherDTO] {
        do {
            let objects = try dataStack.fetchAll(From<WeatherCD>())
            print("🌐 \(objects.map { "\($0.city ?? "") + \($0.timezone ?? -1)" })")
            return objects.map { weather in
                if let city = weather.city, let countryCode = weather.countryCode, let uuid = weather.id {
                    let lat = weather.lat
                    let lon = weather.lon
                    let timezone = Int(weather.timezone)
                    return WeatherDTO(city: city,
                                      countryCode: countryCode,
                                      lat: lat,
                                      lon: lon,
                                      timezone: timezone,
                                      uuid: uuid)
                } else {
                    return nil
                }
            }.compactMap { $0 }
        } catch {
            debugPrint("🌐 Fetching error")
            return[]
        }
    }
}
