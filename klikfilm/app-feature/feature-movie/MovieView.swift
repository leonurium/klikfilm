//
//  MovieView.swift
//  klikfilm
//
//  Created by Rangga Leo on 06/01/21.
//

import UIKit
import Foundation
import Kingfisher

class MovieView: UIViewController, MoviePresenterToView {
    var presenter: MovieViewToPresenter?
    
    @IBOutlet weak var tableView: UITableView!
    
    init() {
        super.init(nibName: String(describing: MovieView.self), bundle: Bundle(for: MovieView.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.didLoad()
    }
    
    func setupViews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = KFColor.mine_shaft.get()
        tableView.register(MovieInfoCell.source.nib, forCellReuseIdentifier: MovieInfoCell.source.identifier)
        tableView.register(MovieTrailerCell.source.nib, forCellReuseIdentifier: MovieTrailerCell.source.identifier)
    }
    
    func showAlert(title: String, message: String, okCompletion: (() -> Void)?) {
        showAlert(title: title, message: message) { (act) in
            okCompletion?()
        }
    }
    
    func showlAlertConfirm(title: String, message: String, okCompletion: (() -> Void)?, cancelCompletion: (() -> Void)?) {
        showAlertConfirm(title: title, message: message) { (act) in
            okCompletion?()
        } CancelCompletion: { (act) in
            cancelCompletion?()
        }
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
}

extension MovieView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0,
           let cell = tableView.dequeueReusableCell(withIdentifier: MovieInfoCell.source.identifier) as? MovieInfoCell {
            cell.movie = presenter?.cellForMovieInfo(indexPath: indexPath)
            return cell
            
        } else
        if indexPath.row == 1,
           let cell = tableView.dequeueReusableCell(withIdentifier: MovieTrailerCell.source.identifier) as? MovieTrailerCell {
            cell.delegate = self
            cell.videos = presenter?.cellForMovieTrailer() ?? []
            return cell
        }
        
        return UITableViewCell()
    }
}

extension MovieView: MovieTrailerCellDelegate {
    func updateHeightOfRow(cell: MovieTrailerCell, collectionView: UICollectionView) {
        let size = collectionView.bounds.size
        let newSize = tableView.sizeThatFits(
            CGSize(
                width: size.width,
                height: CGFloat.greatestFiniteMagnitude
            ))
        if size.height != newSize.height {
            UIView.setAnimationsEnabled(false)
            tableView?.beginUpdates()
            tableView?.endUpdates()
            UIView.setAnimationsEnabled(true)
            if let thisIndexPath = tableView.indexPath(for: cell) {
                tableView.scrollToRow(at: thisIndexPath, at: .bottom, animated: false)
            }
        }
    }
}
