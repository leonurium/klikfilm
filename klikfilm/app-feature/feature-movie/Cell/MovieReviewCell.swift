//
//  MovieReviewCell.swift
//  klikfilm
//
//  Created by Rangga Leo on 07/01/21.
//

import UIKit

class MovieReviewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    struct source {
        static var nib: UINib = UINib(nibName: String(describing: MovieReviewCell.self), bundle: Bundle(for: MovieReviewCell.self))
        static var identifier: String = String(describing: MovieReviewCell.self)
    }
    
    var reviews: [ReviewItem] = [] {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = KFColor.mine_shaft.get()
        collectionView.register(ReviewCell.source.nib, forCellWithReuseIdentifier: ReviewCell.source.identifier)
    }
    
    private func updateUI() {
        collectionView.reloadData()
    }
}

extension MovieReviewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        reviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCell.source.identifier, for: indexPath) as? ReviewCell {
            cell.review = reviews[indexPath.row]
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        self.collectionView.autoCenterToCellWhileScrollDidFinish(scrollView: scrollView, targetContentOffset: targetContentOffset)
    }
}

extension MovieReviewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screen = UIScreen.main.bounds
        let height: CGFloat = 200
        let width: CGFloat = screen.width / 2
        return CGSize(width: width, height: height)
    }
}
