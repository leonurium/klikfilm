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
    
    init() {
        super.init(nibName: String(describing: DiscoverView.self), bundle: Bundle(for: DiscoverView.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
