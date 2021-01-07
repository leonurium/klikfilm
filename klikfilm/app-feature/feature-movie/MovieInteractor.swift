// 
//  MovieInteractor.swift
//  klikfilm
//
//  Created by Rangga Leo on 06/01/21.
//

import Foundation

class MovieInteractor: MoviePresenterToInteractor {
    weak var presenter: MovieInteractorToPresenter?
    
    func getVideos(movieID: Int) {
        MovieWorker.shared.getVideos(movie_id: movieID) { (result) in
            switch result {
            case .failure(let err):
                self.presenter?.failGetVideos(title: LTitleAlert.error.rawValue, message: err.localizedDescription)
            case .success(let res):
                self.presenter?.didGetVideos(videos: res.results)
            }
        }
    }
}
