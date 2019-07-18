//
//  ArticleTableViewCell.swift
//  NYTimesApp
//
//  Created by Marutharaj Kuppusamy on 10/20/18.
//  Copyright © 2019 ta. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet var articleTitleLabel: UILabel!
    @IBOutlet var articleByLabel: UILabel!
    @IBOutlet var articlePublishDateLabel: UILabel!
    @IBOutlet var articleImageView: UIImageView!
    //var indexPath : Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
