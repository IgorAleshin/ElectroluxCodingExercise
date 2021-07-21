//
//  DetailsScreenProtocol.swift
//  ElectroluxCodingExercise
//
//  Created by Алешин Игорь Эдуардович on 21.07.2021.
//

import Foundation

protocol DetailsScreenInput: AnyObject {
    func setModel(_ model: DetailsScreenViewModel)
}

protocol DetailsScreenOutput: AnyObject {
    func viewLoaded()
}
