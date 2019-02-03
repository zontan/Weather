//
//  Weather.swift
//  Weather
//
//  Created by Jonathan  Fotland on 2/3/19.
//  Copyright © 2019 Jonathan Fotland. All rights reserved.
//

import Foundation

class Weather {
    private let currentWeather: [String: Any]
    private let nextDayWeather: [String: Any]
    
    //JSON response format available at https://darksky.net/dev/docs
    init?(weatherDict: [String: Any]) {
        //This is the only info we care about for now, but we can always grab more
        if let current = weatherDict["currently"] as? [String:Any] {
            currentWeather = current
        } else {
            return nil
        }
        
        if let daily = weatherDict["daily"] as? [String: Any] {
            if let dataBlocks = daily["data"] as? [[String:Any]] {
                nextDayWeather = dataBlocks[0]
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func getTemperature() -> Double? {
        if let temperature = currentWeather["temperature"] as? Double {
            return temperature
        }
        return nil
    }
    
    func getPressure() -> Double? {
        if let pressure = currentWeather["pressure"] as? Double {
            return pressure
        }
        return nil
    }
    
    func getHumidity() -> Double? {
        if let humidity = currentWeather["humidity"] as? Double {
            return humidity
        }
        return nil
    }
    
    func getWeatherCondition() -> String? {
        if let icon = currentWeather["icon"] as? String {
            return icon
        }
        return nil
    }
    
    //If we just ask for current precipitation chance, it'll return 0 if it's not raining right this second, which doesn't make sense to a user. As such, I've assumed that the chance within the next day makes the most sense.
    func getPrecipitationChance() -> Double? {
        if let precipChance = nextDayWeather["precipProbability"] as? Double {
            return precipChance
        }
        return nil
    }
}
