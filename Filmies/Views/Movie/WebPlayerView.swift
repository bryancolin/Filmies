//
//  WebView.swift
//  Filmies
//
//  Created by bryan colin on 7/17/21.
//

import SwiftUI
import WebKit

struct WebPlayerView: UIViewRepresentable {
    
    let urlString: String?
    
    func makeUIView(context: Context) -> WebPlayerView.UIViewType {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let safeString = urlString {
            if let url = URL(string: safeString) {
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }
}
