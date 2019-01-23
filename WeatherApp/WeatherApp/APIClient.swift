//
//  APIClient.swift
//  WeatherApp
//
//  Created by Ramu on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class WeatherAPIClient {
    private init() {}
    static func searchWeather(zipcode: String, isZipcode: Bool, completionHandler: @escaping (AppError?, [PeriodsData]?) -> Void) {
        let endpointURLString = "https://api.aerisapi.com/forecasts/\(zipcode)?client_id=\(SecretKeys.clientID)&client_secret=\(SecretKeys.APIKey)"
        
        guard let url = URL(string: endpointURLString) else {
            completionHandler(AppError.badURL(endpointURLString), nil)
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completionHandler(AppError.networkError(error), nil)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -999
                    completionHandler(AppError.badStatusCode("\(statusCode)"), nil)
                    return
            }
            if let data = data {
                do {
                    let weatherData = try JSONDecoder().decode(WeatherData.self, from: data).response[0].periods
                    completionHandler(nil, weatherData)
                } catch {
                    completionHandler(AppError.jsonDecodingError(error), nil)
                }
            }
            }.resume()
    }
    
}
