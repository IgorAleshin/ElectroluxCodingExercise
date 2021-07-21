//
//  ResponseDTO.swift
//  ElectroluxCodingExercise
//
//  Created by Алешин Игорь Эдуардович on 21.07.2021.
//

import Foundation

struct ResponseDTO: Decodable {
    var photos: PhotoResponseDTO

    enum CodingKeys: String, CodingKey {
        case photos
    }
}

struct PhotoResponseDTO: Decodable {
    let photo: [PhotoDTO]

    enum CodingKeys: String, CodingKey {
        case photo
    }
}
