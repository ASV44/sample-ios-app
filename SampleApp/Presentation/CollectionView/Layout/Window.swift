import UIKit

struct Window {
    public static var isPad: Bool {
        return Vertical.isRegular && Horizontal.isRegular
    }

    public static var isPhone: Bool {
        return !isPad
    }
    
    private static var keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

    private enum Vertical {
        public static var isRegular: Bool {
            return keyWindow?.traitCollection.verticalSizeClass == .regular
        }

        public static var isCompact: Bool {
            return keyWindow?.traitCollection.verticalSizeClass == .compact
        }
    }

    private enum Horizontal {
        public static var isRegular: Bool {
            return keyWindow?.traitCollection.horizontalSizeClass == .regular
        }

        public static var isCompact: Bool {
            return keyWindow?.traitCollection.horizontalSizeClass == .compact
        }
    }
}
