// 
//  DiscoverInteractor.swift
//  klikfilm
//
//  Created by Rangga Leo on 06/01/21.
//

import Foundation

class DiscoverInteractor: DiscoverPresenterToInteractor {
    weak var presenter: DiscoverInteractorToPresenter?
    
    func getDiscover(page: Int?) {
        MovieWorker.shared.getDiscoverMovie(page: page) { (result) in
            switch result {
            case .failure(let err):
                self.presenter?.failGetDiscover(title: LTitleAlert.error.localized, message: err.localizedDescription)
            case .success(let res):
                self.presenter?.didGetDiscover(movie: res)
            }
        }
    }
        
}
