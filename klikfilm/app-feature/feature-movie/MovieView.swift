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
            let movie = presenter?.cellForRowAt(indexPath: indexPath)
            let container = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 550))
            let image = UIImageView()
            if let url_image = URL(string: URLConst.api_poster + PosterSize.w154.rawValue + ( movie?.poster_path ?? "")) {
                image.kf.setImage(with: url_image)
            }
            image.center = container.center
            image.frame = container.frame
            container.addSubview(image)
            cell.contentView.addSubview(container)
            container.translatesAutoresizingMaskIntoConstraints = false
            container.heightAnchor.constraint(equalToConstant: 550).isActive = true
            container.topAnchor.constraint(equalTo: cell.contentView.topAnchor).isActive = true
            container.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor).isActive = true
            
            let gradientView = UIView()
            gradientView.backgroundColor = KFColor.mine_shaft.get().withAlphaComponent(0.5)
            container.addSubview(gradientView)
            gradientView.center = container.center
            gradientView.frame = CGRect(x: container.frame.minX, y: container.frame.midY, width: container.frame.width, height: container.frame.height/2)
            
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = container.bounds
            container.addSubview(blurEffectView)
            return cell
        }
        return UITableViewCell()
    }
    
    
}
