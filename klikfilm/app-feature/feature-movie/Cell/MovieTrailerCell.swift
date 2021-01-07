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
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        self.collectionView.autoCenterToCellWhileScrollDidFinish(scrollView: scrollView, targetContentOffset: targetContentOffset)
    }
}

extension MovieTrailerCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screen = UIScreen.main.bounds
        let height: CGFloat = 300
        let width: CGFloat = screen.width
        return CGSize(width: width, height: height)
    }
}


