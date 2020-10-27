import UIKit

public protocol KeyboardType {
    var isDisplayed: Bool { get }
    var keyboardInfo: KeyboardInfo { get }
    func subscribe<T: KeyboardObserver>(_ observer: T)
    func unsubscribe<T: KeyboardObserver>(_ observer: T)
}

public protocol KeyboardObserver: AnyObject {
    func keyboardWillShow(info: KeyboardInfo)
    func keyboardWillHide(info: KeyboardInfo)
    func keyboardDidShow(info: KeyboardInfo)
}

public extension KeyboardObserver {
    func keyboardDidShow(info: KeyboardInfo) {}
}

private class ObserverWrapper {
    weak var observer: KeyboardObserver?

    init(_ observer: KeyboardObserver) {
        self.observer = observer
    }
}

public final class Keyboard: KeyboardType {
    public var isDisplayed: Bool
    public var keyboardInfo: KeyboardInfo
    private var observers: [ObserverWrapper] = []

    // MARK: - Public methods

    public init(isDisplayed: Bool = false,
                keyboardInfo: KeyboardInfo = KeyboardInfo()) {
        self.isDisplayed = isDisplayed
        self.keyboardInfo = keyboardInfo
        
        subscribeToKeyboardNotifications()
    }

    public func subscribe<T: KeyboardObserver>(_ observer: T) {
        let observerWrapper = ObserverWrapper(observer)
        cleanUp()
        if observers.contains(where: { $0.observer === observer }) { return }
        observers.append(observerWrapper)
    }

    public func unsubscribe<T: KeyboardObserver>(_ observer: T) {
        observers = observers.filter { $0.observer !== observer }
    }

    private func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: - Notification methods

    @objc func keyboardWillShow(_ notification: Notification) {
        isDisplayed = true
        guard let infoObject = KeyboardInfo(notification: notification) else { return }
        observers.forEach { $0.observer?.keyboardWillShow(info: infoObject) }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        isDisplayed = false
        guard let infoObject = KeyboardInfo(notification: notification) else { return }
        observers.forEach { $0.observer?.keyboardWillHide(info: infoObject) }
    }

    // MARK: - Private methods

    private func cleanUp() {
        observers = observers.filter { $0.observer != nil}
    }

    deinit { unsubscribeFromKeyboardNotifications() }
}
