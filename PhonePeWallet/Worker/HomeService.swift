//
//  HomeService.swift
//  PhonePeWallet
//
//  Created by Aanchal Patial on 06/05/24.
//

import Foundation

protocol HomeServiceProtocol: AnyObject {
    func getTransaction(fileName: String, completion: @escaping (Result<TransactionResponse, Error>) -> Void)
}

class HomeService: HomeServiceProtocol {
    func getTransaction(fileName: String, completion: @escaping (Result<TransactionResponse, Error>) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                let response = try TransactionResponse.parse(jsonFile: fileName)
                completion(.success(response))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
}

class JSONReader {

    static func readJSON<T: Decodable>(from bundle: Bundle, filename: String) throws -> T {
        guard let path = bundle.path(forResource: filename, ofType: "json") else {
            throw NSError(domain: "JSONReaderErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Could not find JSON file with filename \(filename)."])
        }

        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
