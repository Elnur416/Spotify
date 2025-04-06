//
//  Categories.swift
//  Spotify
//
//  Created by Elnur Mammadov on 06.04.25.
//

import Foundation

// MARK: - Categories
struct Categories: Codable {
    let categories: CategoriesClass?
}

// MARK: - CategoriesClass
struct CategoriesClass: Codable {
    let href: String?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int?
    let items: [CategoryItem]?
}

// MARK: - Item
struct CategoryItem: Codable {
    let href: String?
    let icons: [Icon]?
    let id, name: String?
}

// MARK: - Icon
struct Icon: Codable {
    let url: String?
    let height, width: Int?
}
