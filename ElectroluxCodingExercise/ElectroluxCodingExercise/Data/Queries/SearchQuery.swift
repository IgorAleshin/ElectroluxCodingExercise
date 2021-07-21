//
//  SearchQuery.swift
//  ElectroluxCodingExercise
//
//  Created by Алешин Игорь Эдуардович on 21.07.2021.
//

import Foundation

final class SearchQuery: SearchQueryProtocol {
    private let session = URLSession.shared

    private var urlComponets: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.flickr.com"
        components.path = "/services/rest"
        let queryItems: [URLQueryItem] = [
            .init(name: "api_key", value: "28af98a502d8a1257691f62d665b5bb5"),
            .init(name: "method", value: "flickr.photos.search"),
            .init(name: "format", value: "json"),
            .init(name: "nojsoncallback", value: "true"),
            .init(name: "extras", value: "media"),
            .init(name: "extras", value: "url_m"),
            .init(name: "per_page", value: "20")
        ]
        components.queryItems = queryItems
        return components
    }

    func perform(hashtag: String, page: Int, complition: @escaping ((Result<[PhotoModel], Error>) -> Void)) {
        let queryItems: [URLQueryItem] = [
            .init(name: "tags", value: hashtag),
            .init(name: "page", value: "\(page)")
        ]

        var queryPath = urlComponets
        queryPath.queryItems?.append(contentsOf: queryItems)

        guard let url = queryPath.url else { return }
        let request = URLRequest(url: url)
        DispatchQueue.global(qos: .default).async { [session] in
            let task = session.dataTask(with: request) { data, _, _ in

                guard let data = data,
                      let response = try? JSONDecoder().decode(ResponseDTO.self, from: data) as ResponseDTO else {
                    return
                }
                let photos = response.photos.photo.map { PhotoModel(with: $0) }
                complition(.success(photos))
            }
            task.resume()
        }
    }
}
