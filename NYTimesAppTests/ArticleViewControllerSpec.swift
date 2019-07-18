//
//  ArticleTableViewCellSpec.swift
//  NYTimesAppUITests
//
//  Created by Marutharaj Kuppusamy on 11/10/18.
//  Copyright © 2019 ta. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import NYTimesApp

class ArticleViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        var subject: ArticleViewController?

        describe("Verify ArticleViewController") {
            
            beforeEach {
                subject = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArticleViewController") as? ArticleViewController
                
                subject?.viewModel = ArticleViewModel()
                let response = NYTimesResponse(json: jsonDictionary(with: "article"))
                subject?.viewModel.articles = response.articles
            }
            
            context("When setting up the data") {
                
                it("Should return correct number of sections") {
                    expect(subject?.viewModel.numberOfSections()) == 1
                }
                
                it("Should return correct number of rows") {
                    expect(subject?.viewModel.numberOfRows(in: 0)) == subject?.viewModel.articles.count
                }
                
                it("Should return a ArticleTableViewCell") {
                    let indexPath = IndexPath(row: 0, section: 0)
                    let cell = ArticleTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "articleCellId")
                    cell.articleTitleLabel = UILabel(frame: CGRect.zero)
                    cell.articlePublishDateLabel = UILabel(frame: CGRect.zero)
                    cell.articleByLabel = UILabel(frame: CGRect.zero)
                    let articleCell = subject?.viewModel.cellForRowAt(indexPath: indexPath, for: cell)
                    expect(articleCell is ArticleTableViewCell) == true
                }
            }
        }
    }
}
