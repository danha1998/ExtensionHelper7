//
//  File.swift
//
//
//  Created by DanHa on 25/03/2023.
//

import SwiftUI
import WebKit

@available(iOS 14.0, *)
struct Coords_Seven: UIViewRepresentable {
    func makeCoordinator() -> Lop_Coor_seven_dinator {
        Lop_Coor_seven_dinator(self)
    }

    let url: URL?
    @Binding var is_seven_chuyen_mam: Bool
    var arrayData: [String: String] = [:]
    
    private let ob_Seven_servable = Seven_Observable()
    var ob_Seven_server: NSKeyValueObservation? {
        ob_Seven_servable.ins_Seven_tance
    }

    // end check url

    func makeUIView(context: Context) -> WKWebView {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true // true

        let source: String = arrayData[ValueKey.Chung_fr_01.rawValue] ?? ""
        let script: WKUserScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)

        let userContentController: WKUserContentController = WKUserContentController()

        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        config.userContentController = userContentController
        userContentController.addUserScript(script)

        let webview = WKWebView(frame: .zero, configuration: config)
        webview.customUserAgent = arrayData[ValueKey.Chung_fr_02.rawValue] ?? ""
        webview.scrollView.isScrollEnabled = true

        webview.navigationDelegate = context.coordinator
        webview.load(URLRequest(url: url!))

        return webview
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        ob_Seven_servable.ins_Seven_tance = uiView.observe(\WKWebView.url, options: .new) { view, _ in
            let url = view.url
            if let urlv = URL(string: "\(String(describing: url))") {
                if urlv.absoluteString.range(of: arrayData[ValueKey.seven_fr_2a.rawValue] ?? "") != nil {
                    self.is_seven_chuyen_mam = true
                } // if webView
            } // urlv
        } // observable
    } // updateUIView

    class Lop_Coor_seven_dinator: NSObject, WKNavigationDelegate {
        var seven_parent: Coords_Seven
        init(_ seven_parent: Coords_Seven) {
            self.seven_parent = seven_parent
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        } // didStartProvisionalNavigation

        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                decisionHandler(WKNavigationActionPolicy.cancel)
                return
            }
            decisionHandler(WKNavigationActionPolicy.allow)
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript(arrayData[ValueKey.seven_fr_1a.rawValue] ?? "", completionHandler: { _, _ in })
            if webView.url?.absoluteString.range(of: "") != nil {
                seven_parent.is_seven_chuyen_mam = true
            }
        } // didFinish
    } // Coordinator
}

@available(iOS 14.0, *)
private class Seven_Observable: ObservableObject {
    @Published var ins_Seven_tance: NSKeyValueObservation?
}
