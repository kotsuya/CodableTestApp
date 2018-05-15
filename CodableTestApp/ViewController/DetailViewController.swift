//
//  DetailViewController.swift
//  CodableTestApp
//
//  Created by YooSeunghwan on 2018/05/02.
//  Copyright © 2018年 Yoo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var closeButton: UIBarButtonItem!
    
    // TODO : WKWebView
    @IBOutlet weak var detailWebView: UIWebView!
    
    // TODO : SVProgressHUD
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var detailItem: DetailItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailWebView.delegate = self
        indicatorView.layer.cornerRadius = 5
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let detailItem = detailItem else { return }
        
        navigationBar.title = "\(detailItem.name)(\(detailItem.stargazersCount))"
        
        let request = URLRequest(url: detailItem.htmlUrl!)
        detailWebView.loadRequest(request)
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func safariAction(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "[Safari]へ移動しますか？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            if let url = self.detailItem.htmlUrl {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        })
        let cancelAction = UIAlertAction(title: "CANCEL", style: .default, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension DetailViewController: UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        indicatorView.isHidden = false
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        indicatorView.isHidden = true
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        indicatorView.isHidden = true
    }
}

