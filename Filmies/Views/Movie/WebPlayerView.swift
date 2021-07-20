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
    @State var loadOnce: Bool
    
    private let webView = WKWebView()
    
    func makeUIView(context: Context) -> WebPlayerView.UIViewType {
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if loadOnce {
            guard let url = URL(string: urlString ?? "https://www.youtube.com/embed/") else { fatalError() }
            let request = URLRequest(url: url)
            
            uiView.load(request)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.loadOnce = false     // must be async
            }
        }
    }
}
