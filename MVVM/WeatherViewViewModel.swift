//
//  WeatherViewViewModel.swift
//  MVVM
//
//  Created by Bart Jacobs on 29/08/2017.
//  Copyright © 2017 Envato Tuts+. All rights reserved.
//

import Foundation

class WeatherViewViewModel {

    // MARK: - Type Alias

    typealias CurrentTemperatureCompletion = (String) -> Void

    // MARK: - API

    enum API {

        static let lat = 37.8267
        static let long = -122.4233
        static let APIKey = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
        static let baseURL = URL(string: "https://api.darksky.net/forecast")!

        static var requestURL: URL {
            return API.baseURL
                .appendingPathComponent(API.APIKey)
                .appendingPathComponent("\(lat),\(long)")
        }
    }

    // MARK: - Public API

    func currentTemperature(completion: @escaping CurrentTemperatureCompletion) {
        let dataTask = URLSession.shared.dataTask(with: API.requestURL) { [weak self] (data, response, error) in
            // Helpers
            var formattedTemperature: String?

            if let data = data {
                formattedTemperature = self?.temperature(from: data)
            }

            DispatchQueue.main.async {
                completion(formattedTemperature ?? "Unable to Fetch Weather Data")
            }
        }
        
        // Resume Data Task
        dataTask.resume()
    }

    // MARK: - Helper Methods

    func temperature(from data: Data) -> String? {
        guard let JSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
            return nil
        }

        guard let currently = JSON?["currently"] as? [String : Any] else {
            return nil
        }

        guard let temperature = currently["temperature"] as? Double else {
            return nil
        }
        
        return String(format: "%.0f °F", temperature)
    }
    
}
