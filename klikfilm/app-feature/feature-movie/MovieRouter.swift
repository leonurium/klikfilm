// 
//  MovieRouter.swift
//  klikfilm
//
//  Created by Rangga Leo on 06/01/21.
//

import UIKit

class MovieRouter: MoviePresenterToRouter {
    
    static func createMovieModule(movie: MovieItem) -> UIViewController {
        let view: UIViewController & MoviePresenterToView = MovieView()
        let presenter: MovieViewToPresenter & MovieInteractorToPresenter = MoviePresenter(movie: movie)
        let interactor: MoviePresenterToInteractor = MovieInteractor()
        let router: MoviePresenterToRouter = MovieRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}
