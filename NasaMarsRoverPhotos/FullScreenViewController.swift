//
//  FullScreenViewController.swift
//  NasaMarsRoverPhotos
//
//  Created by macbook on 01.09.2021.
//

import UIKit

class FullScreenViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

    }
}
