//
//  ArticleDetailViewController.swift
//  NYTimesApp
//
//  Created by Marutharaj Kuppusamy on 10/20/18.
//  Copyright © 2019 ta. All rights reserved.
//

import UIKit
import WebKit

class ArticleDetailViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet var navigationBar: UINavigationBar?
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleDescriptionLabel: UILabel!
    @IBOutlet weak var articlePublishedDateLabel: UILabel!
    
    var article: Article?
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    private func setupView() {

        if let article = article {
            self.articleTitleLabel.attributedText = attributedString(boldText: "Title: ", normalText: article.title ?? "")
            self.articleDescriptionLabel.attributedText = attributedString(boldText: "Description: ", normalText: article.abstract ?? "")
            self.articlePublishedDateLabel.attributedText = attributedString(boldText: "Published Date: ", normalText: article.publishedDate ?? "")
            
            let imageUrl = NYUtility.getArticleThumbnailUrl(article: article)
            // Start background thread so that image loading does not make app unresponsive
            DispatchQueue.global(qos: .userInitiated).async {
            
            let imageData: NSData = NSData(contentsOf: imageUrl)!
            
                // When from background thread, UI needs to be updated on main_queue
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData as Data)
                    self.articleImage.image = image
                    self.articleImage.contentMode = UIViewContentMode.scaleAspectFit
                }
            }
        }
    }
    
    private func attributedString(boldText: String, normalText: String) -> NSMutableAttributedString {
        let boldAttributes = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)]
        let attributedString = NSMutableAttributedString(string: boldText, attributes: boldAttributes)
        
        let normalAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]
        let normalString = NSMutableAttributedString(string: normalText, attributes: normalAttributes)
        
        attributedString.append(normalString)
        return attributedString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let topItem = self.navigationBar?.topItem,
            let article = article {
            topItem.title = article.source
        }
    }

    @IBAction func backButtonAction(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
