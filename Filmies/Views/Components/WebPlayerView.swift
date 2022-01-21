//
//  WebView.swift
//  Filmies
//
//  Created by bryan colin on 7/17/21.
//

import SwiftUI
import WebKit

struct WebPlayerView: UIViewRepresentable {
    
    let key: String?
    @State var loadOnce: Bool
    
    func makeUIView(context: Context) -> WebPlayerView.UIViewType {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if loadOnce, let key = key {
            guard let url = URL(string: "https://www.youtube.com/embed/\(key)?playsinline=1") else { fatalError() }
            let request = URLRequest(url: url)
            
            uiView.load(request)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.loadOnce = false     // must be async
            }
        }
    }
}
