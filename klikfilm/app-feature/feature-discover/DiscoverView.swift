//
//  DiscoverView.swift
//  klikfilm
//
//  Created by Rangga Leo on 06/01/21.
//

import UIKit
import Foundation

class DiscoverView: UIViewController, DiscoverPresenterToView {
    var presenter: DiscoverViewToPresenter?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    init() {
        super.init(nibName: String(describing: DiscoverView.self), bundle: Bundle(for: DiscoverView.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.didLoad()
    }
    
    func setupViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DiscoverPosterCell.source.nib, forCellWithReuseIdentifier: DiscoverPosterCell.source.identifier)
    }
    
    func showAlert(title: String, message: String, okCompletion: (() -> Void)?) {
        super.showAlert(title: title, message: message) { (act) in
            okCompletion?()
        }
    }
    
    func showlAlertConfirm(title: String, message: String, okCompletion: (() -> Void)?, cancelCompletion: (() -> Void)?) {
        super.showAlertConfirm(title: title, message: message) { (act) in
            okCompletion?()
        } CancelCompletion: { (act) in
            cancelCompletion?()
        }
    }
    
    override func showLoaderIndicator() {
        super.showLoaderIndicator()
    }
    
    override func dismissLoaderIndicator() {
        super.dismissLoaderIndicator()
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
}

extension DiscoverView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfItemsInSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverPosterCell.source.identifier, for: indexPath) as? DiscoverPosterCell {
            cell.movie = presenter?.cellForItemAt(indexPath: indexPath)
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension DiscoverView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screen = UIScreen.main.bounds
        let height: CGFloat = 400
        let width: CGFloat = screen.width / 3
        return CGSize(width: width, height: height)
    }
}
