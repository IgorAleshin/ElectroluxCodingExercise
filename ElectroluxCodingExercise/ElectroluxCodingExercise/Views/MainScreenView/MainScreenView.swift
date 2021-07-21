//
//  MainScreenView.swift
//  ElectroluxCodingExercise
//
//  Created by Алешин Игорь Эдуардович on 21.07.2021.
//

import UIKit
import SnapKit

enum DisplayingMode {
    case normal
    case select
}

final class MainScreenView: UIViewController, MainScreenInput {

    private typealias CellProvider = UICollectionViewDiffableDataSourceReferenceCellProvider
    private typealias CollectionSnapshot = NSDiffableDataSourceSnapshot<Sections, PhotoCellViewModel>
    private typealias CollectionDataSource = UICollectionViewDiffableDataSource<Sections, PhotoCellViewModel>

    // MARK: - Nested Types

    private enum Constants {
        static let cellID = "photoCell"
        static let title = "Flickr Photos"
        static let selectString: String = "Select"
        static let doneString: String = "Done"
    }

    private enum Sections {
        case main
    }

    // MARK: - Public properties

    var output: MainScreenOutput?

    // MARK: - Private properties

    private lazy var activityIndicator = UIActivityIndicatorView(style: .large)
    private lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.barStyle = .default
        bar.searchTextField.text = "Electrolux"
        return bar
    }()

    private lazy var cellProvider: CellProvider = { [weak self] (collectionView, indexPath, item) in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellID, for: indexPath)
        guard let photoCell = cell as? PhotoCollectionCell,
              let viewModel = item as? PhotoCellViewModel,
              let displayingMode = self?.displayingMode else {
            fatalError("Wrong cell has been used")
        }
        photoCell.displayingMode = displayingMode
        photoCell.configure(with: viewModel)
        return photoCell
    }

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: TwoColumnLayout.layout)
    private lazy var dataSource = CollectionDataSource(collectionView: collectionView, cellProvider: cellProvider)
    private lazy var selectBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = Constants.selectString
        button.target = self
        button.action = #selector(selectButtonTapped(_:))
        return button
    }()

    private var viewModels: [PhotoCellViewModel] = []
    private var selectedIndecies: [Int] = [] {
        didSet {
            if selectedIndecies.count > 0 {
                let button = UIBarButtonItem()
                button.target = self
                button.action = #selector(saveButtonTapped(_:))
                button.title = "Save (\(selectedIndecies.count))"
                navigationItem.setLeftBarButton(button, animated: false)
            } else {
                navigationItem.setLeftBarButton(nil, animated: false)
            }
        }
    }

    private var displayingMode: DisplayingMode = .normal {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupSearchBar()
        setupCollectionView()
        setupActivityIndicator()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output?.viewAppeared()
    }

    // MARK: - Public methods

    func update(with viewModels: [PhotoCellViewModel], withDelay: Bool) {
        let delay: Double = withDelay ? 0.3 : 0
        //small delay to avoid blinking if server responded too fast
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [activityIndicator] in
            activityIndicator.stopAnimating()
            self.viewModels.append(contentsOf: viewModels)
            var snapshot = CollectionSnapshot()
            snapshot.appendSections([.main])
            snapshot.appendItems(self.viewModels)
            self.dataSource.apply(snapshot)
        }
    }

    func clear() {
        viewModels = []
        var snapshot = CollectionSnapshot()
        snapshot.deleteAllItems()
        self.dataSource.apply(snapshot)
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
            $0.top.equalTo(searchBar.snp.bottom)
            $0.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }

    private func setupSearchBar() {
        searchBar.delegate = self
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        activityIndicator.startAnimating()
    }

    private func setupNavigationBar() {
        title = Constants.title
        navigationItem.setRightBarButton(selectBarButton, animated: false)
    }

    // MARK: - Actions

    @objc private func selectButtonTapped(_ sender: UIBarButtonItem) {
        let newDisplayingMode: DisplayingMode = displayingMode == .normal ? .select : .normal
        sender.title = newDisplayingMode == .normal ? Constants.selectString : Constants.doneString
        let allowMultiplySelection = newDisplayingMode == .normal ? false : true
        collectionView.allowsMultipleSelection = allowMultiplySelection
        displayingMode = newDisplayingMode
        if newDisplayingMode == .normal {
            selectedIndecies = []
        }
    }

    @objc private func saveButtonTapped(_ sender: UIBarButtonItem) {

    }
}

extension MainScreenView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch displayingMode {
            case .normal:
                collectionView.deselectItem(at: indexPath, animated: true)
                output?.openDetails(for: indexPath.row)
            case .select:
                selectedIndecies.append(indexPath.row)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch displayingMode {
            case .select:
                guard let index = selectedIndecies.firstIndex(of: indexPath.row) else { return }
                selectedIndecies.remove(at: index)
            case .normal:
                break
        }
    }
}

extension MainScreenView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchBar.searchTextField.text == nil ? "" : searchBar.searchTextField.text!
        if text.isEmpty {
            output?.clearResults()
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.searchTextField.text,
              !searchText.isEmpty else {
            return
        }
        output?.clearResults()
        output?.fetch(for: searchText)
        activityIndicator.startAnimating()
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
}

extension MainScreenView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        let viewHeight = scrollView.bounds.height
        guard let page = ceil(contentOffsetY / viewHeight).toInt() else { return }
        output?.fetch(for: page)
    }
}

fileprivate extension CGFloat {
    func toInt() -> Int? {
        if self >= CGFloat(Int.min) && self < CGFloat(Int.max) {
            return Int(self)
        } else {
            return nil
        }
    }
}
