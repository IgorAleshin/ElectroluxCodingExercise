//
//  MainScreenPresenter.swift
//  ElectroluxCodingExercise
//
//  Created by Алешин Игорь Эдуардович on 21.07.2021.
//

import Foundation

final class MainScreenPresenter: MainScreenOutput {

    // MARK: - Nested Types

    // MARK: - Public properties

    // MARK: - Private properties

    private var models: [PhotoModel] = []
    private var lastLoadedPage = 1

    // MARK: - Initializable

    weak var input: MainScreenInput?
    let searchQuery: SearchQueryProtocol

    // MARK: - Init

    init(input: MainScreenInput, searchQuery: SearchQueryProtocol) {
        self.input = input
        self.searchQuery = searchQuery
    }

    // MARK: - Life Cycle

    // MARK: - Public methods

    func viewLoaded() {

    }

    func viewAppeared() {
        searchQuery.perform(hashtag: "Electrolux", page: 1) { [weak self, input] result in
            if case .success(let photos) = result {
                self?.models.append(contentsOf: photos)
                let viewModels = photos.map { PhotoCellViewModel(with: $0) }
                input?.update(with: viewModels)
            }
        }
    }

    func fetchMore(for page: Int) {
        guard page > lastLoadedPage else { return }
        lastLoadedPage = page
        searchQuery.perform(hashtag: "Electrolux", page: lastLoadedPage) { [weak self, input] result in
            if case .success(let photos) = result {
                self?.models.append(contentsOf: photos)
                let viewModels = photos.map { PhotoCellViewModel(with: $0) }
                input?.update(with: viewModels)
            }
        }
    }

    // MARK: - Private methods

    // MARK: - Actions


}
