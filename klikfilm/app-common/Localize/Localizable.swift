//
//  Localizable.swift
//  klikfilm
//
//  Created by Rangga Leo on 06/01/21.
//

import Foundation

enum Localizable {
    enum TitlePage: String, LocalizableDelegate {
        case page_discover
    }
    
    enum TitleAlert: String, LocalizableDelegate {
        case information
        case success
        case warning
        case error
    }
    
    enum Error: String, LocalizableDelegate {
        case something_wrong
    }
    
    enum Button: String, LocalizableDelegate {
        case ok
        case cancel
    }
}

typealias LTitlePage = Localizable.TitlePage
typealias LTitleAlert = Localizable.TitleAlert
typealias LError = Localizable.Error
typealias LButton = Localizable.Button
