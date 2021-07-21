//
//  DetailsScreenView.swift
//  ElectroluxCodingExercise
//
//  Created by Алешин Игорь Эдуардович on 21.07.2021.
//

import UIKit
import SnapKit

final class DetailScreenView: UIViewController, DetailsScreenInput {

    // MARK: - Nested Types

    private enum Constants {
        static let stackViewSpace: CGFloat = 8
        static let offset: CGFloat = 9
    }

    // MARK: - Public properties

    var output: DetailsScreenOutput?

    // MARK: - Private properties

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpace
        return stackView
    }()

    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    // MARK: - Initializable

    private let imageLoader: ImageLoaderProtocol

    // MARK: - Init

    init(with imageLoader: ImageLoaderProtocol) {
        self.imageLoader = imageLoader
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        output?.viewLoaded()
    }

    // MARK: - Public methods

    func setModel(_ model: DetailsScreenViewModel) {
        label.text = model.title
        imageLoader.loadImage(with: model.url) { [imageView] result in
            if case .success(let image) = result {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }
    }

    // MARK: - Private methods

    private func setupView() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)

        stackView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.left.right.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
