import UIKit
import SnapKit

extension ErrorView.Layout {
    static let lowPriority: Float = 250.0
    static let numberOfLines = 0
}

final class ErrorView: UIView {
    fileprivate enum Layout { }

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
        label.font = UIFont.big()
        label.numberOfLines = Layout.numberOfLines
        label.textAlignment = .center
        return label
    }()

    private let errorButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.rounded()
        button.setTitle(Strings.Error.tryAgain, for: .normal)
        button.titleLabel?.font = UIFont.big(weight: .bold)
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
        imageView.snp.contentCompressionResistanceVerticalPriority = Layout.lowPriority

    }

    func configureViews() {
        accessibilityIdentifier = "ErrorView"
    }
}

// MARK: - Private functions
private extension ErrorView {
    @objc func tryAgain() {
        tryAgainClosure?()
    }
}
