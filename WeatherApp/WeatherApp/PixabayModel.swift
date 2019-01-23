//
//  PixabayModel.swift
//  WeatherApp
//
//  Created by Ramu on 1/23/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Pictures: Codable {
    let hits: [ImageData]
}
struct ImageData: Codable {
    let largeImageURL: String
}
