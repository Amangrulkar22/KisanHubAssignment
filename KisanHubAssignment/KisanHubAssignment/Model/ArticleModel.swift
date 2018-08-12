//
//  ArticleModel.swift
//  KisanHubAssignment
//
//  Created by Ashwinkumar Mangrulkar on 12/08/18.
//  Copyright © 2018 Ashwinkumar Mangrulkar. All rights reserved.
//

import Foundation

/// Article model
struct ArticleModel {
    private(set) public var title: String
    private(set) public var description: String
    private(set) public var imageUrl: String
    private(set) public var status: String
    private(set) public var publishDate: String
    private(set) public var authors: [AuthorModel]
    private(set) public var subscriptions: [SubsciptionModel]
    
    init(title: String, description: String, imageUrl: String, status: String, publishDate: String, authors: [AuthorModel], subscriptions: [SubsciptionModel]) {
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
        self.status = status
        self.publishDate = publishDate
        self.authors = authors
        self.subscriptions = subscriptions
    }
    
}

/// Author model
struct AuthorModel {
    private(set) public var name: String
    private(set) public var profileUrl: String
    
    init(name: String, profileUrl: String) {
        self.name = name
        self.profileUrl = profileUrl
    }
}

/// Subscription model
struct SubsciptionModel {
    private(set) public var id: Int
    private(set) public var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
