import UIKit
import SnapKit

protocol BreedsListDisplay: AnyObject {
    func displayBreedsNames(_ names: [String])
    func displayLoading()
    func hideLoading()
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
}
