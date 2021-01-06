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
}

extension DiscoverView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfItemsInSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverPosterCell.source.identifier, for: indexPath) as? DiscoverPosterCell {
            return cell
        }
        
        return UICollectionViewCell()
    }
}
