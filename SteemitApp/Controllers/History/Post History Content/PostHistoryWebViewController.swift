//
//  PostHistoryWebViewController.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 2/10/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit
import WebKit

class PostHistoryWebViewController: UIViewController {
    
    @IBOutlet weak var webViewView: UIView!
    
    var webView: WKWebView?
    var post: PostHistoryModel?
    let endPoint = "https://steemit.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView.init(frame: CGRect.init(x: 0, y: 0, width: webViewView.frame.width, height: webViewView.frame.height))
        webView?.clipsToBounds = true
        webViewView.addSubview(webView!)
        let url = endPoint + (post?.url)!
        webView?.load(URLRequest.init(url: URL.init(string: url)!))
    }
}
