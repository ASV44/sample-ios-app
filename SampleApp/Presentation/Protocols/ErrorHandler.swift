import Foundation

protocol ExceptionHandler {
    func handleException(errorPresentable: ErrorPresentable?, error: Error)
}

extension ExceptionHandler {
    func handleException(errorPresentable: ErrorPresentable?, error: Error) {
        guard let errorPresentable = errorPresentable,
              let exception = error as? Exception else { return }
        switch exception {
        case .HTTP(let error, let data):
            errorPresentable.showErrorAlert(errorMessage: decodeApiError(from: data)?.description ?? error.localizedDescription)
            break
        case .NetworkConnection:
            errorPresentable.showErrorAlert(errorMessage: exception.message)
        }
    }
    
    private func decodeApiError(from data: Data?) -> APIError? {
        guard let rawData = data,
              let apiError = try? JSONDecoder().decode(APIError.self, from: rawData) else { return nil }
        
        return apiError
    }
}
