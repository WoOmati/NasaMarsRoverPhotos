//
//  NetworkService.swift
//  NasaMarsRoverPhotos
//
//  Created by macbook on 01.09.2021.
//

import Foundation

class NetworkService {
    
    let urlString = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/latest_photos?page%20=1&api_key=DEMO_KEY"

    
    func request(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }.resume()
    }
}
