//
//  FullScreenViewController.swift
//  NasaMarsRoverPhotos
//
//  Created by macbook on 01.09.2021.
//

import UIKit

class FullScreenViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let countCell = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
