//
//  MoviePresenter.swift
//  klikfilm
//
//  Created by Rangga Leo on 06/01/21.
//

import Foundation

class MoviePresenter: MovieViewToPresenter {
    weak var view: MoviePresenterToView?
    var interactor: MoviePresenterToInteractor?
    var router: MoviePresenterToRouter?
    
    var movie: MovieItem
    var videos: [VideoItem] = []
    var reviews: [ReviewItem] = []
    
    init(movie: MovieItem) {
        self.movie = movie
    }
    
    func didLoad() {
        view?.setupViews()
        view?.showLoaderIndicator()
        interactor?.getVideos(movieID: movie.id)
        interactor?.getReview(movieID: movie.id)
    }
    
    func numberOfRowsInSection() -> Int {
        return 5
    }
    
    func cellForMovieInfo(indexPath: IndexPath) -> MovieItem {
        movie
    }
    
    func cellForMovieTrailer() -> [VideoItem] {
        videos
    }
    
    func cellForMovieReview() -> [ReviewItem] {
        reviews
    }
}

extension MoviePresenter: MovieInteractorToPresenter {
    func didGetVideos(videos: [VideoItem]) {
        self.videos = videos
        view?.reloadTableView()
        view?.dismissLoaderIndicator()
    }
    
    func failGetVideos(title: String, message: String) {
        view?.dismissLoaderIndicator()
        view?.showAlert(title: title, message: message, okCompletion: nil)
    }
    
    func didGetReviews(reviews: [ReviewItem]) {
        self.reviews = reviews
        view?.reloadTableView()
        view?.dismissLoaderIndicator()
    }
    
    func failGetReviews(title: String, message: String) {
        view?.dismissLoaderIndicator()
        view?.showAlert(title: title, message: message, okCompletion: nil)
    }
}
