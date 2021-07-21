//
//  ImageSavingService.swift
//  ElectroluxCodingExercise
//
//  Created by Алешин Игорь Эдуардович on 21.07.2021.
//

import UIKit

final class ImageSavingService: ImageSavingServiceProtocol {

    let imageLoader: ImageLoaderProtocol

    init(imageLoader: ImageLoaderProtocol) {
        self.imageLoader = imageLoader
    }

    func saveImages(for models: [PhotoModel]) {
        models
            .map { $0.url }
            .forEach { [imageLoader] url in
                imageLoader.loadImage(with: url) { result in
                    switch result {
                        case .success(let image):
                            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                        case .failure(_):
                            break
                    }
                }
            }

    }
}
