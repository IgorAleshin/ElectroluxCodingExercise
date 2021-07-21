//
//  MainScreenProtocol.swift
//  ElectroluxCodingExercise
//
//  Created by Алешин Игорь Эдуардович on 21.07.2021.
//

import Foundation

protocol MainScreenInput: AnyObject {
    func clear()
    func update(with viewModels: [PhotoCellViewModel], withDelay: Bool)
}

protocol MainScreenOutput: AnyObject {
    func viewLoaded()
    func viewAppeared()
    func fetch(for hashtag: String)
    func fetch(for page: Int)
    func clearResults()
    func openDetails(for index: Int)
    func savePhotos(at indecies: [Int])
}
