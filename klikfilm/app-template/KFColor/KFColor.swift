//
//  KFColor.swift
//  klikfilm
//
//  Created by Rangga Leo on 06/01/21.
//

import UIKit

// name color on https://chir.ag/projects/name-that-color/

enum KFColor: String {
    case dove_gray = "696969" // gray dark
    case mine_shaft = "333333" // black
    case white = "FFFFFF" // white
    case alto = "D6D6D6" // gray light
    case buttercup = "F0BE0C" // orange
        
    func get() -> UIColor {
        return self.rawValue.hexToUIColor()
    }
}
