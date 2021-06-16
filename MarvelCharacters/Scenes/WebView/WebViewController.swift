//
//  WebViewController.swift
//  MarvelCharacters
//
//  Created by Tomás Fernández Velazco on 16/06/2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var url = ""
    var titleWeb = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleWeb
        loadUrl()
    }
    
    func loadUrl() {
        let urlF = URL(string: url)
        webView.load(URLRequest(url: urlF!))
    }
}
