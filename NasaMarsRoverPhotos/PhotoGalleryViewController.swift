//
//  ViewController.swift
//  NasaMarsRoverPhotos
//
//  Created by macbook on 31.08.2021.
//

import UIKit

class PhotoGalleryViewController: UIViewController {
    let nasaPhotoService = NasaPhotoService()
    var photos: [Photo] = []
    
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        obtainPhotos()
        setupCollectionView()
    }
    
    private func obtainPhotos() {
        nasaPhotoService.fetchPhotos { [weak self] latestPhotos in
            guard let latestPhotos = latestPhotos else { return }
            self?.photos = latestPhotos.photos
        }
    }
    
    private func setupCollectionView() {
        TableView.delegate = self
        TableView.dataSource = self
        TableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }

}
extension PhotoGalleryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let photos = photos.
        return cell
    }
    
    
}

//extension PhotoGalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return photos.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = PhotoCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
//
//        return cell
//    }
//
//
//}

