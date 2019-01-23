//
//  DetailedViewController.swift
//  WeatherApp
//
//  Created by Ramu on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
    
    
    @IBOutlet weak var cityImage: UIImageView!
    
    @IBOutlet weak var tempDescription: UILabel!
    
    @IBOutlet weak var highTemp: UILabel!
    
    @IBOutlet weak var lowTemp: UILabel!
    
    @IBOutlet weak var sunriseLabel: UILabel!
    
    @IBOutlet weak var sunsetLabel: UILabel!
    
    @IBOutlet weak var windSpeed: UILabel!
    
    @IBOutlet weak var precipIN: UILabel!
    
    public var dayInfo: PeriodsData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    
    private func updateUI() {
        if let dayInfo = dayInfo {
            tempDescription.text = dayInfo.validTime
            highTemp.text = "\(dayInfo.maxTempF)"
            lowTemp.text = "\(dayInfo.minTempF)"
            sunriseLabel.text = "\(dayInfo.sunrise)"
            sunsetLabel.text = "\(dayInfo.sunset)"
            windSpeed.text = "\(dayInfo.widSpeedMaxMPH)"
            precipIN.text = "\(dayInfo.precipIn)"
        }
    }
    
}
    


