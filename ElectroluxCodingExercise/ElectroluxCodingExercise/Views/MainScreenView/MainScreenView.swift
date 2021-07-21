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

    private lazy var cellProvider: CellProvider = { [weak self] (collectionView, indexPath, item) in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellID, for: indexPath)
        guard let photoCell = cell as? PhotoCollectionCell,
              let viewModel = item as? PhotoCellViewModel else {
            fatalError("Wrong cell has been used")
        }
        photoCell.configure(with: viewModel)
        return photoCell
    }

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: TwoColumnLayout.layout)
    private lazy var dataSource = CollectionDataSource(collectionView: collectionView, cellProvider: cellProvider)

    private var viewModels: [PhotoCellViewModel] = [] {
        didSet {
            if viewModels.count != 0 {
                activityIndicator.stopAnimating()
            }
        }
    }

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
        output?.viewAppeared()
    }

    // MARK: - Public methods

    func update(with viewModels: [PhotoCellViewModel]) {
        DispatchQueue.main.async {
            self.viewModels.append(contentsOf: viewModels)
            var snapshot = CollectionSnapshot()
            snapshot.appendSections([.main])
            snapshot.appendItems(self.viewModels)
            self.dataSource.apply(snapshot)
        }
    }

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
