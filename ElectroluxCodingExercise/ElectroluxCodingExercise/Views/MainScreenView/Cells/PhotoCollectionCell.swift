//
//  PhotoCollectionCell.swift
//  ElectroluxCodingExercise
//
//  Created by Алешин Игорь Эдуардович on 21.07.2021.
//

import UIKit

final class PhotoCollectionCell: UICollectionViewCell {

    // MARK: - Private properties

    private lazy var imageView = UIImageView()
    private lazy var loadingIndicator = UIActivityIndicatorView()

    // MARK: - Initializable

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func prepareForReuse() {
        super.prepareForReuse()
        loadingIndicator.startAnimating()
        imageView.image = nil
    }

    // MARK: - Private methods

    private func onInit() {
        backgroundColor = .gray
        addSubview(imageView)
        addSubview(loadingIndicator)
        loadingIndicator.style = .medium
        loadingIndicator.color = .black
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        loadingIndicator.startAnimating()
    }

    // MARK: - Actions

}
