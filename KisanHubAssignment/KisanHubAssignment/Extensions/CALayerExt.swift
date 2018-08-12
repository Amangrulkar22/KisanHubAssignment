//
//  CALayerExt.swift
//  KisanHubAssignment
//
//  Created by Ashwinkumar Mangrulkar on 12/08/18.
//  Copyright © 2018 Ashwinkumar Mangrulkar. All rights reserved.
//

import Foundation

import Foundation
import UIKit

/**
 Set border color for uitextfield, uibutton, uiview using runtime entities
 */
public extension CALayer {
    var borderUIColor: UIColor {
        set {
            self.borderColor = newValue.cgColor
        }
        
        get {
            return UIColor(cgColor: self.borderColor!)
        }
    }
}
