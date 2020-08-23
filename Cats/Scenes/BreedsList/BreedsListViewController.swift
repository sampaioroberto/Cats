import UIKit
import SnapKit

protocol BreedsListDisplay: AnyObject {
    func displayBreedsNames(_ names: [String])
    func displayLoading()
    func hideLoading()
    func displayErrorWithMessage(_ message: String)
}

final class BreedsListViewController: ViewController<BreedsListInteracting> {
    enum Section {
      case main
    }

    typealias DataSource = UICollectionViewDiffableDataSource<Section, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, String>

    // MARK: - Properties
    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, text) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: CustomCollectionViewCell.self
                ),
                for: indexPath) as? CustomCollectionViewCell
            cell?.rounded()
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
        view.backgroundColor = .systemGray6
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
        title = Strings.breeds
        interactor.requestBreeds()
    }

    // MARK: - View Configuration
    override func buildViewHierarchy() {
        view.addSubview(collectionView)
    }

    override func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func configureViews() {
        view.backgroundColor = .systemGray6
    }
}

// MARK: - Flow Layout
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

// MARK: - UICollectionViewDelegate
extension BreedsListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor.goToBreedDetailsWithItemIndex(item: indexPath.item)
    }
}

// MARK: - Display
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
        let errorView = ErrorView(errorMessage: message) { [weak self] in
            self?.interactor.requestBreeds()
        }
        collectionView.backgroundView = errorView
        errorView.snp.makeConstraints {
            $0.height.equalTo(collectionView.snp.height).dividedBy(2)
            $0.width.equalTo(collectionView.snp.width).dividedBy(1.5)
            $0.center.equalToSuperview()
        }
    }
}
