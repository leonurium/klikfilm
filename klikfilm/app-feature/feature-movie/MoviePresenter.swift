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
    
    init(movie: MovieItem) {
        self.movie = movie
    }
    
    func numberOfRowsInSection() -> Int {
        return 1
    }
    
    func cellForRowAt(indexPath: IndexPath) -> MovieItem {
        return movie
    }
}

extension MoviePresenter: MovieInteractorToPresenter {
    
}
