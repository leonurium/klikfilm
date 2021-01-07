//
//  DiscoverTests.swift
//  klikfilm
//
//  Created by Rangga Leo on 07/01/21.
//

import Nimble
import Quick
@testable import klikfilm

class DiscoverTests: QuickSpec {
    override func spec() {
        class DiscoverViewMock: DiscoverPresenterToView {
            var presenter: DiscoverViewToPresenter?
            
            var isSetupViews: Bool = false
            var isShowAlert: Bool = false
            var isShowlAlertConfirm: Bool = false
            var iSshowLoaderIndicator: Bool = false
            var isDismissLoaderIndicator: Bool = false
            var isReloadCollectionView: Bool = false
            var isUpdateViewCell: Bool = false
            
            func setupViews() {
                isSetupViews = true
            }
            
            func showAlert(title: String, message: String, okCompletion: (() -> Void)?) {
                isShowAlert = true
            }
            
            func showlAlertConfirm(title: String, message: String, okCompletion: (() -> Void)?, cancelCompletion: (() -> Void)?) {
                isShowlAlertConfirm = true
            }
            
            func showLoaderIndicator() {
                iSshowLoaderIndicator = true
            }
            
            func dismissLoaderIndicator() {
                isDismissLoaderIndicator = true
            }
            
            func reloadCollectionView() {
                isReloadCollectionView = true
            }
            
            func updateViewCell(indexPaths: [IndexPath]) {
                isUpdateViewCell = true
            }
        }
        
        class DiscoverInteractorWork: DiscoverPresenterToInteractor {
            var presenter: DiscoverInteractorToPresenter?
            
            var isGetDiscover: Bool = false
            
            func getDiscover(page: Int?) {
                isGetDiscover = true
            }
        }
        
        class DiscoverRouterMock: DiscoverPresenterToRouter {
            static var isCreateDiscoverModule: Bool = false
            var isNavigateToMovie: Bool = false
            
            static func createDiscoverModule() -> UIViewController {
                DiscoverRouterMock.isCreateDiscoverModule = true
                return UIViewController()
            }
            
            func navigateToMovie(from: DiscoverPresenterToView?, movie: MovieItem) {
                isNavigateToMovie = true
            }
        }
        
        class DiscoverPresenterMock: DiscoverViewToPresenter, DiscoverInteractorToPresenter {
            var view: DiscoverPresenterToView?
            var interactor: DiscoverPresenterToInteractor?
            var router: DiscoverPresenterToRouter?
            
            var isDidLoad: Bool = false
            var isNumberOfItemsInSection: Bool = false
            var isCellForItemAt: Bool = false
            var isDidSelectItemAt: Bool = false
            var isRequestGetMovies: Bool = false
            var isDidGetDiscover: Bool = false
            var isFailGetDiscover: Bool = false
            
            func didLoad() {
                isDidLoad = true
            }
            
            func numberOfItemsInSection() -> Int {
                isNumberOfItemsInSection = true
                return 1
            }
            
            func cellForItemAt(indexPath: IndexPath) -> MovieItem {
                isCellForItemAt = true
                return MovieItem(popularity: 0, vote_count: 0, video: true, poster_path: "", backdrop_path: "", id: 0, adult: true, original_language: "", original_title: "", genre_ids: [], title: "", vote_average: 0, overview: "", release_date: "")
            }
            
            func didSelectItemAt(indexPath: IndexPath) {
                isDidSelectItemAt = true
            }
            
            func requestGetMovies() {
                isRequestGetMovies = true
            }
            
            func didGetDiscover(movie: MoviesResponse) {
                isDidGetDiscover = true
            }
            
            func failGetDiscover(title: String, message: String) {
                isFailGetDiscover = true
            }
        }
        
        describe("DiscoverPresenter") {
            var sut: DiscoverPresenter!
            var viewMock: DiscoverViewMock!
            var routerMock: DiscoverRouterMock!
            var interactorMock: DiscoverInteractorWork!
            
            beforeEach {
                sut = DiscoverPresenter()
                viewMock = DiscoverViewMock()
                routerMock = DiscoverRouterMock()
                interactorMock = DiscoverInteractorWork()
                
                sut.view = viewMock
                sut.router = routerMock
                sut.interactor = interactorMock
            }
            
            context("didLoad") {
                it("when didLoad is called, all the functions is called in didLoad must be called successfully") {
                    sut.didLoad()
                    expect(viewMock.isSetupViews).to(beTrue())
                    expect(interactorMock.isGetDiscover).to(beTrue())
                }
            }
            
            context("didSelectItemAt") {
                it("when didSelectItemAt is called, all the functions is called in didSelectItemAt must be called successfully") {
                    let movie = MovieItem(popularity: 0, vote_count: 0, video: true, poster_path: "", backdrop_path: "", id: 0, adult: true, original_language: "", original_title: "", genre_ids: [], title: "", vote_average: 0, overview: "", release_date: "")
                    let indexPath = IndexPath(item: 0, section: 0)
                    sut.movies.append(movie)
                    sut.didSelectItemAt(indexPath: indexPath)
                    expect(routerMock.isNavigateToMovie).to(beTrue())
                }
            }
            
            context("requestGetMovies") {
                it("when requestGetMovies is called, all the functions is called in requestGetMovies must be called successfully") {
                    sut.page = 1
                    sut.total_page = 2
                    sut.isMoreList = false
                    sut.requestGetMovies()
                    expect(interactorMock.isGetDiscover).to(beTrue())
                }
            }
            
            context("didGetDiscover") {
                it("when didGetDiscover is called, all the functions is called in didGetDiscover must be called successfully") {
                    let movie = MovieItem(popularity: 0, vote_count: 0, video: true, poster_path: "", backdrop_path: "", id: 0, adult: true, original_language: "", original_title: "", genre_ids: [], title: "", vote_average: 0, overview: "", release_date: "")
                    let response = MoviesResponse(page: 1, total_results: 1, total_pages: 1, results: [movie])
                    sut.didGetDiscover(movie: response)
                    expect(viewMock.isUpdateViewCell).to(beTrue())
                    expect(viewMock.isDismissLoaderIndicator).to(beTrue())
                }
            }
            
            context("failGetDiscover") {
                it("when failGetDiscover is called, all the functions is called in failGetDiscover must be called successfully") {
                    sut.failGetDiscover(title: "", message: "")
                    expect(viewMock.isDismissLoaderIndicator).to(beTrue())
                    expect(viewMock.isShowAlert).to(beTrue())
                }
            }
        }
    }
}
