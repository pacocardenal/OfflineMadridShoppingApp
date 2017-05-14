//
//  ShopTableViewCell.swift
//  ShoppingMadrid
//
//  Created by TalentoMobile on 13/5/17.
//  Copyright © 2017 pacocardenal. All rights reserved.
//

import UIKit

class ShopTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    
    private var _shop: Shop? = nil
    var shop: Shop {
        get {
            return _shop!
        }
        set {
            _shop = newValue
            
            nameLabel.text = newValue.name
            if let logoName = newValue.logoName {
                //logoImageView.image = UIImage(named: logoName)
                let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
                let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
                let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
                if let dirPath          = paths.first
                {
                    let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(logoName)
                    let image    = UIImage(contentsOfFile: imageURL.path)
                    logoImageView.image = image
                }
            }
        }
    }

}
