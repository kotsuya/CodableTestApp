//
//  DetailViewController.swift
//  CodableTestApp
//
//  Created by YooSeunghwan on 2018/05/02.
//  Copyright © 2018年 Yoo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIWebViewDelegate {
    
    // TODO : WKWebView
    @IBOutlet weak var detailWebView: UIWebView!
    
    // TODO : SVProgressHUD
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var siteURL: URL? {
        didSet {
            if view.window != nil {
                loadRequest()
            }
        }
    }
    
    private func loadRequest() {
        if let url = siteURL {
            let request = URLRequest(url: url)
            detailWebView.loadRequest(request)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailWebView.delegate = self
        indicatorView.layer.cornerRadius = 5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if siteURL != nil { loadRequest() }
    }
    
    @IBAction private func safariAction(_ sender: UIBarButtonItem) {
         let alert = UIAlertController(title: "", message: "[Safari]へ移動しますか？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in
            if let url = self?.siteURL {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        })
        let cancelAction = UIAlertAction(title: "CANCEL", style: .default, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Web view data source
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        indicatorView.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        indicatorView.stopAnimating()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        indicatorView.stopAnimating()
    }
}
