//
//  TrailerCell.swift
//  klikfilm
//
//  Created by Rangga Leo on 07/01/21.
//

import UIKit
import youtube_ios_player_helper

class TrailerCell: UICollectionViewCell {
    
    @IBOutlet weak var playerView: YTPlayerView!
    
    struct source {
        static var nib: UINib = UINib(nibName: String(describing: TrailerCell.self), bundle: Bundle(for: TrailerCell.self))
        static var identifier: String = String(describing: TrailerCell.self)
    }
    
    var video: VideoItem? {
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
        playerView.load(withVideoId: video?.key ?? "")
    }
}
