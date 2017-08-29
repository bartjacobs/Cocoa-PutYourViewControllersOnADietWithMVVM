//
//  ViewController.swift
//  MVVM
//
//  Created by Bart Jacobs on 29/08/2017.
//  Copyright © 2017 Envato Tuts+. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet var temperatureLabel: UILabel!

    // MARK: -

    @IBOutlet var fetchWeatherDataButton: UIButton!

    // MARK: -

    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!

    // MARK: -

    private let viewModel = WeatherViewViewModel()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Fetch Weather Data
        fetchWeatherData()
    }

    // MARK: - Actions

    @IBAction func fetchWeatherData(_ sender: Any) {
        // Fetch Weather Data
        fetchWeatherData()
    }
    
    // MARK: - Helper Methods

    private func fetchWeatherData() {
        // Hide User Interface
        temperatureLabel.isHidden = true
        fetchWeatherDataButton.isHidden = true

        // Show Activity Indicator View
        activityIndicatorView.startAnimating()

        // Fetch Weather Data
        viewModel.currentTemperature { [unowned self] (temperature) in
            // Update Temperature Label
            self.temperatureLabel.text = temperature
            self.temperatureLabel.isHidden = false

            // Show Fetch Weather Data Button
            self.fetchWeatherDataButton.isHidden = false

            // Hide Activity Indicator View
            self.activityIndicatorView.stopAnimating()
        }
    }

}
