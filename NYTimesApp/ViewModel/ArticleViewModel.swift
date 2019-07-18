//
//  ArticleViewModel.swift
//  NYTimesApp
//
//  Created by Apple on 7/18/19.
//  Copyright © 2019 ta. All rights reserved.
//

import UIKit

class ArticleViewModel {
    
    private let articleService = ArticleService()
    var articles: [Article] = []
    
    func fetchArticle(period: PeriodSection, completion: @escaping ((Bool)->())) {
        
        self.articleService.sendRequest(period: period.rawValue) { success, result, errorCode in
            self.articles = result?.articles ?? []
            completion(success)
        }
    }
}

extension ArticleViewModel {
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return articles.count
    }
    
    func cellForRowAt(indexPath: IndexPath, for cell: ArticleTableViewCell) -> UITableViewCell {
        
        let article = articles[indexPath.row]
        
        cell.articleByLabel.text = article.byline
        cell.articlePublishDateLabel.text = article.publishedDate
        cell.articleTitleLabel.text = article.title
        
        let imageUrl = NYUtility.getArticleThumbnailUrl(article: article)
        // Start background thread so that image loading does not make app unresponsive
        DispatchQueue.global(qos: .userInitiated).async {
            
            let imageData: NSData = NSData(contentsOf: imageUrl)!
            
            // When from background thread, UI needs to be updated on main_queue
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                cell.articleImageView.image = image
                cell.articleImageView.contentMode = UIViewContentMode.scaleAspectFit
            }
        }
        
        return cell
    }
}
