//
//  DetailsScreenPresenter.swift
//  ElectroluxCodingExercise
//
//  Created by Алешин Игорь Эдуардович on 21.07.2021.
//

import Foundation

final class DetailsScreenPresenter: DetailsScreenOutput {

    // MARK: - Initializable

    private let model: PhotoModel
    weak private var input: DetailsScreenInput?

    // MARK: - Init

    init(input: DetailsScreenInput, model: PhotoModel) {
        self.input = input
        self.model = model
    }

    // MARK: - Life Cycle

    func viewLoaded() {
        let viewModel = DetailsScreenViewModel(with: model)
        input?.setModel(viewModel)
    }
}
