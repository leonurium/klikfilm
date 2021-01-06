//
//  UIViewController+Ext.swift
//  klikfilm
//
//  Created by Rangga Leo on 06/01/21.
//

import UIKit

extension UIViewController {
    public func showAlert(title: String?, message: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        let alertController             = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.view.tintColor  = KFColor.brandColor()
        
        alertController.addAction(UIAlertAction(title: LButton.ok.localized, style: .default, handler: handler))
        self.present(alertController, animated: true, completion: nil)
    }
    
    public func showAlertConfirm(title: String?, message: String? = nil, OKCompletion: ((UIAlertAction) -> Void)? = nil, CancelCompletion: ((UIAlertAction) -> Void)? = nil) {
        let alert               = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor    = KFColor.brandColor()
        alert.addAction(UIAlertAction(title: LButton.ok.localized, style: .default, handler: OKCompletion))
        alert.addAction(UIAlertAction(title: LButton.cancel.localized, style: .cancel, handler: CancelCompletion))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc
    func showLoaderIndicator() {
        if let window = UIApplication.shared.keyWindow {
            DispatchQueue.main.async {
                let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
                activityIndicator.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                activityIndicator.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
                activityIndicator.startAnimating()
                
                window.addSubview(activityIndicator)
                activityIndicator.center = window.center
            }
        }
    }
    
    @objc
    func dismissLoaderIndicator() {
        if let window = UIApplication.shared.keyWindow {
            DispatchQueue.main.async {
                window.subviews.compactMap { $0 as? UIActivityIndicatorView }.forEach {
                    $0.backgroundColor = .clear
                    $0.removeFromSuperview()
                }
            }
        }
    }
}
