//
//  DiscoverPresenter.swift
//  klikfilm
//
//  Created by Rangga Leo on 06/01/21.
//

import Foundation

class DiscoverPresenter: DiscoverViewToPresenter {
    weak var view: DiscoverPresenterToView?
    var interactor: DiscoverPresenterToInteractor?
    var router: DiscoverPresenterToRouter?
    
    var movies: [MovieItem] = []
    var page: Int = 1
    var total_page: Int = 100
    
    func didLoad() {
        view?.setupViews()
        interactor?.getDiscover(page: page)
    }
    
    func numberOfItemsInSection() -> Int {
        return movies.count
    }
    
    func cellForItemAt(indexPath: IndexPath) -> MovieItem {
        return movies[indexPath.row]
    }
}

extension DiscoverPresenter: DiscoverInteractorToPresenter {
    func didGetDiscover(movie: MoviesResponse) {
        movies = movie.results
        page = movie.page
        total_page = movie.total_pages
        view?.reloadCollectionView()
    }
    
    func failGetDiscover(title: String, message: String) {
        view?.showAlert(title: title, message: message, okCompletion: nil)
    }
}
