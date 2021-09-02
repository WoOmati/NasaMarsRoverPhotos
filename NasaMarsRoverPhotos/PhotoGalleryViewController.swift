//
//  ViewController.swift
//  NasaMarsRoverPhotos
//
//  Created by macbook on 31.08.2021.
//

import UIKit

class PhotoGalleryViewController: UIViewController, UIGestureRecognizerDelegate {
    let nasaPhotoService = NasaPhotoService()
    var removedIds: [UInt] = []
    var photos: [Photo] = []
    var selectedPhoto: Int?
    
    @IBOutlet weak var photosTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        obtainPhotos()
        setupTableView()
        setupLongPressGesture()
        getRemovedIds()
    }
    
    
    // Получение массива удаленных фоток
    private func getRemovedIds() {
        removedIds = UserDefaults.standard.object(forKey: Constants.removedIds) as? [UInt] ?? []
        print(removedIds)
    }
    
    public func obtainPhotos() {
        nasaPhotoService.obtainPhotos { [weak self] latestPhotos in
            guard let self = self, let latestPhotos = latestPhotos else { return }
            let filteredPhotos = latestPhotos.photos.filter { !self.removedIds.contains($0.id) }
            if filteredPhotos.count > 25 {
                self.photos = Array(filteredPhotos[0...24])
            } else {
                self.photos = filteredPhotos
            }
            self.photosTableView.reloadData()
        }
    }
    
    private func setupTableView() {
        photosTableView.delegate = self
        photosTableView.dataSource = self
        photosTableView.register(UINib(nibName: Constants.photoTableViewCellNib, bundle: nil), forCellReuseIdentifier: Constants.photoCellIdentifier)
    }
    
    
    // Добавление жеста зажатия
    private func setupLongPressGesture() {
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress))
        longPressGesture.minimumPressDuration = 1.0
        longPressGesture.delegate = self
        self.photosTableView.addGestureRecognizer(longPressGesture)
    }

    // Обработка жеста зажатия
    @objc private func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer){
        if gestureRecognizer.state == .began {
            let touchPoint = gestureRecognizer.location(in: self.photosTableView)
            if let indexPath = photosTableView.indexPathForRow(at: touchPoint) {
                print("index = \(indexPath.row)")
                showRemoveAlert(indexPath)
            }
        }
    }

    //
    private func showRemoveAlert(_ indexPath: IndexPath) {
        let alertContoller = UIAlertController(title: "Удалить ?", message: "", preferredStyle: .actionSheet)
        let removeAction = UIAlertAction(title: "Удалить", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            let id = self.photos[indexPath.row].id
            self.photos.remove(at: indexPath.row)
            self.photosTableView.deleteRows(at: [indexPath], with: .automatic)
            
            self.removedIds.append(id)
            UserDefaults.standard.set(self.removedIds, forKey: Constants.removedIds)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertContoller.addAction(removeAction)
        alertContoller.addAction(cancelAction)
        present(alertContoller, animated: true, completion: nil)
    }
}
extension PhotoGalleryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = photosTableView.dequeueReusableCell(withIdentifier: Constants.photoCellIdentifier, for: indexPath) as! PhotoTableViewCell
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPhoto = indexPath.row
        performSegue(withIdentifier: Constants.showFullScreenSegue, sender: nil)
    }
}

extension PhotoGalleryViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.showFullScreenSegue {
            let destinationVC = segue.destination as! FullScreenViewController
            if let selectedPhoto = selectedPhoto {
                destinationVC.imageUrl = photos[selectedPhoto].imageUrl
            }
        }
    }
}


// Константы
extension PhotoGalleryViewController {
    enum Constants {
        static let showFullScreenSegue = "showFullScreen"
        static let photoTableViewCellNib = "PhotoTableViewCell"
        static let photoCellIdentifier = "photoCell"
        static let removedIds = "removedIds"
    }
}
