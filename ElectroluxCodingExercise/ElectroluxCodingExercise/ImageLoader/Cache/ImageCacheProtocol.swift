//
//  ImageCacheProtocol.swift
//  ElectroluxCodingExercise
//
//  Created by Алешин Игорь Эдуардович on 21.07.2021.
//

import UIKit

protocol ImageCacheProtocol {
    func set(image: UIImage, for key: String)
    func getImage(for key: String) -> UIImage?
}
