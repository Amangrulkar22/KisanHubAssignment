//
//  AuthorCollectionViewCell.swift
//  KisanHubAssignment
//
//  Created by Ashwinkumar Mangrulkar on 12/08/18.
//  Copyright © 2018 Ashwinkumar Mangrulkar. All rights reserved.
//

import UIKit
import Kingfisher

class AuthorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var authorImageView: UIImageView!

    func displayData(model: AuthorModel) {

        self.authorName.text = model.name
        
        /// display profile image
        if model.profileUrl != "" {
            
             let updatedUrl = model.profileUrl.replacingOccurrences(of: "/media/../", with: "/")
            let url = URL(string: updatedUrl)
            
            
            authorImageView.kf.setImage(with: url, placeholder: UIImage(named:ImageAsset.avatar.rawValue), options: [KingfisherOptionsInfoItem.fromMemoryCacheOrRefresh], progressBlock: { (receivedSize, totalSize) in
                
            }) { (image, error, cacheType, imageURL) in
               
            }
        }
    }
}
