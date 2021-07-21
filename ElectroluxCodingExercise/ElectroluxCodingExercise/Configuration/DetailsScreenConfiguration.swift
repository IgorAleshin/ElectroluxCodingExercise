//
//  DetailsScreenConfiguration.swift
//  ElectroluxCodingExercise
//
//  Created by Алешин Игорь Эдуардович on 21.07.2021.
//

import UIKit

final class DetailsScreenConfiguration: ConfigurationProtocol {
    static func configurate(_ model: Model?) -> UIViewController {
        guard let model = model as? PhotoModel else {
            fatalError("Model should be passed")
        }
        let imageLoader = ImageLoader()
        let view = DetailScreenView(with: imageLoader)
        let presenter = DetailsScreenPresenter(input: view, model: model)
        view.output = presenter
        return view
    }
}
