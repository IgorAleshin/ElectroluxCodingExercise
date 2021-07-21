//
//  TwoColumnLayout.swift
//  ElectroluxCodingExercise
//
//  Created by Алешин Игорь Эдуардович on 21.07.2021.
//

import UIKit

final class TwoColumnLayout {

    private enum Constants {
        static var itemWidth: NSCollectionLayoutDimension { .fractionalWidth(1) }
        static var itemHeight: NSCollectionLayoutDimension { .fractionalHeight(1) }

        static var itemsInGroup: Int { 2 }

        static var groupWidth: NSCollectionLayoutDimension { .fractionalWidth(1) }
        static var groupHeight: NSCollectionLayoutDimension { .fractionalHeight(0.2) }

        static var groupSpacing: NSCollectionLayoutSpacing { .fixed(8) }
        static var sectionSpacing: CGFloat { 8 }

        static var sectionInsets: NSDirectionalEdgeInsets { .init(top: 8, leading: 8, bottom: 8, trailing: 8) }
    }

    static var layout: UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: Constants.itemWidth,
            heightDimension: Constants.itemHeight
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: Constants.groupWidth,
            heightDimension: Constants.groupHeight
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: Constants.itemsInGroup

        )
        group.interItemSpacing = Constants.groupSpacing

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = Constants.sectionSpacing
        section.contentInsets = Constants.sectionInsets

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
