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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
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
        }
    }
    
}

extension ArticleVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ArticleTableViewCell else {
            return ArticleTableViewCell()
        }
        
        cell.contentView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        return cell
    }
}
