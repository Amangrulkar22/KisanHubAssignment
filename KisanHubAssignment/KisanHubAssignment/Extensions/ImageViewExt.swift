//
//  ImageViewExt.swift
//  KisanHubAssignment
//
//  Created by Ashwinkumar Mangrulkar on 12/08/18.
//  Copyright © 2018 Ashwinkumar Mangrulkar. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    public func imageFromUrl(_ url: URL, placeHolderImage:UIImage!, shouldResize : Bool, showActivity : Bool, withCompletionHandler:@escaping (_ success:Bool, _ image:UIImage?,_ error: NSError?)->Void)
    {
        
        if showActivity == true
        {
            self.kf.indicatorType = .activity
        }
        
        self.kf.setImage(with: url, placeholder: placeHolderImage, options: nil,progressBlock: { receivedSize, totalSize in
        },
                         completionHandler: { image, error, cacheType, imageURL in withCompletionHandler(true,image,error)
        })
    }
}
