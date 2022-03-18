//
//  ContentView.swift
//  Dogs
//
//  Created by Matteo Manferdini on 18/03/22.
//

import SwiftUI

struct ContentView: View {
	@State private var image: UIImage?

    var body: some View {
		VStack {
			if let image = image {
				Image(uiImage: image)
					.resizable()
					.aspectRatio(contentMode: .fit)
			}
			Button("Reload") {
				Task {
					image = try? await fetchImage()
				}
			}
		}
		.task {
			image = try? await fetchImage()
		}
    }
}

func fetchDog() async throws -> Dog {
	let dogURL = URL(string: "https://dog.ceo/api/breeds/image/random")!
	let (data, _) = try await URLSession.shared.data(from: dogURL)
	return try JSONDecoder().decode(Dog.self, from: data)
}

func fetchImage() async throws -> UIImage {
	let dog = try await fetchDog()
	let (data, _) = try await URLSession.shared.data(from: dog.url)
	return UIImage(data: data)!
}

func fetchImages() async throws -> [UIImage] {
	async let first = fetchImage()
	async let second = fetchImage()
	async let third = fetchImage()
	return try await [first, second, third]
}

struct Dog: Identifiable, Codable {
	let message: String
	let status: String

	var id: String { message }
	var url: URL { URL(string: message)! }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
