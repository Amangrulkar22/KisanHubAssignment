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
    
    @IBOutlet var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var publishDate: UILabel!
    @IBOutlet weak var authorCollectionView: UICollectionView!
    @IBOutlet weak var subscriptionCollectionView: UICollectionView!
    @IBOutlet weak var viewAutor:UIView!
    @IBOutlet var lbl_Author: UILabel!
    
    
    
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
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func displayData(model: ArticleModel) {
        
        articleModelGlobal = model
        
        self.title.text = model.title
        self.desc.text = model.description
        //self.imageUrl.text = model.imageUrl
        self.status.text = "\(model.status) - "
        self.publishDate.text = "\(model.publishDate) ago"
        if(model.authors.count == 0 && self.viewAutor.alpha == 1){
            self.viewHeight.constant = 0
            self.viewAutor.isHidden = true
        }else{
            self.viewAutor.isHidden = false
            self.viewHeight.constant = 130
        }
        self.lbl_Author.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
}
