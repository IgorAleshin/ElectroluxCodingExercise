//
//  SearchQueryProtocol.swift
//  ElectroluxCodingExercise
//
//  Created by Алешин Игорь Эдуардович on 21.07.2021.
//

import Foundation

protocol SearchQueryProtocol {
    func perform(hashtag: String, page: Int, complition: @escaping ((Result<[PhotoModel], Error>) -> Void))
}
