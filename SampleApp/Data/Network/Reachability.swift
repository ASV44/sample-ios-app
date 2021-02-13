import Reachability

protocol ReachabilityType {
    var isReachable: Bool { get }
}

extension Reachability: ReachabilityType { }
