import UIKit

final class BreedsSplitFactory {
    func make() -> UIViewController {
        let splitViewController = UISplitViewController()
        let breedsListController = BreedsListFactory().make()
        let navigationController = UINavigationController(rootViewController: breedsListController)

        splitViewController.viewControllers = [navigationController]
        splitViewController.preferredDisplayMode = .allVisible
        splitViewController.delegate = self

        return splitViewController
    }
}

extension BreedsSplitFactory: UISplitViewControllerDelegate {
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController
    ) -> Bool {

        return true
    }
}
