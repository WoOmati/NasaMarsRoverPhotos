//
//  PhotoTableViewCell.swift
//  NasaMarsRoverPhotos
//
//  Created by macbook on 01.09.2021.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var PhotoImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
