//
//  ImageLoaderProtocol.swift
//  ElectroluxCodingExercise
//
//  Created by Алешин Игорь Эдуардович on 21.07.2021.
//

import UIKit

protocol ImageLoaderProtocol {
    func loadImage(with urlString: String, complition: @escaping ((Result<UIImage, Error>) -> Void))
    func cancel()
}
