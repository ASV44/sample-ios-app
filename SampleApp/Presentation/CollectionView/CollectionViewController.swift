import UIKit

final class CollectionViewController: UIViewController {
    @IBOutlet private var collectionView: UICollectionView!
    var interactor: CollectionViewOutput!

    static var identifier: String {
        return String(describing: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNibs()
        interactor.viewDidLoad()
    }
    
    private func registerNibs() {
        collectionView.register(LaunchCell.nib, forCellWithReuseIdentifier: LaunchCell.identifier)
    }
}

extension CollectionViewController: CollectionViewInput {
    func reloadData() {
        collectionView.reloadData()
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor.launchesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellModel = interactor.cellModel(at: indexPath) else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchCell.identifier, for: indexPath)
        (cell as? LaunchCell)?.configure(with: cellModel)
        
        return cell
    }
}
