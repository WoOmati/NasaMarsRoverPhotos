//
//  Model.swift
//  NasaMarsRoverPhotos
//
//  Created by macbook on 01.09.2021.
//

import Foundation

struct PhotoModel: Decodable {
    var resultsCount: [PhotoResults]
}

struct PhotoResults: Decodable {
    
    let id: UInt
    let imageUrl: String
    let date: String

    enum CodingKeys: String, CodingKey {
         case id
         case imageUrl = "img_src"
         case date = "earth_date"
     }
}
