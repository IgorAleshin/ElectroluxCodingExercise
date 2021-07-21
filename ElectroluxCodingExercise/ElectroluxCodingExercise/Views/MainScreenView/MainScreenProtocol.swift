//
//  MainScreenProtocol.swift
//  ElectroluxCodingExercise
//
//  Created by Алешин Игорь Эдуардович on 21.07.2021.
//

import Foundation

protocol MainScreenInput: AnyObject {

}

protocol MainScreenOutput: AnyObject {
    func viewLoaded()
    func viewAppeared()
}
