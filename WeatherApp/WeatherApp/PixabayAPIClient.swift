//
//  PixabayAPIClient.swift
//  WeatherApp
//
//  Created by Ramu on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class PixabayAPIClient {
    private init() {}
    static func searchCity(city: String, isCity: Bool, completionHandler: @escaping (AppError?, [ImageData]?) -> Void)
    {
        let formattedCity = city.replacingOccurrences(of: " ", with: "+")
        let endpointURLString = "https://pixabay.com/api/?key=11367059-a712f81a007b7fbeffff8fddb&q=\(formattedCity)&image_type=photo"
        
        guard let url = URL(string: endpointURLString) else {
            completionHandler(AppError.badURL(endpointURLString), nil)
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request)
        { (data, response, error) in
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
                    let cityData = try JSONDecoder().decode(Pictures.self, from: data).hits
                    completionHandler(nil, cityData)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
            }.resume()
    }
}
