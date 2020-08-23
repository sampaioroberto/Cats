import Kingfisher
import UIKit
import SnapKit

extension ImageViewDownloadContainerView.Layout {
    static let transitionTime: TimeInterval = 1.0
}

final class ImageViewDownloadContainerView: UIView {
    // MARK: - Properties
    fileprivate enum Layout { }

    private let activityIndicatorView = UIActivityIndicatorView()

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    private var errorView: ErrorView?

    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        startLoading()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public functions
    func displayImageWithURL(_ url: URL, errorCompletion: @escaping (() -> Void)) {
        configureImageView()

        let processor = DownsamplingImageProcessor(size: self.frame.size)
            |> RoundCornerImageProcessor(cornerRadius: Spacing.space02)
        self.imageView.kf.indicatorType = .activity
        self.imageView.kf.setImage(
            with: url,
            placeholder: nil,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(Layout.transitionTime)),
                .cacheOriginalImage
        ]) { result in
            guard case .failure = result else {
                return
            }
            errorCompletion()
        }
    }

    func displayErrorView(tryAgainCompletion: @escaping (() -> Void)) {
        errorView = ErrorView(errorMessage: Strings.Error.getImageError) { [weak self] in
            self?.startLoading()
            tryAgainCompletion()
        }
        imageView.removeFromSuperview()
        activityIndicatorView.removeFromSuperview()

        guard let errorView = errorView else {
            return
        }

        addSubview(errorView)
        errorView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - Private functions
private extension ImageViewDownloadContainerView {
    func configureImageView() {
        errorView?.removeFromSuperview()
        activityIndicatorView.removeFromSuperview()

        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func startLoading() {
        imageView.removeFromSuperview()
        errorView?.removeFromSuperview()

        addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
