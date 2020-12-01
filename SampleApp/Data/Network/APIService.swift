import RxSwift

protocol APIService {
    func getLatestLaunches() -> Observable<[Launch]>
    func getRocket(id: String) -> Observable<Rocket>
}
