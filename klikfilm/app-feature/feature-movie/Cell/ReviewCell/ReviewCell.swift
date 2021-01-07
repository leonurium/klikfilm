//
//  ReviewCell.swift
//  klikfilm
//
//  Created by Rangga Leo on 07/01/21.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    @IBOutlet weak var lbl_author: KFLabelTitle!
    @IBOutlet weak var lbl_content: KFLabelBody!
    
    struct source {
        static var nib: UINib = UINib(nibName: String(describing: ReviewCell.self), bundle: Bundle(for: ReviewCell.self))
        static var identifier: String = String(describing: ReviewCell.self)
    }
    
    var review: ReviewItem? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        lbl_author.setFontSize(16)
        lbl_content.setFontSize(14)
        
        lbl_author.textColor = KFColor.white.get()
        lbl_content.textColor = KFColor.white.get()
        
        lbl_content.textAlignment = .justified
    }
    
    private func updateUI() {
        lbl_author.text = review?.author
        lbl_content.text = review?.content
    }
}
