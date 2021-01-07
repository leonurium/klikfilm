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
        setupViews()
    }
    
    func setupViews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(MovieInfoCell.source.nib, forCellReuseIdentifier: MovieInfoCell.source.identifier)
    }
}

extension MovieView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MovieInfoCell.source.identifier) as? MovieInfoCell {
            cell.movie = presenter?.cellForRowAt(indexPath: indexPath)
            return cell
        }
        return UITableViewCell()
    }
}
