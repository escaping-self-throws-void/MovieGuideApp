//
//  WebViewController.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 11/07/2022.
//

import UIKit
import WebKit

final class WebViewController: UIViewController, WKNavigationDelegate {
    
    private var webView: WKWebView!
    private var website: String
    
    init(_ link: String) {
        website = link
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .black
        if let url = URL(string: website) {
            webView.load(URLRequest(url: url))
        }
        webView.allowsBackForwardNavigationGestures = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}
