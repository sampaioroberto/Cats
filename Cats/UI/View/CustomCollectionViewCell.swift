import UIKit
import SnapKit

final class CustomCollectionViewCell: UICollectionViewCell {
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()

    private let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium(weight: .bold)
        label.textColor = .systemGray6
        return label
    }()

    func configureWithText(_ text: String) {
        textLabel.text = text
        buildLayout()
    }
}

extension CustomCollectionViewCell: ViewConfiguration {
    func buildViewHierarchy() {
        contentView.addSubview(containerView)
        containerView.addSubview(textLabel)
    }

    func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Spacing.space01)
        }
        textLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func configureViews() {
        contentView.backgroundColor = .systemIndigo
    }
}

extension CustomCollectionViewCell {
    override func rounded() {
        contentView.rounded()
    }
}
