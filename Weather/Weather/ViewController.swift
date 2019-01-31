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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didPressGo(_ sender: Any) {
        if let location = locationField.text, location != "" {
            getCoordinates(location: location)
        } else {
            let alert = UIAlertController(title: "Error", message: "Please enter a location", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            show(alert, sender: nil)
        }
    }
    
    func getCoordinates(location: String) {
    
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) {
            placemarks, error in
            let placemark = placemarks?.first
            guard let lat = placemark?.location?.coordinate.latitude,
                let lon = placemark?.location?.coordinate.longitude else {
                    let alert = UIAlertController(title: "Error", message: "Could not understand your location. Make sure everything is spelled correctly.", preferredStyle: .alert)
                    
                    print(error?.localizedDescription)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    self.show(alert, sender: nil)
                return
            }
            print("Lat: \(lat), Lon: \(lon)")
        }
    }
    
}

