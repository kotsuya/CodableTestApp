//
//  SearchViewController.swift
//  CodableTestApp
//
//  Created by YooSeunghwan on 2018/05/02.
//  Copyright © 2018年 Yoo. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var searchButton: UIBarButtonItem!
    @IBOutlet weak var searchTableView: UITableView!
    
    var rssItems: [RssItems] = []
    var detailItems:[DetailItem] = [DetailItem]()
    
    var showTutorial: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.dataSource = self
        searchTableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // TODO : need to tutorial Design
        if showTutorial {
            let alert = UIAlertController(title: "WELCOME", message: NSLocalizedString("Tutorial Description1", comment: ""), preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler:{
                (action: UIAlertAction!) -> Void in
                
                self.showTutorial = false
                let alert = UIAlertController(title: "", message: NSLocalizedString("Tutorial Description2", comment: ""), preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler:nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            })
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func searchAction(_ sender: Any) {
        UIAlertController.showIndicatorAlert(self, message: NSLocalizedString("Searching", comment: ""))
        
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
        }else{
            print("Internet Connection not Available!")
        }
        
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
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decode = JSONDecoder()
                let rss = try decode.decode(Rss.self, from: data)
                
                DispatchQueue.main.sync {
                    //print(rss)
                    self.rssItems = rss.items
                    
                    self.setupDetailItems(rss.items)
                    self.searchTableView.reloadData()
                }
            } catch {
                // TODO : error
                print("error : \(error)")
            }
            }.resume()
    }
    
    func setupDetailItems(_ items: [RssItems]) {
        
        items.forEach { item in
            let tempItem = DetailItem(name:item.full_name,//item.name,
                htmlUrl:item.html_url,
                stargazersCount:item.stargazers_count)
            detailItems.append(tempItem)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDetailViewController") {
            let detailViewController: DetailViewController = (segue.destination as? DetailViewController)!
            
            if let selectedRow = self.searchTableView.indexPathForSelectedRow?.row {
                detailViewController.detailItem = detailItems[selectedRow]
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rssItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchViewCell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! SearchViewCell
        cell.setCell(detailItems[indexPath.row])
        return cell
    }
}

