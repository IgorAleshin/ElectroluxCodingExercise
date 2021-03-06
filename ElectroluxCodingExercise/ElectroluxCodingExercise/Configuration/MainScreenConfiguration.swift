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
        let router = MainScreenRouter(view: view)
        let imageLoader = ImageLoader()
        let imageSavingService = ImageSavingService(imageLoader: imageLoader)
        let presenter = MainScreenPresenter(
            input: view,
            searchQuery: query,
            router: router,
            imageSavingService: imageSavingService
        )
        view.output = presenter
        return view
    }
}
