// 
//  DiscoverRouter.swift
//  klikfilm
//
//  Created by Rangga Leo on 06/01/21.
//

import UIKit

class DiscoverRouter: DiscoverPresenterToRouter {
    
    static func createDiscoverModule() -> UIViewController {
        let view: UIViewController & DiscoverPresenterToView = DiscoverView()
        let presenter: DiscoverViewToPresenter & DiscoverInteractorToPresenter = DiscoverPresenter()
        let interactor: DiscoverPresenterToInteractor = DiscoverInteractor()
        let router: DiscoverPresenterToRouter = DiscoverRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    func navigateToMovie(from: DiscoverPresenterToView?, movie: MovieItem) {
        if let vc = from as? UIViewController {
            vc.navigationController?.pushViewController(MovieRouter.createMovieModule(movie: movie), animated: true)
        }
    }
}
