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
        var subjectDetail: ArticleDetailViewController?

        describe("ArticleViewController") {
            beforeEach {
                subject = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArticleViewController") as? ArticleViewController
                
                _ = subject?.view
                
                if let path = Bundle(for: type(of: self)
                    ).path(forResource: "article",
                           ofType: "json") {
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: path),
                                            options: .alwaysMapped)
                        let decoder = JSONDecoder()
                        let articlesData = try decoder.decode(Articles.self, from: data)
                        subject?.articles = articlesData.articles
                        subject?.articleTableView.reloadData()
                    } catch {
                        fail("Problem parsing JSON")
                    }
                }
            }
            
            context("when view is loaded") {
                it("should have 20 articles loaded") {
                    expect(subject?.articleTableView.numberOfRows(inSection: 0)).to(equal(20))
                }
            }
            
            context("Article Table View") {
                var cell: ArticleTableViewCell?
                
                beforeEach {
                    cell = subject?.articleTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ArticleTableViewCell
                }
                
                it("should show article title, byline and published date") {
                    expect(cell?.articleTitleLabel?.text).to(equal("Live U.S. House Election Results"))
                    expect(cell?.articleByLabel?.text).to(equal(""))
                    expect(cell?.articlePublishDateLabel?.text).to(equal("2019-11-06"))
                }
                
                context("Article Detail View") {
                    beforeEach {
                        
                        subject?.articleTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: UITableViewScrollPosition.top)
                        
                        subjectDetail = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArticleDetailViewController") as? ArticleDetailViewController
                        
                        _ = subjectDetail?.view
                    }
                    context("when view is loaded") {
                        it("should have article detail view") {
                        }
                    }
                }
            }
        }
    }
}
