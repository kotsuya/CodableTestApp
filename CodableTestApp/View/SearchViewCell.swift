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
    
    var detialItem: DetailItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(_ item: DetailItem) {
        detialItem = item
        
        nameLabel.text = item.name
        urlLabel.text = item.htmlUrl?.absoluteString
        starLabel.text = "\(item.stargazersCount)"
    }
}


