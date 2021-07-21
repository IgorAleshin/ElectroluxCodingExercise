//
//  PhotoModel.swift
//  ElectroluxCodingExercise
//
//  Created by Алешин Игорь Эдуардович on 21.07.2021.
//

import Foundation

protocol Model { }

struct PhotoModel: Model {
    let id: String
    let secret: String
    let title: String
    let url: String

    init(with dto: PhotoDTO) {
        id = dto.id
        secret = dto.secret
        title = dto.title
        url = dto.url
    }
}
