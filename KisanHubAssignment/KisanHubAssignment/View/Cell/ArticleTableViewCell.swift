//
//  ArticleTableViewCell.swift
//  KisanHubAssignment
//
//  Created by Ashwinkumar Mangrulkar on 11/08/18.
//  Copyright © 2018 Ashwinkumar Mangrulkar. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!

    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var publishDate: UILabel!
    @IBOutlet weak var authorCollectionView: UICollectionView!
    @IBOutlet weak var subscriptionCollectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func displayData(model: ArticleModel) {
        self.title.text = model.title
        self.desc.text = model.description
        //self.imageUrl.text = model.imageUrl
        self.status.text = "\(model.status) - "
        self.publishDate.text = "\(model.publishDate) ago"
        
        /// display avatar image
        if model.imageUrl != "" {
            let url = URL(string: model.imageUrl)
            if let url = url as? URL {
                let _ = articleImageView?.imageFromUrl(url, placeHolderImage: UIImage(named:ImageAsset.placeholder.rawValue), shouldResize: true, showActivity: true){(success,image,error) -> Void in
                    if error == nil{}
                }
            }
        }
        
    }
    
}
