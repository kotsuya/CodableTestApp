//
//  SearchViewCell.swift
//  CodableTestApp
//
//  Created by YooSeunghwan on 2018/05/02.
//  Copyright © 2018年 Yoo. All rights reserved.
//

import UIKit

class SearchViewCell : UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    
    var detialItem: DetailItem? { didSet { updateUI() } }
    
    private func updateUI() {
        if let item = detialItem {
            nameLabel.text = item.name
            urlLabel.text = item.htmlUrl?.absoluteString
            starLabel.text = "⭐️\(item.stargazersCount)"
        }        
    }
}


