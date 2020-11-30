import UIKit

final class CollectionFlowLayout: UICollectionViewFlowLayout {
    struct LayoutSpec {
        let interitemSpacing: CGFloat
        let sectionInset: UIEdgeInsets
        let padItemCount: Int
        let phoneItemCount: Int
    }
    
    private let layoutSpec: LayoutSpec
    private var numberOfItemsForWidth = [CGFloat: Int]()
    
    init(layoutSpec: LayoutSpec) {
        self.layoutSpec = layoutSpec
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var containerWidth: CGFloat {
        guard let collectionWidth = collectionView?.bounds.width else { return 0 }
        return collectionWidth - layoutSpec.sectionInset.left - layoutSpec.sectionInset.right
    }
    
    private func containerWidthExcludingSpacing(numberOfItemsInRow: Int) -> CGFloat {
        return containerWidth - (CGFloat(numberOfItemsInRow) - 1) * layoutSpec.interitemSpacing
    }
    
    public var numberOfItemsInRow: Int {
        if let result = numberOfItemsForWidth[containerWidth] { return result }
        let result = Window.isPad ? layoutSpec.padItemCount : layoutSpec.phoneItemCount
        numberOfItemsForWidth[containerWidth] = result

        return result
    }
    
    public var itemWidth: CGFloat {
        let itemsCount = numberOfItemsInRow
        return floor(containerWidthExcludingSpacing(numberOfItemsInRow: itemsCount) / CGFloat(itemsCount))
    }
    
    public var itemHeight: CGFloat {
        let imageAspectRatio: CGFloat = 3 / 2
        return itemWidth * imageAspectRatio
    }
    
    override var itemSize: CGSize {
        get {
            return CGSize(width: itemWidth, height: itemHeight)
        }
        set {
            super.itemSize = newValue
        }
    }
    
    override var minimumInteritemSpacing: CGFloat {
        get {
            return layoutSpec.interitemSpacing
        } set {
            super.minimumInteritemSpacing = newValue
        }
    }

    override var minimumLineSpacing: CGFloat {
        get {
            return layoutSpec.interitemSpacing
        } set {
            super.minimumLineSpacing = newValue
        }
    }
}
