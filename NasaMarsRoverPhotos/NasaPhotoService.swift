//
//  NasaPhotoService.swift
//  NasaMarsRoverPhotos
//
//  Created by macbook on 01.09.2021.
//

import Foundation
class NasaPhotoService {
    
    let networkService = NetworkService()
    let photosURL = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/latest_photos?page%20=1&api_key=DEMO_KEY") ?? nil
    
    func obtainPhotos(response: @escaping (LatestPhotos?) -> Void) {
        guard let photosURL = photosURL else { return }
        networkService.request(url: photosURL) { (result) in
            switch result {
            case .success(let data):
                do {
                    let images = try JSONDecoder().decode(LatestPhotos.self, from: data)
                    response(images)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    response(nil)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
    func obtainImage(from url: URL, response: @escaping (Data?) -> Void) {
            networkService.request(url: url) { result in
                switch result {
                case .success(let data): response(data)
                case .failure: response(nil)
                }
            }
        }
}
