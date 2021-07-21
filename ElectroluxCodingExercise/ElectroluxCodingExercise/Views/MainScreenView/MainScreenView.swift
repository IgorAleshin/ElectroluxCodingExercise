//
//  MainScreenView.swift
//  ElectroluxCodingExercise
//
//  Created by Алешин Игорь Эдуардович on 21.07.2021.
//

import UIKit
import SnapKit

final class MainScreenView: UIViewController, MainScreenInput {

    private typealias CellProvider = UICollectionViewDiffableDataSourceReferenceCellProvider
    private typealias CollectionSnapshot = NSDiffableDataSourceSnapshot<Sections, PhotoCellViewModel>
    private typealias CollectionDataSource = UICollectionViewDiffableDataSource<Sections, PhotoCellViewModel>

    // MARK: - Nested Types

    private enum Constants {
        static let cellID = "photoCell"
        static let title = "Flickr Photos"
    }

    private enum Sections {
        case main
    }

    // MARK: - Public properties

    var output: MainScreenOutput?

    // MARK: - Private properties

    private lazy var activityIndicator = UIActivityIndicatorView(style: .large)

    private lazy var cellProvider: CellProvider = { [weak self] collectionView, indexPath, item in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellID, for: indexPath)

        return cell
    }

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: TwoColumnLayout.layout)
    private lazy var dataSource = CollectionDataSource(collectionView: collectionView, cellProvider: cellProvider)

    // MARK: - Initializable

    // MARK: - Init

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        setupActivityIndicator()

        title = Constants.title
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - Public methods

    // MARK: - Private methods

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        collectionView.allowsSelection = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(
            PhotoCollectionCell.self,
            forCellWithReuseIdentifier: Constants.cellID
        )

        view.addSubview(collectionView)
        collectionView.backgroundColor = .lightGray
        collectionView.snp.makeConstraints {
            $0.left.right.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }

    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        activityIndicator.startAnimating()
    }

    // MARK: - Actions
}

extension MainScreenView: UICollectionViewDelegate {

}
