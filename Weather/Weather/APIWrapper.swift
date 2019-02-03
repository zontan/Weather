//
//  APIWrapper.swift
//  Weather
//
//  Created by Jonathan  Fotland on 2/1/19.
//  Copyright © 2019 Jonathan Fotland. All rights reserved.
//

import Foundation
import CoreLocation

enum APIError: Error {
    case invalidCoordinates, jsonParseError, serverError
}

class APIWrapper {
    static let sharedInstance = APIWrapper()
    
    private let baseURL = "https://api.darksky.net"
    //If this were a full app I wouldn't check in the API key like this to a public repo, but if this were a full app I wouldn't be using a public repo.
    private let APIKey = "e0cea2af294b25e13e92019908ffc6eb"
    
    private func constructURLRequest(endpoint: String, coordinates: String) -> URLRequest? {
        guard let url = URL(string:"\(baseURL)/\(endpoint)/\(APIKey)/\(coordinates)") else {
        
            return nil
        }
        
        return URLRequest(url: url)
    }
    
    private init() {}
    
    func getForecast(for location: CLLocation, callback: @escaping (Weather?, APIError?) -> Void) {
        let endpoint = "forecast"
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        let coords = "\(lat),\(lon)"
        
        if let urlRequest = constructURLRequest(endpoint: endpoint, coordinates: coords) {
            let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                guard error == nil, let data = data else {
                    //Obviously we could make this error handling more robust if we needed to. For now, this is probably fine.
                    callback(nil, APIError.serverError)
                    return
                }
                do {
                    if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        let weather = Weather(weatherDict: jsonObject)
                        callback(weather, nil)
                    } else {
                        callback(nil, APIError.jsonParseError)
                    }
                } catch {
                    //Invalid JSON response - nothing we can do
                    callback(nil, APIError.jsonParseError)
                }
            })
            task.resume()
        } else {
            callback(nil, APIError.invalidCoordinates)
        }
    }
}
