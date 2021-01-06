//
//  MovieInfoCell.swift
//  klikfilm
//
//  Created by Rangga Leo on 06/01/21.
//

import UIKit
import Kingfisher

class MovieInfoCell: UITableViewCell {
    
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
        
    }
    
    private func updateUI() {

    }
}
