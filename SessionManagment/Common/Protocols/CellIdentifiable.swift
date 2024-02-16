//
//  CellIdentifiable.swift
//  SessionManagment
//
//  Created by Beto Salcido on 13/02/24.
//

import Foundation

/// Provides a UITableViewCell or UICollectionViewCell reuse identifier.
protocol CellIdentifiable: AnyObject {
    var cellIdentifier: String { get }
}
