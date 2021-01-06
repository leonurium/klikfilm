// 
//  DiscoverProtocols.swift
//  klikfilm
//
//  Created by Rangga Leo on 06/01/21.
//

import UIKit


// MARK: View -
protocol DiscoverPresenterToView: class {
    var presenter: DiscoverViewToPresenter? { get set }
    
    func setupViews()
    func showAlert(title: String, message: String, okCompletion: (() -> Void)?)
    func showlAlertConfirm(title: String, message: String, okCompletion: (() -> Void)?, cancelCompletion: (() -> Void)?)
    func showLoaderIndicator()
    func dismissLoaderIndicator()
    func reloadCollectionView()
}

// MARK: Interactor -
protocol DiscoverPresenterToInteractor: class {
    var presenter: DiscoverInteractorToPresenter?  { get set }
    
    func getDiscover(page: Int?)
}


// MARK: Router -
protocol DiscoverPresenterToRouter: class {
    static func createDiscoverModule() -> UIViewController
}

// MARK: Presenter -
protocol DiscoverViewToPresenter: class {
    var view: DiscoverPresenterToView? {get set}
    var interactor: DiscoverPresenterToInteractor? {get set}
    var router: DiscoverPresenterToRouter? {get set}
    
    func didLoad()
    func numberOfItemsInSection() -> Int
    func cellForItemAt(indexPath: IndexPath) -> MovieItem
}

protocol DiscoverInteractorToPresenter: class {
    func didGetDiscover(movie: MoviesResponse)
    func failGetDiscover(title: String, message: String)
}
