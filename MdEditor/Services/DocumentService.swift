//
//  DocumentService.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 21.06.2023.
//

import Foundation

// swiftlint:disable all
struct RemoteFile: Codable {
	let id: ID
	let hash: String
	let originalName: String
	let contentType: String
	let size: Int
	let createdAt: String
	let updatedAt: String
	let v: Int
	let url: String

	enum CodingKeys: String, CodingKey {
		case id = "_id"
		case hash
		case originalName
		case contentType
		case size
		case createdAt
		case updatedAt
		case v = "__v"
		case url
	}

	struct ID: Codable {
		let rawValue: String

		init(from decoder: Decoder) throws {
			let container = try decoder.singleValueContainer()
			rawValue = try container.decode(String.self)
		}

		func encode(to encoder: Encoder) throws {
			var container = encoder.singleValueContainer()
			try container.encode(rawValue)
		}
	}
}

/// Ошибки при работе с DocumentService
enum DocumentServiceError: Error {
	case receiveError(Error)
}

protocol IDocumentService {
	func fileList(completion: @escaping (Result<[RemoteFile], DocumentServiceError>) -> Void)
//	func upload(file: RemoteFile, body: Data, completion: (Result<Void, DocumentServiceError>) -> Void)
//	func delete(id: RemoteFile.ID, completion: (Result<Void, DocumentServiceError>) -> Void)
//	func download(id: RemoteFile.ID, completion: (Result<Data, DocumentServiceError>) -> Void)
}

final class DocumentService: IDocumentService {

	// MARK: - Dependencies

	private let networkService: NetworkService
	private let authTokenRepository: AuthTokenRepository

	// MARK: - Lifecycle

	init(networkService: NetworkService, authTokenRepository: AuthTokenRepository) {
		self.networkService = networkService
		self.authTokenRepository = authTokenRepository
	}

	// MARK: - Internal Methods

	func fileList(completion: @escaping (Result<[RemoteFile], DocumentServiceError>) -> Void) {
		let request = NetworkRequest(path: URLStab.files, method: .get, parameters: .none)
		let token = authTokenRepository.getSecret()
		networkService.perform(request, token: token) { (result: Result<[RemoteFile], HTTPNetworkServiceError>) in
			switch result {
			case .success(let files):
				completion(.success(files))
			case .failure(let error):
				completion(.failure(.receiveError(error)))
			}
		}
	}

//	func upload(file: RemoteFile, body: Data, completion: (Result<Void, DocumentServiceError>) -> Void) {}
//	func delete(id: RemoteFile.ID, completion: (Result<Void, DocumentServiceError>) -> Void) {}
//	func download(id: RemoteFile.ID, completion: (Result<Data, DocumentServiceError>) -> Void) {}
}
// swiftlint:enable all
