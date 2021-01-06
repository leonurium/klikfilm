//
//  DiscoverPosterCell.swift
//  klikfilm
//
//  Created by Rangga Leo on 06/01/21.
//

import UIKit

class DiscoverPosterCell: UICollectionViewCell {
    @IBOutlet weak var image_poster: UIImageView!
    @IBOutlet weak var lbl_title: KFLabelTitle!
    @IBOutlet weak var lbl_body: KFLabelBody!
    
    struct source {
        static var nib: UINib = UINib(nibName: String(describing: DiscoverPosterCell.self), bundle: Bundle(for: DiscoverPosterCell.self))
        static var identifier: String = String(describing: DiscoverPosterCell.self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        lbl_title.numberOfLines = 0
        lbl_title.setFontSize(18)
        lbl_title.textColor = KFColor.buttercup.get()
        
        lbl_body.numberOfLines = 0
        lbl_body.setFontSize(16)
        lbl_body.textColor = KFColor.buttercup.get()
    }
    
    private func updateUI() {
        
    }
}
