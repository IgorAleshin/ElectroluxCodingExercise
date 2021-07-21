//
//  PhotoDTO.swift
//  ElectroluxCodingExercise
//
//  Created by Алешин Игорь Эдуардович on 21.07.2021.
//

import Foundation

struct PhotoDTO: Decodable {
    let id: String
    let secret: String
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case id
        case secret
        case title
        case url = "url_m"
    }
}
