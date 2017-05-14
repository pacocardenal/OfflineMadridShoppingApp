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
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    private var _shop: Shop? = nil
    var shop: Shop {
        get {
            return _shop!
        }
        set {
            _shop = newValue
            
            nameLabel.text = newValue.name
            
            let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
            let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
            let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
            
            if let logoName = newValue.logoName {
                //logoImageView.image = UIImage(named: logoName)

                if let dirPath          = paths.first
                {
                    let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(logoName)
                    let image    = UIImage(contentsOfFile: imageURL.path)
                    logoImageView.image = image
                }
            }
            
            if let backgroundName = newValue.backgroundName {
                //logoImageView.image = UIImage(named: logoName)
                
                if let dirPath          = paths.first
                {
                    let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(backgroundName)
                    let image    = UIImage(contentsOfFile: imageURL.path)
                    backgroundImageView.image = image
                }
            }
        }
    }

}
