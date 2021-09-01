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
    
    @IBOutlet weak var photosTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        obtainPhotos()
        setupCollectionView()
    }
    
    public func obtainPhotos() {
        nasaPhotoService.obtainPhotos { [weak self] latestPhotos in
            guard let latestPhotos = latestPhotos else { return }
            self?.photos = latestPhotos.photos
            self?.photosTableView.reloadData()
            // to do брать 25 первых строк
        }
    }
    
    private func setupCollectionView() {
        photosTableView.delegate = self
        photosTableView.dataSource = self
        photosTableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "photoCell")
    }

}
extension PhotoGalleryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = photosTableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotoTableViewCell
            DispatchQueue.global().async {
                if let url = URL(string: self.photos[indexPath.row].imageUrl) {
                    DispatchQueue.global().async {
                        let data = try? Data(contentsOf: url)
                        if let data = data {
                            DispatchQueue.main.async {
                                cell.photoImage.image = UIImage(data: data)
                            }
                        }
                        
                    }
                }
            }
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 220
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

