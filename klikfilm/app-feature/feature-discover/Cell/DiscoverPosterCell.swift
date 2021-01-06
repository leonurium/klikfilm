//
//  DiscoverPosterCell.swift
//  klikfilm
//
//  Created by Rangga Leo on 06/01/21.
//

import UIKit
import Kingfisher

class DiscoverPosterCell: UICollectionViewCell {
    @IBOutlet weak var image_poster: UIImageView!
    @IBOutlet weak var lbl_title: KFLabelTitle!
    @IBOutlet weak var lbl_body: KFLabelBody!
    
    struct source {
        static var nib: UINib = UINib(nibName: String(describing: DiscoverPosterCell.self), bundle: Bundle(for: DiscoverPosterCell.self))
        static var identifier: String = String(describing: DiscoverPosterCell.self)
    }
    
    var movie: MovieItem? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        lbl_title.numberOfLines = 0
        lbl_title.textAlignment = .center
        lbl_title.setFontSize(12)
        lbl_title.textColor = KFColor.white.get()
        
        lbl_body.numberOfLines = 0
        lbl_body.textAlignment = .center
        lbl_body.setFontSize(12)
        lbl_body.textColor = KFColor.buttercup.get()
    }
    
    private func updateUI() {
        if let url_image = URL(string: URLConst.api_poster + PosterSize.w154.rawValue + (movie?.poster_path ?? "")) {
            image_poster.kf.setImage(with: url_image)
        }
        
        lbl_title.text = movie?.title
        lbl_body.text = "\(movie?.vote_average ?? 0.0)"
    }
}
