import UIKit

final class CollectionViewController: UIViewController {
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var loadingIndicator: UIActivityIndicatorView!

    var interactor: CollectionViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNibs()
        setupCollectionFlowLayout()
        interactor.viewDidLoad()
    }
    
    private var sectionInset: UIEdgeInsets {
        let phoneInset = UIEdgeInsets(vertical: 4, horizontal: 16)
        let padInset = UIEdgeInsets(vertical: 8, horizontal: 20)

        return Window.isPhone ? phoneInset : padInset
    }
    
    private func setupCollectionFlowLayout() {
        let layoutSpec = CollectionFlowLayout.LayoutSpec(
            interitemSpacing: Window.isPhone ? 9 : 12,
            sectionInset: sectionInset,
            padItemCount: 4,
            phoneItemCount: 2
        )
        let layout = CollectionFlowLayout(layoutSpec: layoutSpec)
        collectionView.collectionViewLayout = layout
    }
    
    private func registerNibs() {
        collectionView.register(LaunchCell.nib, forCellWithReuseIdentifier: LaunchCell.identifier)
    }
}

extension CollectionViewController: CollectionViewInput {
    func showLoadingIndecator() {
        loadingIndicator.isHidden = false
    }
    
    func hideLoadingIndecator() {
        loadingIndicator.isHidden = true
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func presentLaunchDetailsScreen(launch: Launch) {
        let launchDetailsVC = instantiateViewController(
            storyboardName: "LaunchDetails",
            identifier: LaunchDetailsViewController.identifier,
            type: LaunchDetailsViewController.self
        )
        let interactor = LaunchDetailsInteractor(view: launchDetailsVC, launch: launch)
        launchDetailsVC.interactor = interactor
        
        self.navigationController?.pushViewController(launchDetailsVC, animated: true)
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

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInset
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor.didSelectItem(indexPath: indexPath)
    }
}
