//
//  WeatherViewController.swift
//  Weather
//
//  Created by Jonathan  Fotland on 2/3/19.
//  Copyright © 2019 Jonathan Fotland. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    var weather: Weather! //We'll never be shown without getting a weather object
    var location: String?
    
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var rainChanceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let loc = location {
            title = "Current Weather for \(loc)"
        }
        // clear-day, clear-night, rain, snow, sleet, wind, fog, cloudy, partly-cloudy-day, or partly-cloudy-night.
        if let condition = weather.getWeatherCondition() {
            let conditionString: String
            switch condition {
            case "clear-day", "clear-night":
                conditionString = "Clear"
            case "rain":
                conditionString = "Raining"
            case "snow":
                conditionString = "Snowing"
            case "sleet":
                conditionString = "Sleet"
            case "wind":
                conditionString = "Windy"
            case "fog":
                conditionString = "Foggy"
            case "cloudy":
                conditionString = "Cloudy"
            case "partly-cloudy-day", "partly-cloudy-night":
                conditionString = "Partly Cloudy"
            default:
                //They may add new values, just diplay them as-is
                conditionString = condition
            }
            
            conditionLabel.text = conditionString
        } 
        
        if let temperature = weather.getTemperature() {
            temperatureLabel.text = "\(temperature) °F"
        }
        
        if let pressure = weather.getPressure() {
            pressureLabel.text = "\(pressure) mb"
        }
        
        if let humidity = weather.getHumidity() {
            humidityLabel.text = "\(humidity * 100)%"
        }
        
        if let rainChance = weather.getPrecipitationChance() {
            rainChanceLabel.text = "\(rainChance * 100)%"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
