//
//  DetailItem.swift
//  CodableTestApp
//
//  Created by YooSeunghwan on 2018/05/02.
//  Copyright © 2018年 Yoo. All rights reserved.
//

import Foundation

class DetailItem : NSObject {
    var name: String
    var htmlUrl: URL?
    var stargazersCount: Int
    
    init(name: String, htmlUrl: URL?, stargazersCount: Int) {
        self.name = name
        self.htmlUrl = htmlUrl
        self.stargazersCount = stargazersCount
    }
}
