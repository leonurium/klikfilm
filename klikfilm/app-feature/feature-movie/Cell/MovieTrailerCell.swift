//
//  MovieTrailerCell.swift
//  klikfilm
//
//  Created by Rangga Leo on 07/01/21.
//

import UIKit

protocol MovieTrailerCellDelegate: class {
    func updateHeightOfRow(cell: MovieTrailerCell, collectionView: UICollectionView)
}

class MovieTrailerCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    struct source {
        static var nib: UINib = UINib(nibName: String(describing: MovieTrailerCell.self), bundle: Bundle(for: MovieTrailerCell.self))
        static var identifier: String = String(describing: MovieTrailerCell.self)
    }
    
    var videos: [VideoItem] = [] {
        didSet {
            updateUI()
        }
    }
    
    weak var delegate: MovieTrailerCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = KFColor.mine_shaft.get()
        collectionView.register(TrailerCell.source.nib, forCellWithReuseIdentifier: TrailerCell.source.identifier)
    }
    
    private func updateUI() {
        collectionView.reloadData()
        delegate?.updateHeightOfRow(cell: self, collectionView: collectionView)
    }
}

extension MovieTrailerCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrailerCell.source.identifier, for: indexPath) as? TrailerCell {
            cell.video = videos[indexPath.row]
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension MovieTrailerCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screen = UIScreen.main.bounds
        let height: CGFloat = screen.height
        let width: CGFloat = screen.width / 2
        return CGSize(width: width, height: height)
    }
}

class TrailerCollectionView: UICollectionView {
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        if !(__CGSizeEqualToSize(bounds.size,self.intrinsicContentSize)){
//            self.invalidateIntrinsicContentSize()
//        }
//    }
//    override var intrinsicContentSize: CGSize {
//        return contentSize
//    }
}


