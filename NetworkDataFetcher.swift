//
//  NetworkDataFetcher.swift
//  NasaMarsRoverPhotos
//
//  Created by macbook on 01.09.2021.
//

import Foundation
class NetworkDataFetcher {
    
    let networkService = NetworkService()
    
    func fetchTracks(urlString: String, response: @escaping (PhotoModel?) -> Void) {
        networkService.request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                do {
                    let images = try JSONDecoder().decode(PhotoModel.self, from: data)
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
}
