import RxSwift

protocol APIService {
    func getLatestLaunches() -> Observable<[Launch]>
}
