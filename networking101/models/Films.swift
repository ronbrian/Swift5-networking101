//
//  Films.swift
//  networking101
//
//  Created by Ron Machoka on 10/12/20.
//

import Foundation

struct Films: Decodable {
  let count: Int
  let all: [Film]
  
  enum CodingKeys: String, CodingKey {
    case count
    case all = "results"
  }
}
