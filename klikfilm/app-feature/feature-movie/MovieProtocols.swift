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
}

// MARK: Interactor -
protocol MoviePresenterToInteractor: class {
    var presenter: MovieInteractorToPresenter?  { get set }
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
}

protocol MovieInteractorToPresenter: class {
}
