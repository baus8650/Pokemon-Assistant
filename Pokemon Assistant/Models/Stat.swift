//
//  Stat.swift
//  Pokemon Assistant
//
//  Created by Tim Bausch on 12/20/21.
//

import Foundation

struct Stat: Codable {
    var base_stat: Int
    var stat: [String: String]
}
