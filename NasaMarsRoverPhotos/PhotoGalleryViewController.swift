//
//  ViewController.swift
//  NasaMarsRoverPhotos
//
//  Created by macbook on 31.08.2021.
//

import UIKit

class PhotoGalleryViewController: UIViewController {
    var photoModel: PhotoModel? = nil
    let networkDataFetcher = NetworkDataFetcher()
    @IBOutlet weak var Collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
//        let urlString = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/latest_photos?page%20=1&api_key=DEMO_KEY"
        
        
    }
    private func setupCollectionView() {
        Collection.delegate = self
        Collection.dataSource = self
        Collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }


}

extension PhotoGalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = Collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    
}

