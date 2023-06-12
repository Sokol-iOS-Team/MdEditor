//
//  NetworkService.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 11.06.2023.
//

import Foundation

protocol INetworkService {
	func perform<T: Codable>(
		_ request: NetworkRequest,
		token: AuthToken?,
		completion: @escaping (Result<T, HTTPNetworkServiceError>) -> Void
	)
	func perform(
		_ request: NetworkRequest,
		token: AuthToken?,
		completion: @escaping (Result<Data?, HTTPNetworkServiceError>) -> Void
	)
	func perform(
		urlRequest: URLRequest,
		completion: @escaping (Result<Data?, HTTPNetworkServiceError>) -> Void
	)
	func performAuth(
		_ request: NetworkRequest,
		token: AuthToken?,
		completion: @escaping (Result<AuthToken, HTTPNetworkServiceError>) -> Void
	)
}

final class NetworkService: INetworkService {
	private let session: URLSession
	private let requestBuilder: IURLRequestBuilder

	internal init(session: URLSession, requestBuilder: IURLRequestBuilder) {
		self.session = session
		self.requestBuilder = requestBuilder
	}

	func perform<T: Codable>(
		_ request: NetworkRequest,
		token: AuthToken?,
		completion: @escaping (Result<T, HTTPNetworkServiceError>) -> Void
	) {
		let urlRequest = requestBuilder.build(forRequest: request, token: token)
		perform(urlRequest: urlRequest) { result in
			switch result {
			case let .success(data):
				guard let data = data else {
					completion(.failure(.noData))
					return
				}
				do {
					let object = try JSONDecoder().decode(T.self, from: data)
					completion(.success(object))
				} catch {
					completion(.failure(.failedToDecodeResponse(error)))
				}
			case let .failure(error):
				completion(.failure(error))
			}
		}
	}

	func performAuth(
		_ request: NetworkRequest,
		token: AuthToken?,
		completion: @escaping (Result<AuthToken, HTTPNetworkServiceError>) -> Void
	) {
		let urlRequest = requestBuilder.build(forRequest: request, token: token)
		perform(urlRequest: urlRequest) { result in
			switch result {
			case let .success(data):
				guard let data = data else {
					completion(.failure(.noData))
					return
				}
				do {
					let object = try JSONDecoder().decode(AuthToken.self, from: data)
					completion(.success(object))
				} catch {
					completion(.failure(.failedToDecodeResponse(error)))
					print("Типа нету даты")
				}
			case let .failure(error):
				completion(.failure(error))
			}
		}
	}

	func perform(
		_ request: NetworkRequest,
		token: AuthToken?,
		completion: @escaping (Result<Data?, HTTPNetworkServiceError>) -> Void
	) {
		let urlRequest = requestBuilder.build(forRequest: request, token: token)
		perform(urlRequest: urlRequest, completion: completion)
	}

	func perform(urlRequest: URLRequest, completion: @escaping (Result<Data?, HTTPNetworkServiceError>) -> Void) {
		let task = session.dataTask(with: urlRequest) { data, urlResponse, error in
			let networkResponse = NetworkResponse(data: data, urlResponse: urlResponse, error: error)
			completion(networkResponse.result)
		}
		task.resume()
	}
}
