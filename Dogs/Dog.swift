//
//  Dog.swift
//  Dogs
//
//  Created by Matteo Manferdini on 02/08/23.
//

import Foundation

struct Dog: Identifiable, Codable {
	let message: String
	let status: String

	var id: String { message }
	var url: URL { URL(string: message)! }
}
