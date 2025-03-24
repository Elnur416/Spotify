//
//  AuthController.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.03.25.
//

import UIKit
import WebKit

class AuthController: BaseController {
    
//    MARK: Properties
    
    public var completionHandler: ((Bool) -> Void)?
    
//    MARK: - UI elements
    
    private lazy var webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let w = WKWebView(frame: .zero,
                          configuration: config)
        w.backgroundColor = .clear
        return w
    }()

//    MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        webView.frame = view.bounds
        configureWebView()
    }
    
    private func configureWebView() {
        webView.navigationDelegate = self
        guard let url = AuthManager.shared.signInURL else { return }
        webView.load(URLRequest(url: url))
    }
}

extension AuthController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else { return }
        guard let component = URLComponents(string: url.absoluteString) else { return }
        guard let code = component.queryItems?.first(where: { $0.name == "code" })?.value else { return }
        webView.isHidden = true
        AuthManager.shared.exchangeCodeForToken(code: code) { [weak self] success in
            DispatchQueue.main.async {
                switch success {
                case true:
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                    guard let sceneDelegate = windowScene.delegate as? SceneDelegate else { return }
                    sceneDelegate.tabRoot()
                case false:
                    self?.showAlert(message: "Something went wrong when signing in")
                }
            }
        }
    }
}
