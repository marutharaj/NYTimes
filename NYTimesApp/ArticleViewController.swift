//
//  ArticleViewController.swift
//  NYTimesApp
//
//  Created by Marutharaj Kuppusamy on 10/20/18.
//  Copyright © 2019 ta. All rights reserved.
//

import UIKit

enum PeriodSection: Int {
    case one = 1
    case seven = 7
    case thirty = 30
}

class ArticleViewController: UIViewController {
    
    @IBOutlet var articleTableView: UITableView!
    var viewModel: ArticleViewModel!

    private let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    func fetchArticle(period: PeriodSection) {
        
        showActivityIndicator()
        
        viewModel.fetchArticle(period: period) { result in
            if result {
                DispatchQueue.main.async {
                    self.activityIndicator.removeFromSuperview()
                    self.articleTableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.viewModel = ArticleViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fetchArticle(period: .one)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "articleDetailSegueIdentifier" {
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as? ArticleDetailViewController
            // your new view controller should have property that will store passed value
            //let cell : ArticleTableViewCell = sender as! ArticleTableViewCell
            let indexPath: IndexPath = self.articleTableView.indexPathForSelectedRow!
            viewController?.article = viewModel.articles[indexPath.row]
        }
    }
}

extension ArticleViewController {
    
    // MARK: - Private Methods
    
    fileprivate func showActivityIndicator() {
        // Add it to the view where you want it to appear
        self.view.addSubview(activityIndicator)
        
        // Set up its size (the super view bounds usually)
        activityIndicator.frame = view.bounds
        // Start the loading animation
        activityIndicator.startAnimating()
    }
}

extension ArticleViewController {
    
    @IBAction func showSearchOption(sender: AnyObject) {
        let alert = UIAlertController(title: "Article Period Path", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "1", style: .default, handler: { [weak self] (_) in
            self?.fetchArticle(period: .one)
        }))
        
        alert.addAction(UIAlertAction(title: "7", style: .default, handler: { [weak self] (_) in
            self?.fetchArticle(period: .seven)
        }))
        
        alert.addAction(UIAlertAction(title: "30", style: .default, handler: { [weak self] (_) in
            self?.fetchArticle(period: .thirty)
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_)in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
}

extension ArticleViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCellId", for: indexPath) as? ArticleTableViewCell
        
        return viewModel.cellForRowAt(indexPath: indexPath, for: cell!)
    }
}
