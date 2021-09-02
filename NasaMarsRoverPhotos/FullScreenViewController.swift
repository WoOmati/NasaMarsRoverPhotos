//
//  FullScreenViewController.swift
//  NasaMarsRoverPhotos
//
//  Created by macbook on 01.09.2021.
//

import UIKit

class FullScreenViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    var imageUrl: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        photoImageView.contentMode = .scaleAspectFit
        setImage()
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.5
    }
    
    func setImage() {
        DispatchQueue.global().async {
            if let url = URL(string: self.imageUrl ?? "") {
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    if let data = data {
                        DispatchQueue.main.async {
                            self.photoImageView.image = UIImage(data: data)
                        }
                    }
                    
                }
            }
        }
    }
}

extension FullScreenViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        return scrollView.zoomScale = 1.0
    }
}
