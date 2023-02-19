//
//  ImageDownloadViewController.swift
//  ImageDownloader
//

import UIKit

class ImageDownloadViewController: UIViewController {

    private let imageDownloadView1 = ImageDownloadView()
    private let imageDownloadView2 = ImageDownloadView()
    private let imageDownloadView3 = ImageDownloadView()
    private let imageDownloadView4 = ImageDownloadView()
    private let imageDownloadView5 = ImageDownloadView()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Wanted iOS Challenge"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)

        return label
    }()

    private let loadAllButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Load All Images"
        let button = UIButton(configuration: configuration)

        return button
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Private

    private func configureUI() {
        configureView()
        configureLoadAllButton()
        bind()
    }

    private func configureView() {
        view.backgroundColor = .systemBackground

        let contentView = UIStackView(
            axis: .vertical,
            distribution: .equalSpacing,
            spacing: 16,
            subviews: [
                titleLabel,
                imageDownloadView1,
                imageDownloadView2,
                imageDownloadView3,
                imageDownloadView4,
                imageDownloadView5,
                loadAllButton
            ]
        )

        view.addSubviews([contentView])
        let safeAreaGuide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 16),
            contentView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16),
            loadAllButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func configureLoadAllButton() {
        loadAllButton.addTarget(self, action: #selector(didTapLoadAllButton), for: .touchUpInside)
    }

    @objc
    private func didTapLoadAllButton(_ sender: UIButton) {
        [
            imageDownloadView1,
            imageDownloadView2,
            imageDownloadView3,
            imageDownloadView4,
            imageDownloadView5
        ]
        .forEach { $0.setImage() }
    }

    private func bind() {
        imageDownloadView1.didTap = { [weak self] in
            self?.imageDownloadView1.setImage()
        }

        imageDownloadView2.didTap = { [weak self] in
            self?.imageDownloadView2.setImage()
        }

        imageDownloadView3.didTap = { [weak self] in
            self?.imageDownloadView3.setImage()
        }

        imageDownloadView4.didTap = { [weak self] in
            self?.imageDownloadView4.setImage()
        }

        imageDownloadView5.didTap = { [weak self] in
            self?.imageDownloadView5.setImage()
        }
    }
}
