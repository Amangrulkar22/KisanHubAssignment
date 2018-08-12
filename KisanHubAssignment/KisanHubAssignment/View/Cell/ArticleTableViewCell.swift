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
    
    /// Author model
    private(set) public var articleModelGlobal: ArticleModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func displayData(model: ArticleModel) {
        
        articleModelGlobal = model
        
        self.title.text = model.title
        self.desc.text = model.description
        //self.imageUrl.text = model.imageUrl
        self.status.text = "\(model.status) - "
        self.publishDate.text = "\(model.publishDate) ago"
        
        /// display article image
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

// MARK: - Article collectionview delegate methods
extension ArticleTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (articleModelGlobal?.authors.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? AuthorCollectionViewCell else {
            return AuthorCollectionViewCell()
        }
        
        cell.displayData(model: (articleModelGlobal?.authors[indexPath.row])!)
        
        return cell
    }
}
