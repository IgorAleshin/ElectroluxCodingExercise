//
//  PhotoCollectionCell.swift
//  ElectroluxCodingExercise
//
//  Created by Алешин Игорь Эдуардович on 21.07.2021.
//

import UIKit

final class PhotoCollectionCell: UICollectionViewCell {

    // MARK: - Nested Types

    private enum Constants {
        static let checkmarkWidthHeight: CGFloat = 24
        static let checkmarkOffset: CGFloat = 8
    }

    // MARK: - Public properties

    var displayingMode: DisplayingMode = .normal

    override var isSelected: Bool {
        didSet {
            checkmarkView.isHidden = !isSelected
        }
    }

    // MARK: - Private properties

    private lazy var imageView = UIImageView()
    private lazy var loadingIndicator = UIActivityIndicatorView()

    private lazy var checkmarkView: UIImageView = {
        let image = UIImage(systemName: "checkmark.circle.fill")
        let imageView = UIImageView(image: image)
        imageView.backgroundColor = .white
        imageView.tintColor = .systemBlue
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    // MARK: - Initializable

    let imageLoader: ImageLoaderProtocol = ImageLoader()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        onInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func prepareForReuse() {
        super.prepareForReuse()
        loadingIndicator.startAnimating()
        imageView.image = nil
        imageLoader.cancel()
    }

    // MARK: - Public methods

    func configure(with viewModel: PhotoCellViewModel) {
        imageLoader.loadImage(with: viewModel.url) {[imageView, loadingIndicator] result in
            if case .success(let image) = result {
                DispatchQueue.main.async {
                    imageView.image = image
                    loadingIndicator.stopAnimating()
                }
            }
        }
    }

    // MARK: - Private methods
    
    private func onInit() {
        backgroundColor = .gray
        setupImageView()
        setupLoadingIndicator()
        setupCheckmarkView()
    }

    private func setupImageView() {
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func setupLoadingIndicator() {
        addSubview(loadingIndicator)
        loadingIndicator.style = .medium
        loadingIndicator.color = .black
        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        loadingIndicator.startAnimating()
    }

    private func setupCheckmarkView() {
        addSubview(checkmarkView)
        checkmarkView.layer.cornerRadius = Constants.checkmarkWidthHeight/2
        checkmarkView.snp.makeConstraints {
            $0.left.top.equalToSuperview().offset(Constants.checkmarkOffset)
            $0.width.height.equalTo(Constants.checkmarkWidthHeight)
        }
    }

}
