//
//  Card.swift
//  Example
//
//  Created by HideakiTouhara on 2018/05/17.
//  Copyright © 2018年 HideakiTouhara. All rights reserved.
//

import UIKit
import Kingfisher

class Card: UIView {
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var petTitle: UILabel!
    @IBOutlet weak var petDescription: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    func prepareUI(text: String, img: String, des: String) {
        petTitle.text = text
        let url = URL(string: img)
        petImage.kf.setImage(with: url)
        petDescription.text = des
    }
}
