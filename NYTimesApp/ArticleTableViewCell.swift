//
//  ArticleTableViewCell.swift
//  NYTimesApp
//
//  Created by Marutharaj Kuppusamy on 10/20/18.
//  Copyright © 2019 ta. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleByLabel: UILabel!
    @IBOutlet weak var articlePublishDateLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
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
