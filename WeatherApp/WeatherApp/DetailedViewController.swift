//
//  DetailedViewController.swift
//  WeatherApp
//
//  Created by Ramu on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var cityImage: UIImageView!
    
    @IBOutlet weak var tempDescription: UILabel!
    
    @IBOutlet weak var highTemp: UILabel!
    
    @IBOutlet weak var lowTemp: UILabel!
    
    @IBOutlet weak var sunriseLabel: UILabel!
    
    @IBOutlet weak var sunsetLabel: UILabel!
    
    @IBOutlet weak var windSpeed: UILabel!
    
    @IBOutlet weak var precipIN: UILabel!
    
    public var dayInfo: PeriodsData?
    public var cityName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        getImage()
        
    }
    
    private func getImage() {
        if let cityName = cityName {
            PixabayAPIClient.searchCity(city: cityName, isCity: true) { (appError, imageData) in
                if let error = appError {
                    print(error)
                } else if let imageData = imageData {
                    let randomImageURL = imageData[Int.random(in: 0...imageData.count - 1)].largeImageURL
                    ImageHelper.shared.fetchImage(urlString: randomImageURL , completionHandler: { (appError, image) in
                        if let appError = appError {
                            print(appError)
                        } else if let image = image {
                            DispatchQueue.main.async {
                                self.cityImage.image = image
                            }
                        }
                    })
                    
                }
            }
        }
    }
    
    
    private func updateUI() {
        if let dayInfo = dayInfo {
            cityLabel.text = cityName
            tempDescription.text = dayInfo.weather
            highTemp.text = "highTemp: \(dayInfo.maxTempF) °F"
            lowTemp.text = "lowTemp: \(dayInfo.minTempF) °F"
            sunriseLabel.text = "sunrise: \(dayInfo.sunsetISO)"
            sunsetLabel.text = "sunset: \(dayInfo.sunsetISO)"
            windSpeed.text = "windSpeedMaxMPH: \(dayInfo.windSpeedMaxMPH) MPH"
            precipIN.text = "precipIn: \(dayInfo.precipIN) in."
        }
    }
    
}
    


