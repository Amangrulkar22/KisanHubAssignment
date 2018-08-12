//
//  MapModel.swift
//  KisanHubAssignment
//
//  Created by Ashwinkumar Mangrulkar on 10/08/18.
//  Copyright © 2018 Ashwinkumar Mangrulkar. All rights reserved.
//

import Foundation

/// Map model

struct MapModel {
    
    private(set) public var latitude: Double
    private(set) public var longitude: Double
    private(set) public var title: String
    
    init(latitude: Double, longitude: Double, title: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.title = title
    }
}
