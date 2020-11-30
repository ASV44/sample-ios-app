import UIKit

protocol NibLoadable: Identifiable where Self: UIView {
    static var bundle: Bundle { get }
    static var nibName: String { get }
    static var nib: UINib { get }
    static func instantiate() -> Self
}

extension NibLoadable {
    static var bundle: Bundle {
        return Bundle(for: Self.self)
    }

    static var nibName: String {
        return String(describing: self)
    }

    static var nib: UINib {
        return UINib(nibName: nibName, bundle: bundle)
    }

    static func instantiate() -> Self {
        let nibs = nib.instantiate(withOwner: nil, options: nil)
        guard let view = nibs.lazy.compactMap ({ $0 as? Self }).first else {
            fatalError("Could not instantiate \(identifier) from nib file.")
        }

        return view
    }
}
