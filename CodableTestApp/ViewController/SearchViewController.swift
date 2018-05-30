//
//  SearchViewController.swift
//  CodableTestApp
//
//  Created by YooSeunghwan on 2018/05/02.
//  Copyright © 2018年 Yoo. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController, UISplitViewControllerDelegate {
    
    private struct Storyboard {
        static let ShowDetailSegue = "Show Detail"
    }
    
    private var detailItems:[DetailItem] = [DetailItem]()
    private var showTutorial: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splitViewController?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // TODO : need to tutorial Design
        if showTutorial {
            let alert = UIAlertController(title: "WELCOME", message: NSLocalizedString("Tutorial Description1", comment: ""), preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler:{
                [weak self] (action: UIAlertAction!) -> Void in
                
                self?.showTutorial = false
                let alert = UIAlertController(title: "", message: NSLocalizedString("Tutorial Description2", comment: ""), preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler:nil)
                alert.addAction(okAction)
                self?.present(alert, animated: true, completion: nil)
            })
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        searchGit()
    }
    
    private func searchGit() {
        if Reachability.isConnectedToNetwork() {
            let configManager = ConfigManager.sharedInstance
            configManager.description()
            guard var urlComponent = URLComponents(string: configManager.ApiPath!) else { return }
            let items = [
                URLQueryItem(name: "q", value: configManager.ApiQuery),
                URLQueryItem(name: "sort", value: configManager.ApiSort),
                URLQueryItem(name: "order", value: configManager.ApiOrder)
            ]
            
            urlComponent.queryItems = items
            guard let url = urlComponent.url else { return }
            
            // TODO : Alamofire
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let data = data else { return }
                do {
                    let decode = JSONDecoder()
                    let jsonData = try decode.decode(JsonData.self, from: data)
                    self?.setDetailItems(jsonData.items)
                    
                    DispatchQueue.main.sync {
                        self?.tableView.reloadData()
                        self?.refreshControl?.endRefreshing()
                    }
                } catch {
                    // TODO : error
                    print("error : \(error)")
                    self?.refreshControl?.endRefreshing()
                }
                }.resume()
        }else{
            print("Internet Connection not Available!")
        }
    }
    
    private func setDetailItems(_ items: [JsonItems]) {
        items.forEach { item in
            let tempItem = DetailItem(name:item.full_name,
                htmlUrl:item.html_url,
                stargazersCount:item.stargazers_count)
            detailItems.append(tempItem)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.ShowDetailSegue {
            if let ivc = segue.destination.contentViewController as? DetailViewController {
                if let cell = sender as? SearchViewCell, let detailItem = cell.detialItem {
                    ivc.siteURL = detailItem.htmlUrl
                    ivc.title = detailItem.name
                }
            }
        }
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let ivc = splitViewController?.viewControllers.last?.contentViewController as? DetailViewController {
            ivc.siteURL = (detailItems[indexPath.row]).htmlUrl
            ivc.title = (detailItems[indexPath.row]).name
        } else {
            performSegue(withIdentifier: Storyboard.ShowDetailSegue, sender: tableView.cellForRow(at: indexPath))
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)
        
        if let customCell = cell as? SearchViewCell {
            customCell.detialItem = detailItems[indexPath.row]
        }
        
        return cell
    }
    
    // MARK: - splitViewController delegate
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if primaryViewController.contentViewController == self {
            if let ivc = secondaryViewController.contentViewController as? DetailViewController, ivc.siteURL == nil {
                return true
            }
        }
        
        return false
    }
    
}

extension UIViewController {
    var contentViewController: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}

