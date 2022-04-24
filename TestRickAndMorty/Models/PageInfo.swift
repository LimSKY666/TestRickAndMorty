//
//  Page.swift
//  TestRickAndMorty
//
//  Created by Семён Соколов on 23.04.2022.
//

import Foundation

struct PageInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
