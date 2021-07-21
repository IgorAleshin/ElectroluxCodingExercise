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

    // MARK: - Initializable

    weak var input: MainScreenInput?

    // MARK: - Init

    init(input: MainScreenInput) {
        self.input = input
    }

    // MARK: - Life Cycle

    // MARK: - Public methods

    func viewLoaded() {

    }

    func viewAppeared() {

    }

    // MARK: - Private methods

    // MARK: - Actions


}
