import UIKit

final class ErrorView: UIView {
    // MARK: - Properties
    private let tryAgainClosure: (() -> Void)?

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = Spacing.space01
        return stackView
    }()

    private let imageView: UIImageView = {
        let view = UIImageView(image: Assets.errorCat.image)
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let errorButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.rounded()
        button.setTitle(Strings.Error.tryAgain, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)
        return button
    }()

    // MARK: - Lyfe Cycle
    init(frame: CGRect = .zero, errorMessage: String, tryAgainClosure: (() -> Void)?) {
        self.tryAgainClosure = tryAgainClosure
        super.init(frame: frame)
        descriptionLabel.text = errorMessage
        buildLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ErrorView: ViewConfiguration {
    // MARK: - View Configuration
    func buildViewHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(errorButton)
    }

    func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        imageView.snp.contentCompressionResistanceVerticalPriority = 250
    }
}

private extension ErrorView {
    @objc func tryAgain() {
        tryAgainClosure?()
    }
}