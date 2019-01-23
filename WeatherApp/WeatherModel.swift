//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Ramu on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    var response: [WeatherForecasts]
}
struct WeatherForecasts: Codable {
    let periods: [PeriodsData]
}
struct PeriodsData: Codable {
    let timestamp: Double
    let validTime: String
    let maxTempF: Int
    let minTempF: Int
    let humidity: Int
    let weather: String
    let icon: String
    let sunrise: Int
    let sunset: Double
    let sunsetISO: String
    let widSpeedMaxMPH: Int?
    let precipIn: Int?
}
