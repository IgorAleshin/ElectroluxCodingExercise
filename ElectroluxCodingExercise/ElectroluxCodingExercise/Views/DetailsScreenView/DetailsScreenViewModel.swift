//
//  DetailsScreenViewModel.swift
//  ElectroluxCodingExercise
//
//  Created by Алешин Игорь Эдуардович on 21.07.2021.
//

import Foundation

struct DetailsScreenViewModel {
    let title: String
    let url: String

    init(with model: PhotoModel) {
        title = model.title
        url = model.url
    }
}
