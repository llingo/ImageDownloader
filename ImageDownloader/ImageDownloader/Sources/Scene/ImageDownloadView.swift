//
//  ImageDownloadView.swift
//  ImageDownloader
//

import UIKit

final class ImageDownloadView: UIView {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "photo")
        imageView.layer.cornerRadius = 5

        return imageView
    }()

    private let progressView: UIProgressView = {
        let progressView = UIProgressView()

        return progressView
    }()

    private let progressLabel: UILabel = {
        let label = UILabel()
        label.text = "0 %"
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 11, weight: .regular)

        return label
    }()

    private let loadButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .tintColor
        configuration.title = "Load"

        let button = UIButton(configuration: configuration)

        return button
    }()

    private var observation: NSKeyValueObservation?

    var didTap: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setImage() {
        imageView.image = UIImage(systemName: "photo")
        progressView.progress = .zero
        progressLabel.text = "0 %"

        guard let url = URL(string: "https://picsum.photos/200") else {
            return
        }

        let task = ImageDownloader.shared.setImage(with: url) { [weak self] result in
            switch result {
            case let .success(data):
                self?.imageView.image = UIImage(data: data)

            case .failure(_):
                self?.imageView.image = UIImage(systemName: "exclamationmark.square.fill")
            }

            if let observation = self?.observation {
                self?.observation = nil
                observation.invalidate()
            }
        }

        observation = task.progress.observe(\.fractionCompleted) { [weak self] progress, value in
            DispatchQueue.main.async {
                let progressValue = Float(progress.fractionCompleted)
                let persent = String(format: "%.1f", progressValue / 1.0 * 100)
                self?.progressView.progress = progressValue
                self?.progressLabel.text = "\(persent) %"
            }
        }

        task.resume()
    }

    // MARK: - Private

    private func configureUI() {
        configureView()
        configureLoadButton()
    }

    private func configureView() {
        let contentView = UIStackView(
            axis: .horizontal,
            alignment: .center,
            spacing: 16,
            subviews: [
                imageView,
                UIStackView(axis: .vertical, spacing: 8, subviews: [
                    progressView,
                    progressLabel
                ]),
                loadButton
            ])

        addSubviews([contentView])
        loadButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        loadButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1.5),
            progressView.heightAnchor.constraint(equalToConstant: 8)
        ])
    }

    private func configureLoadButton() {
        loadButton.addTarget(self, action: #selector(didTapLoadButton), for: .touchUpInside)
    }

    @objc
    private func didTapLoadButton() {
        didTap?()
    }
}
