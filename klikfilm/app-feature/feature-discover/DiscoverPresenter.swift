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
  
}

extension DiscoverPresenter: DiscoverInteractorToPresenter {
    
}
