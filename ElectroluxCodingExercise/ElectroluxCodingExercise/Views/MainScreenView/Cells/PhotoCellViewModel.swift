//
//  PhotoCellViewModel.swift
//  ElectroluxCodingExercise
//
//  Created by Алешин Игорь Эдуардович on 21.07.2021.
//

import Foundation

struct PhotoCellViewModel: Hashable {
    let id: String
    let url: String

    init(with model: PhotoModel) {
        self.id = model.id
        self.url = model.url
    }

    func hash(into hasher: inout Hasher) {
        let randomSeed = UUID()
        hasher.combine(id + url + "\(randomSeed)")
    }
}
