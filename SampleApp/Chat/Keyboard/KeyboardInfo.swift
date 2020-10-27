import UIKit

public struct KeyboardInfo {
    public let initialFrame: CGRect
    public let finalFrame: CGRect
    public let curve: UIView.AnimationCurve
    public let duration: Double
    public let isLocal: Bool

    public init(initialFrame: CGRect = .zero,
                finalFrame: CGRect = CGRect(),
                curve: UIView.AnimationCurve = .easeInOut,
                duration: Double = 0,
                isLocal: Bool = false) {
        self.initialFrame = initialFrame
        self.finalFrame = finalFrame
        self.curve = curve
        self.duration = duration
        self.isLocal = isLocal
    }
}

public extension KeyboardInfo {
    init?(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any] else { return nil }
        self.init(userInfo: userInfo)
    }

    init?(userInfo: [String: Any]) {
        guard let initialFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
            let finalFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let curveInt = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int,
            let curve = UIView.AnimationCurve(rawValue: curveInt),
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let isLocal = userInfo[UIResponder.keyboardIsLocalUserInfoKey] as? Bool else { return nil }
        self.initialFrame = initialFrame
        self.finalFrame = finalFrame
        self.curve = curve
        self.duration = duration
        self.isLocal = isLocal
    }

    var size: CGSize {
        return finalFrame.size
    }
}
