//
//  ArticleVC.swift
//  KisanHubAssignment
//
//  Created by Ashwinkumar Mangrulkar on 10/08/18.
//  Copyright © 2018 Ashwinkumar Mangrulkar. All rights reserved.
//

import UIKit
import SVProgressHUD

class ArticleVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    /// Articles data array
    var articlesArray: [ArticleModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        /// Remove unwatned seprator from tableview
        tableView.tableFooterView = UIView()
        
        webServiceGetArticles()
    }
    
    func webServiceGetArticles() {
        
        SVProgressHUD.show()
        
        WebService.sharedInstance.webServiceGetArticles { (success, response, error) in
            
            SVProgressHUD.dismiss()
            
            if error != nil {
                CustomAlertView.showNegativeAlert(NSLocalizedString("ALERT_SERVER_ERROR", comment: ""))
                return
            }
            
            guard let json = response, response != nil, success else {
                CustomAlertView.showNegativeAlert(NSLocalizedString("ALERT_RESPONSE_ERROR", comment: ""))
                return
            }
            
            print("Response json: \(json)")
            
            if let articles = json.value(forKey: "data") as? [AnyObject] {
                self.parseData(articles: articles)
            }
            
            self.tableView.reloadData()
        }
    }
    
    /// Method used to parse data and store in model
    ///
    /// - Parameter articles: json array
    func parseData(articles: [AnyObject]) {
        
        for article in articles {
            let title = article.value(forKey: "title") as? String
            let description = article.value(forKey: "description") as? String
            var imageUrl: String = ""
            var authorName: String?
            var authorImgUrl: String?
            var authorModelArray: [AuthorModel] = []
            var subscriptionModelArray: [SubsciptionModel] = []
            
            /// Get articles data
            if let featureImgArray = article.value(forKeyPath: "featured_image") as? [AnyObject] {
                if featureImgArray.count > 0 {
                    imageUrl = (featureImgArray[0].value(forKey: "image_file") as? String) ?? ""
                
                }
            }
            
            let status = article.value(forKey: "get_status_display") as? String
            let publishDate = article.value(forKey: "publish_date_readable") as? String
            
            /// Get authors data
            if let authors = article.value(forKey: "authors") as? [AnyObject] {
                for author in authors {
                    authorName = author.value(forKey: "full_name") as? String
                    authorImgUrl = (author.value(forKey: "picture") as? String) ?? ""
                    
                    let authorModelObject = AuthorModel(name: authorName!, profileUrl: authorImgUrl!)
                    authorModelArray.append(authorModelObject)
                }
            }
            
            /// Get subscription data
            if let subscriptions = article.value(forKey: "subscription_package") as? [AnyObject] {
                for subscription in subscriptions {
                    let id = subscription.value(forKey: "id") as? Int
                    let name = subscription.value(forKey: "name") as? String
                    
                    let subscriptionModelObj = SubsciptionModel(id: id!, name: name!)
                    subscriptionModelArray.append(subscriptionModelObj)
                }
            }
            
            let articleModelObject = ArticleModel(title: title!, description: description!, imageUrl: imageUrl, status: status!, publishDate: publishDate!, authors: authorModelArray, subscriptions: subscriptionModelArray)
            self.articlesArray.append(articleModelObject)
            
        }
    }
    
}

extension ArticleVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ArticleTableViewCell else {
            return ArticleTableViewCell()
        }
        
        cell.contentView.backgroundColor = UIColor(white: 0.93, alpha: 1)
        
        cell.displayData(model: articlesArray[indexPath.row])
        if(cell.authorCollectionView != nil){
            cell.authorCollectionView.reloadData()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
