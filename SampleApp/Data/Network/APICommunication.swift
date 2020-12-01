import RxSwift
import Alamofire

final class APICommunication: APIService {
    let reachability: ReachabilityType?
    
    init(reachability: ReachabilityType?) {
        self.reachability = reachability
    }
    
    func getLatestLaunches() -> Observable<[Launch]> {
        return getRequest(to: Url.launchesPast, method: .get).map { (launches: [Launch]) -> [Launch] in launches.reversed() }
    }
    
    func getRocket(id: String) -> Observable<Rocket> {
        return getRequest(to: "\(Url.rockets)/\(id)", method: .get)
    }
    
    func getRequest<T: Codable>(
        to url: String,
        with parameters: Parameters! = [:],
        method: HTTPMethod,
        headers: HTTPHeaders? = nil
    ) -> Observable<T> {
        guard let isReachable = reachability?.isReachable, isReachable else { return Observable.error(Exception.NetworkConnection) }
        return Observable.create { observer in
            let request = AF.request(url,
                                     method: method,
                                     parameters: parameters,
                                     encoding: URLEncoding.queryString,
                                     headers: headers)
            .validate().responseDecodable { (response: DataResponse<T, AFError>)  in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(Exception.HTTP(error: error, data: response.data))
                    }
            }
            request.resume()
            
            return Disposables.create { request.cancel() }
        }.subscribe(on: ConcurrentDispatchQueueScheduler(qos: .utility))
    }
}
