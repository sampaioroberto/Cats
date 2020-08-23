import UIKit

enum Section {
  case main
}

typealias DataSource = UICollectionViewDiffableDataSource<Section, String>
typealias Snapshot = NSDiffableDataSourceSnapshot<Section, String>
