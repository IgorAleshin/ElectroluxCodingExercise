//
//  ImageLoader.swift
//  ElectroluxCodingExercise
//
//  Created by Алешин Игорь Эдуардович on 21.07.2021.
//

import UIKit

final class ImageLoader: ImageLoaderProtocol {

    typealias ImageComplition = ((Result<UIImage, Error>) -> Void)

    private let session = URLSession.shared
    private let cache = ImageCache.shared

    private var task: URLSessionTask?

    func loadImage(with urlString: String, complition: @escaping ImageComplition) {

        if let image = cache.getImage(for: urlString)  {
            complition(.success(image))
            return
        }

        task = createDataTask(urlString: urlString, complition: complition)

        DispatchQueue.global(qos: .default).async { [task] in
            task?.resume()
        }
    }

    func cancel() {
        task?.cancel()
    }

    private func createDataTask(urlString: String, complition: ImageComplition?) -> URLSessionTask? {
        guard let url = URL(string: urlString) else { return nil }
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { [cache] data, _, _ in
            guard let data = data,
                  let image = UIImage(data: data) else { return }
            cache.set(image: image, for: urlString)
            complition?(.success(image))
        }
        return task
    }
}
