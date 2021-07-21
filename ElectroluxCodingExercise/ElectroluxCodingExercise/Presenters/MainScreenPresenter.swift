//
//  MainScreenPresenter.swift
//  ElectroluxCodingExercise
//
//  Created by Алешин Игорь Эдуардович on 21.07.2021.
//

import Foundation

final class MainScreenPresenter: MainScreenOutput {

    // MARK: - Private properties

    private var models: [PhotoModel] = []
    private var lastLoadedPage = 1
    private var lastSearchedHashtag = "Electrolux"

    // MARK: - Initializable

    weak var input: MainScreenInput?
    let searchQuery: SearchQueryProtocol
    let router: MainScreenRouterProtocol

    // MARK: - Init

    init(input: MainScreenInput, searchQuery: SearchQueryProtocol, router: MainScreenRouterProtocol) {
        self.input = input
        self.searchQuery = searchQuery
        self.router = router
    }

    // MARK: - Life Cycle

    func viewLoaded() {

    }

    func viewAppeared() {
        performQuery(tag: lastSearchedHashtag, page: lastLoadedPage, delay: true)
    }

    func fetch(for hashtag: String) {
        lastSearchedHashtag = hashtag
        lastLoadedPage = 1
        input?.clear()
        performQuery(tag: hashtag, page: lastLoadedPage, delay: true)
    }

    func fetch(for page: Int) {
        guard page > lastLoadedPage else { return }
        lastLoadedPage = page
        performQuery(tag: lastSearchedHashtag, page: page, delay: false)
    }

    func clearResults() {
        models = []
        input?.clear()
    }

    // MARK: - Private methods

    private func performQuery(tag: String, page: Int, delay: Bool) {
        searchQuery.perform(hashtag: tag, page: page) { [weak self, input] result in
            if case .success(let photos) = result {
                self?.models.append(contentsOf: photos)
                let viewModels = photos.map { PhotoCellViewModel(with: $0) }
                input?.update(with: viewModels, withDelay: delay)
            }
        }
    }
}
