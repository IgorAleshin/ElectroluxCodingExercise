//
//  MainScreenConfiguration.swift
//  ElectroluxCodingExercise
//
//  Created by Алешин Игорь Эдуардович on 21.07.2021.
//

import UIKit

final class MainScreenConfiguration: ConfigurationProtocol {
    static func configurate() -> UIViewController {
        let view = MainScreenView()
        let presenter = MainScreenPresenter(input: view)
        view.output = presenter
        return view
    }
}
