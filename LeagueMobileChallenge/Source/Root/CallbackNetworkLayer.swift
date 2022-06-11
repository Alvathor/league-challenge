//
//  CallbackNetworkLayer.swift
//  
//
//  Created by Marcelo Reis on 10/06/22.
//

import Foundation
import Combine

public class CallbackNetworkService {
    public var token: String? = nil
    
    enum NetworkError: Error {
        case serverError(statusCode: Int?)
        case noDataReceived
        case decodingError(DecodingError)
        case unknowError(Error)
    }
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func get<T: Decodable>(url: URL, callback: @escaping (Result<T, Error>) -> ()) {
        var urlRequest = URLRequest(url: url)
        
        if let token = token {
            urlRequest.addValue(token, forHTTPHeaderField: "x-access-token")
        }
        
        session.dataTask(with: urlRequest) { data, response, error in
            // 1. Network Error Handling
            guard error == nil else {
                callback(.failure(error!))
                return
            }
            
            // 2. Server Error Handling
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            guard
                let code = statusCode,
                (200..<300) ~= code
            else {
                callback(.failure(NetworkError.serverError(statusCode: statusCode)))
                return
            }
            
            // 3. No Data Error
            guard let data = data else {
                callback(.failure(NetworkError.noDataReceived))
                return
            }
            
            do  {
                // 4. Decoding Data
                let decoded = try JSONDecoder().decode(T.self, from: data)
                callback(.success(decoded))
            } catch {
                // 5. Decoding Error Handling
                guard let decodingError = error as? DecodingError else {
                    callback(.failure(NetworkError.unknowError(error)))
                    return
                }
                
                callback(.failure(NetworkError.decodingError(decodingError)))
            }
            
        }
        .resume()
    }
}



public enum AsyncError: Error {
    case finishedWithoutValue
}

public extension AnyPublisher {
    /**
     Allows converting values from an `AnyPublisher` and use it in an `async` context.

     Ex.
     ```
user avatar user avatar user avatar
     func loadCustomer() -> AnyPublisher<Customer, Error> { ... }
     func load() async {
        do {
            let customer = try await loadCustomer().async()
            ...
        }
     }
     ```
     */
    func async() async throws -> Output {
        try await withCheckedThrowingContinuation { continuation in
            var cancellable: AnyCancellable?
            // note that `async` values -must- complete with a value, unlike publishers.
            var finishedWithoutValue = true
            cancellable = first()
                .sink { result in
                    switch result {
                    case .finished:
                        if finishedWithoutValue {
                            continuation.resume(throwing: AsyncError.finishedWithoutValue)
                        }
                    case let .failure(error):
                        continuation.resume(throwing: error)
                    }
                    cancellable?.cancel()
                } receiveValue: { value in
                    finishedWithoutValue = false
                    continuation.resume(with: .success(value))
                }
        }
    }
}

extension Sequence {
    func asyncMap<T>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()

        for element in self {
            try await values.append(transform(element))
        }

        return values
    }
}

extension Sequence {
    func concurrentMap<T>(
        _ transform: @escaping (Element) async throws -> T
    ) async throws -> [T] {
        let tasks = map { element in
            Task {
    try await transform(element)
}
        }

        return try await tasks.asyncMap { task in
            try await task.value
        }
    }
}
