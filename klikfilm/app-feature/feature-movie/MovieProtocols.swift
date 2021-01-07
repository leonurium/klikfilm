// 
//  MovieProtocols.swift
//  klikfilm
//
//  Created by Rangga Leo on 06/01/21.
//

import UIKit


// MARK: View -
protocol MoviePresenterToView: class {
    var presenter: MovieViewToPresenter? { get set }
    
    func setupViews()
    func showAlert(title: String, message: String, okCompletion: (() -> Void)?)
    func showlAlertConfirm(title: String, message: String, okCompletion: (() -> Void)?, cancelCompletion: (() -> Void)?)
    func showLoaderIndicator()
    func dismissLoaderIndicator()
    func reloadTableView()
}

// MARK: Interactor -
protocol MoviePresenterToInteractor: class {
    var presenter: MovieInteractorToPresenter?  { get set }
    
    func getVideos(movieID: Int)
}


// MARK: Router -
protocol MoviePresenterToRouter: class {
    static func createMovieModule(movie: MovieItem) -> UIViewController
}

// MARK: Presenter -
protocol MovieViewToPresenter: class {
    var view: MoviePresenterToView? {get set}
    var interactor: MoviePresenterToInteractor? {get set}
    var router: MoviePresenterToRouter? {get set}
    
    func didLoad()
    func numberOfRowsInSection() -> Int
    func cellForMovieInfo(indexPath: IndexPath) -> MovieItem
    func cellForMovieTrailer() -> [VideoItem]
}

protocol MovieInteractorToPresenter: class {
    func didGetVideos(videos: [VideoItem])
    func failGetVideos(title: String, message: String)
}
