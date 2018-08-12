//
//  AuthorCollectionViewCell.swift
//  KisanHubAssignment
//
//  Created by Ashwinkumar Mangrulkar on 12/08/18.
//  Copyright © 2018 Ashwinkumar Mangrulkar. All rights reserved.
//

import UIKit

class AuthorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var authorImageView: UIImageView!

    func displayData(model: AuthorModel) {

        self.authorName.text = model.name
        
        /// display profile image
        if model.profileUrl != "" {
            let url = URL(string: model.profileUrl)
            if let url = url as? URL {
                let _ = authorImageView?.imageFromUrl(url, placeHolderImage: UIImage(named:ImageAsset.avatar.rawValue), shouldResize: true, showActivity: true){(success,image,error) -> Void in
                    if error == nil{}
                }
            }
        }
    }
}
