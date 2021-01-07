//
//  MovieInfoCell.swift
//  klikfilm
//
//  Created by Rangga Leo on 06/01/21.
//

import UIKit
import Kingfisher

class MovieInfoCell: UITableViewCell {
    
    @IBOutlet weak var image_background: KFImageBlurView!
    @IBOutlet weak var image_poster: UIImageView!
    @IBOutlet weak var lbl_rate: KFLabelTitle!
    @IBOutlet weak var lbl_date: KFLabelBody!
    @IBOutlet weak var lbl_popularity: KFLabelBody!
    @IBOutlet weak var lbl_title: KFLabelTitle!
    @IBOutlet weak var lbl_overview: KFLabelBody!
    
    struct source {
        static var nib: UINib = UINib(nibName: String(describing: MovieInfoCell.self), bundle: Bundle(for: MovieInfoCell.self))
        static var identifier: String = String(describing: MovieInfoCell.self)
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
        lbl_rate.textColor = KFColor.buttercup.get()
        lbl_date.textColor = KFColor.alto.get()
        lbl_popularity.textColor = KFColor.alto.get()
        lbl_title.textColor = KFColor.white.get()
        lbl_overview.textColor = KFColor.white.get()
        
        lbl_rate.setFontSize(16)
        lbl_date.setFontSize(16)
        lbl_popularity.setFontSize(16)
        lbl_title.setFontSize(22)
        lbl_overview.setFontSize(14)
        
        lbl_title.numberOfLines = 0
        lbl_overview.numberOfLines = 0
        
        lbl_title.textAlignment = .center
    }
    
    private func updateUI() {
        if let url_image = URL(string: URLConst.api_poster + PosterSize.w154.rawValue + (movie?.poster_path ?? "")) {
            image_background.kf.setImage(with: url_image)
            image_poster.kf.setImage(with: url_image)
        }
        
        lbl_rate.text = String(describing: movie?.vote_average ?? 0)
        lbl_date.text = movie?.release_date
        lbl_popularity.text = String(describing: movie?.popularity ?? 0)
        lbl_title.text = movie?.title
        lbl_overview.text = movie?.overview
    }
}
