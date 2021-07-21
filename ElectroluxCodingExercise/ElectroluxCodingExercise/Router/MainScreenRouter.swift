//
//  MainScreenRouter.swift
//  ElectroluxCodingExercise
//
//  Created by Алешин Игорь Эдуардович on 21.07.2021.
//

import UIKit

final class MainScreenRouter: MainScreenRouterProtocol {

    weak var view: UIViewController?

    init(view: UIViewController) {
        self.view = view
    }

    func openDetails(with model: PhotoModel) {
        let destinationView = DetailsScreenConfiguration.configurate(model)
        view?.navigationController?.pushViewController(destinationView, animated: true)
    }
}
