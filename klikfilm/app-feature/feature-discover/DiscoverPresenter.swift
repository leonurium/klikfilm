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
    var isMoreList: Bool = false
    
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
    
    func didSelectItemAt(indexPath: IndexPath) {
        self.router?.navigateToMovie(from: self.view, movie: movies[indexPath.item])
    }
    
    func requestGetMovies() {
        if page <= total_page && !isMoreList {
            view?.showLoaderIndicator()
            page += 1
            isMoreList = true
            interactor?.getDiscover(page: page)
        }
    }
}

extension DiscoverPresenter: DiscoverInteractorToPresenter {
    func didGetDiscover(movie: MoviesResponse) {
        
        let dataCount = movie.results.count
        let rowNow = self.movies.count - 1
        var indexPaths: [IndexPath] = []

        guard dataCount > 0 else { return }
        for row in 1...dataCount {
            indexPaths.append(IndexPath(row: rowNow + row, section: 0))
        }
        
        movies.append(contentsOf: movie.results)
        page = movie.page
        total_page = movie.total_pages
        isMoreList = false
        
        view?.updateViewCell(indexPaths: indexPaths)
        view?.dismissLoaderIndicator()
    }
    
    func failGetDiscover(title: String, message: String) {
        view?.dismissLoaderIndicator()
        view?.showAlert(title: title, message: message, okCompletion: nil)
        isMoreList = false
    }
}
