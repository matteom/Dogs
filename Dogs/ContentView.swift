//
//  ContentView.swift
//  Dogs
//
//  Created by Matteo Manferdini on 25/07/23.
//

import SwiftUI

struct ContentView: View {
	var viewModel = ViewModel()

	var body: some View {
		List(viewModel.dogs) { dog in
			AsyncImage(url: dog.url, content: { image in
				image
					.resizable()
					.aspectRatio(contentMode: .fit)
			}, placeholder: {
				ProgressView()
			})
		}
		.listStyle(.plain)
		.task { await viewModel.refresh() }
		.refreshable {
			Task { await viewModel.refresh() }
		}
		.toolbar {
			Button("Reload") {
				Task { await viewModel.refresh() }
			}
		}
	}
}

#Preview {
	NavigationStack {
		ContentView()
	}
}
