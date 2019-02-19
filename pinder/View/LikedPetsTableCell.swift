//
//  LikedPetsTableCell.swift
//  pinder
//
//  Created by Nineleaps on 13/02/19.
//  Copyright © 2019 Nineleaps. All rights reserved.
//

import UIKit
import Kingfisher

class LikedPetsTableCell: UITableViewCell {
    
    @IBOutlet weak var likedPetImage: UIImageView!
    @IBOutlet weak var likedPetName: UILabel!
    @IBOutlet weak var likedPetDescription: UILabel!

      
    func setLikedPetsTableCell(name: String, image: String , description: String) {
    let url = URL(string: image)
    self.likedPetImage.kf.setImage(with: url)
    self.likedPetName.text = name
    self.likedPetDescription.text = description
}
}
