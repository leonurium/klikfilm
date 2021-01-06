//
//  KFLabelTitle.swift
//  klikfilm
//
//  Created by Rangga Leo on 06/01/21.
//

import UIKit

class KFLabelTitle: UILabel {
    
    private var fontSize: CGFloat = 0 {
        didSet {
            self.font = KFFont.heavy.size(fontSize)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        let size_font: CGFloat  = self.font.pointSize
        font = KFFont.heavy.size(size_font)
    }
    
    public func setFontSize(_ size: CGFloat) {
        fontSize = size
    }
}
