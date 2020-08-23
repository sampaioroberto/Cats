import UIKit

class ViewController<Interactor>: UIViewController, ViewConfiguration {
    let interactor: Interactor
    
    init(interactor: Interactor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        buildLayout()
    }
    
    func buildViewHierarchy() { }
    
    func setupConstraints() { }

    func configureViews() { }
}
