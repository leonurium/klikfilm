//
//  MovieView.swift
//  klikfilm
//
//  Created by Rangga Leo on 06/01/21.
//

import UIKit
import Foundation

class MovieView: UIViewController, MoviePresenterToView {
    var presenter: MovieViewToPresenter?
    
    init() {
        super.init(nibName: String(describing: MovieView.self), bundle: Bundle(for: MovieView.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
