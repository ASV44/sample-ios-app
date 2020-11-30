import UIKit

public extension UIEdgeInsets {
    init(vertical: CGFloat = 0.0, horizontal: CGFloat = 0.0) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}
