//
//  ReviewCell.swift
//  klikfilm
//
//  Created by Rangga Leo on 07/01/21.
//

import UIKit
import Kingfisher

class ReviewCell: UICollectionViewCell {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var image_avatar: UIImageView!
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
        container.layer.cornerRadius     = 15
        container.layer.shadowColor      = UIColor.black.withAlphaComponent(0.25).cgColor
        container.layer.shadowOffset     = CGSize(width: 0, height: 0)
        container.layer.shadowRadius     = 10.0
        container.layer.shadowOpacity    = 30.0
        container.layer.masksToBounds    = false
        
        lbl_author.setFontSize(14)
        lbl_content.setFontSize(14)
        
        lbl_author.textColor = KFColor.mine_shaft.get()
        lbl_content.textColor = KFColor.mine_shaft.get()
        
        lbl_author.numberOfLines = 0
        lbl_content.numberOfLines = 0
        
        lbl_content.textAlignment = .justified
    }
    
    private func updateUI() {
        if let url_avatar = URL(string: review?.author_details.avatar_path ?? "") {
            image_avatar.kf.setImage(with: url_avatar, placeholder: nil, options: nil, progressBlock: nil) { (result) in
                switch result {
                case .failure(let err):
                    debugLog(err)
                    self.image_avatar.setImageForName(string: self.review?.author ?? "Anonymous", circular: true)
                case .success(let res):
                    self.image_avatar.image = res.image
                }
            }
        } else {
            image_avatar.setImageForName(string: review?.author ?? "Anonymous", circular: true)
        }
        
        lbl_author.text = review?.author
        lbl_content.text = review?.content
    }
}
