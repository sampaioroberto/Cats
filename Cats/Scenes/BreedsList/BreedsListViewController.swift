import UIKit
import SnapKit

protocol BreedsListDisplay: AnyObject {
    func displayBreedsNames(_ names: [String])
    func displayLoading()
    func hideLoading()
    func displayErrorWithMessage(_ message: String)
}

final class BreedsListViewController: ViewController<BreedsListInteracting> {

    private enum Section {
      case main
    }
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, String>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, String>

    // MARK: - Properties
    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, text) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: CustomCollectionViewCell.self
                ),
                for: indexPath) as? CustomCollectionViewCell
              cell?.configureWithText(text)
            return cell
        })
        return dataSource
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = Spacing.space01
        layout.minimumInteritemSpacing = Spacing.space00

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(
            CustomCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: CustomCollectionViewCell.self)
        )
        view.backgroundColor = .white
        view.delegate = self
        return view
    }()

    private let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        view.color = .black
        return view
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.requestBreeds()
    }

    override func buildViewHierarchy() {
        view.addSubview(collectionView)
    }

    override func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func configureViews() {
        view.backgroundColor = .white
    }
}

extension BreedsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: Spacing.space02,
            left: Spacing.space01,
            bottom: Spacing.space02,
            right: Spacing.space02
        )
    }
}

extension BreedsListViewController: BreedsListDisplay {
    func displayBreedsNames(_ names: [String]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(names)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayLoading() {
        collectionView.backgroundView = activityIndicatorView
        activityIndicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    func hideLoading() {
        collectionView.backgroundView = nil
    }

    func displayErrorWithMessage(_ message: String) {
        let errorView = ErrorView(errorMessage: message)
        collectionView.backgroundView = errorView
        errorView.snp.makeConstraints {
            $0.height.equalTo(collectionView.snp.height).dividedBy(2)
            $0.width.equalTo(collectionView.snp.width).dividedBy(1.5)
            $0.center.equalToSuperview()
        }
    }
}

final class ErrorView: UIView {
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
        button.setTitle("Try again", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return button
    }()

    init(frame: CGRect = .zero, errorMessage: String) {
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
