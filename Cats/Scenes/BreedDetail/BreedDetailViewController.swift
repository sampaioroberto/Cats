import UIKit
import SnapKit
import Kingfisher

protocol BreedDetailDisplay: AnyObject {
    func displayDetailsWith(name: String, description: String, attributesItems: [String])
    func displayCatImageWithURL(_ url: URL)
    func displayCatImageError()
}

private extension BreedDetailViewController.Layout {

    static let cellSize: CGFloat = 40.0
    static let minimunLineSpacing: CGFloat = 0.0
    static let numberOfLines = 0
    static let imageMinHeight: CGFloat = 200.0
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

    private let scrollView = UIScrollView()
    private let containerView = UIView()
    
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

    private lazy var containerImageView = ImageViewDownloadContainerView()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        interactor.showDetails()
    }

    override func buildViewHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(containerDescriptionView)
        containerDescriptionView.addSubview(descriptionLabel)
        containerView.addSubview(collectionView)
        containerView.addSubview(containerImageView)
    }

    override func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        containerDescriptionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Spacing.space02)
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
        containerImageView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(Spacing.space01)
            $0.leading.trailing.equalToSuperview().inset(Spacing.space02)
            $0.bottom.equalToSuperview().offset(-Spacing.space01)
            $0.height.greaterThanOrEqualTo(Layout.imageMinHeight)
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

    func displayCatImageWithURL(_ url: URL) {
        containerImageView.displayImageWithURL(url) { [weak self] in
            self?.displayCatImageError()
        }
    }

    func displayCatImageError() {
        containerImageView.displayErrorView { [weak self] in
            self?.interactor.requestCatImage()
        }
    }
}
