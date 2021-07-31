//
//  Items.swift
//  TestPryaniki
//
//  Created by Russ Rosaura on 7/30/21.
//  Copyright © 2021 Russ Rosaura. All rights reserved.
//

import Foundation

struct Welcome: Codable {
    var data: [Result]
    var view: [String]
}

struct Result: Codable {
    var name: String
    var data: DataClass
}

struct DataClass: Codable {
    var text: String?
    var url: String?
    var selectedID: Int?
    var variants: [Variant]?

    enum CodingKeys: String, CodingKey {
        case text, url
        case selectedID = "selectedId"
        case variants
    }
}

struct Variant: Codable {
    var id: Int
    var text: String
}
