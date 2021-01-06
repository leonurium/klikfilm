//
//  UIimage+Ext.swift
//  klikfilm
//
//  Created by Rangga Leo on 06/01/21.
//

import UIKit

extension UIImage {
    convenience init?(identifierName: Identifier.ImageName) {
        self.init(named: identifierName.rawValue)
    }
}
