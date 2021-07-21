//
//  MainScreenConfiguration.swift
//  ElectroluxCodingExercise
//
//  Created by Алешин Игорь Эдуардович on 21.07.2021.
//

import UIKit

final class MainScreenConfiguration: ConfigurationProtocol {
    static func configurate(_ model: Model? = nil) -> UIViewController {
        let view = MainScreenView()
        let query = SearchQuery()
        let presenter = MainScreenPresenter(input: view, searchQuery: query)
        view.output = presenter
        return view
    }
}
