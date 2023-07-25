//
//  Callback.swift
//  Dogs
//
//  Created by Matteo Manferdini on 02/08/23.
//

import Foundation

struct HTTPError: Error {
	let statusCode: Int
}

func fetchDog(completion: @escaping (Result<Dog, Error>) -> Void) {
	let dogURL = URL(string: "https://dog.ceo/api/breeds/image/random")!
	let task = URLSession.shared.dataTask(with: dogURL) { data, response, error in
		if let error = error {
			completion(.failure(error))
			return
		}
		if let response = (response as? HTTPURLResponse), response.statusCode != 200 {
			completion(.failure(HTTPError(statusCode: response.statusCode)))
			return
		}
		do {
			let dog = try JSONDecoder().decode(Dog.self, from: data!)
			completion(.success(dog))
		} catch {
			completion(.failure(error))
		}
	}
	task.resume()
}
