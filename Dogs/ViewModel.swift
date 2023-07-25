//
//  ViewModel.swift
//  Dogs
//
//  Created by Matteo Manferdini on 07/08/23.
//

import Foundation
import Observation

@Observable class ViewModel {
	var dogs: [Dog] = []

	func fetchDog() async throws -> Dog {
		let dogURL = URL(string: "https://dog.ceo/api/breeds/image/random")!
		let (data, _) = try await URLSession.shared.data(from: dogURL)
		return try JSONDecoder().decode(Dog.self, from: data)
	}

	func fetchThreeDogs() async throws -> [Dog] {
		async let first = fetchDog()
		async let second = fetchDog()
		async let third = fetchDog()
		return try await [first, second, third]
	}

	func refresh() async {
		dogs = (try? await fetchThreeDogs()) ?? []
	}
}
