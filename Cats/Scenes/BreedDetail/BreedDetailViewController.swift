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
    enum Section {
      case main
    }

    typealias DataSource = UITableViewDiffableDataSource<Section, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, String>

    // MARK: - Properties
    fileprivate enum Layout { }

    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(tableView: tableView, cellProvider: { tableview, _, text in
            let identifier = "Cell"
            var cell: UITableViewCell?
            cell = tableview.dequeueReusableCell(withIdentifier: identifier)
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
            }
            cell?.textLabel?.text = text
            cell?.textLabel?.font = UIFont.medium(weight: .bold)
            cell?.textLabel?.textColor = .systemGray6
            cell?.backgroundColor = .systemIndigo
            return cell
        })
        return dataSource
    }()

    private let scrollView = UIScrollView()

    private let containerView = UIView()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.allowsSelection = false
        view.bounces = false
        view.rounded()
        view.backgroundColor = .systemIndigo
        view.separatorStyle = .none
        view.rowHeight = Layout.cellSize
        return view
    }()

    private lazy var containerDescriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemIndigo
        view.rounded()
        return view
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.medium()
        label.textColor = .systemGray6
        label.numberOfLines = Layout.numberOfLines
        label.backgroundColor = .systemIndigo
        return label
    }()

    private lazy var containerImageView = ImageViewDownloadContainerView()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        interactor.showDetails()
    }

    // MARK: - View Configuration
    override func buildViewHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(containerDescriptionView)
        containerDescriptionView.addSubview(descriptionLabel)
        containerView.addSubview(tableView)
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
        tableView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(Spacing.space02)
            $0.leading.trailing.equalToSuperview().inset(Spacing.space02)
        }
        containerImageView.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom).offset(Spacing.space01)
            $0.leading.trailing.equalToSuperview().inset(Spacing.space02)
            $0.bottom.equalToSuperview().offset(-Spacing.space01)
            $0.height.greaterThanOrEqualTo(Layout.imageMinHeight)
        }
    }

    override func configureViews() {
        view.backgroundColor = .systemGray6
    }
}

// MARK: - Display
extension BreedDetailViewController: BreedDetailDisplay {
    func displayDetailsWith(name: String, description: String, attributesItems: [String]) {
        title = name
        descriptionLabel.text = description

        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(attributesItems)
        dataSource.apply(snapshot, animatingDifferences: false)

        tableView.snp.makeConstraints {
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
