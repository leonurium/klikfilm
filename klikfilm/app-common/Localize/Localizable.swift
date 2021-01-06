//
//  Localizable.swift
//  klikfilm
//
//  Created by Rangga Leo on 06/01/21.
//

import Foundation

enum Localizable {
    enum TitleAlert: String, LocalizableDelegate {
        case information
        case success
        case warning
        case error
    }
    
    enum Error: String, LocalizableDelegate {
        case something_wrong
    }
}

typealias LTitleAlert = Localizable.TitleAlert
typealias LError = Localizable.Error
