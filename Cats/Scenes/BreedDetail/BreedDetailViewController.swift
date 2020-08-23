import UIKit
import SnapKit

protocol BreedDetailDisplay: AnyObject {
    func displayDetailsWith(name: String, description: String, attributesItems: [String])
}

private extension BreedDetailViewController.Layout {

    static let cellSize: CGFloat = 40.0
    static let minimunLineSpacing: CGFloat = 0.0
    static let numberOfLines = 0
}

final class BreedDetailViewController: ViewController<BreedDetailInteracting> {
    fileprivate enum Layout { }

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
        layout.itemSize = CGSize(width: view.bounds.width - 2*Spacing.space02, height: Layout.cellSize)

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(
            CustomCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: CustomCollectionViewCell.self)
        )
        view.allowsSelection = false
        view.bounces = false
        layout.minimumLineSpacing = Layout.minimunLineSpacing
        view.rounded()
        return view
    }()

    private lazy var containerDescriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.rounded()
        return view
    }()

    private lazy var descriptionLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.numberOfLines = Layout.numberOfLines
        view.backgroundColor = .lightGray
        return view
    }()

    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        interactor.showDetails()
    }

    override func buildViewHierarchy() {
        view.addSubview(containerDescriptionView)
        containerDescriptionView.addSubview(descriptionLabel)
        view.addSubview(collectionView)
        view.addSubview(imageView)
    }

    override func setupConstraints() {
        containerDescriptionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Spacing.space03)
            $0.leading.trailing.equalToSuperview().inset(Spacing.space02)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(Spacing.space01)
            $0.leading.trailing.equalToSuperview().inset(Spacing.space02)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(Spacing.space02)
            $0.leading.trailing.equalToSuperview().inset(Spacing.space02)
        }
        imageView.snp.makeConstraints {
            $0.bottom.top.equalToSuperview().inset(Spacing.space01)
            $0.leading.trailing.equalToSuperview().inset(Spacing.space02)
        }
    }

    func configureViews() {
        view.backgroundColor = .white
    }
}

extension BreedDetailViewController: BreedDetailDisplay {
    func displayDetailsWith(name: String, description: String, attributesItems: [String]) {
        title = name
        descriptionLabel.text = description

        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(attributesItems)
        dataSource.apply(snapshot, animatingDifferences: true)

        collectionView.snp.makeConstraints {
            $0.height.equalTo(Layout.cellSize * CGFloat(attributesItems.count))
        }
    }
}
