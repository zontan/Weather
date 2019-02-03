//
//  ViewController.swift
//  Weather
//
//  Created by Jonathan  Fotland on 1/31/19.
//  Copyright © 2019 Jonathan Fotland. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var workingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        goButton.isEnabled = true
        workingView.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        goButton.isEnabled = true
        workingView.isHidden = true
        
        alert.presentInOwnWindow(animated: true, completion: nil)
    }

    @IBAction func didPressGo(_ sender: Any) {
        goButton.isEnabled = false //Disable the button while we're working
        //TODO: Animate in somehow
        workingView.isHidden = false
        if let locationString = locationField.text, locationString != "" {
            getCoordinates(location: locationString) { (location) in
                APIWrapper.sharedInstance.getForecast(for: location) { (data, error) in
                    if let error = error {
                        switch error {
                        case .invalidCoordinates:
                            self.showError(message: "Could not get coordinates for that location. Try entering a more exact address, city, or zip code.")
                        case .jsonParseError:
                            self.showError(message: "Error reading weather data. Apologies for the inconvenience.")
                        case .serverError:
                            self.showError(message: "Could not reach weather forecast server. Please try again later.")
                        }
                    } else if let weather = data {
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "ShowWeather", sender: weather)
                        }
                    }
                }
            }
        } else {
            showError(message: "Please enter a location")
        }
    }
    
    func getCoordinates(location: String, callback: @escaping (CLLocation) -> Void) {
    
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { (placemarks, error) in
            let placemark = placemarks?.first
            guard let location = placemark?.location else {
                self.showError(message: "Could not determine your location. Make sure everything is spelled correctly and that you have internet access.")
                
                return
            }
            callback(location)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowWeather" {
            if let weatherController = segue.destination as? WeatherViewController, let weather = sender as? Weather {
                weatherController.weather = weather
                weatherController.location = locationField.text
            }
        }
    }
    
}

