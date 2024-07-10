//
//  CellIdentifiable.swift
//  SessionManagment
//
//

import Foundation

/// Provides a UITableViewCell or UICollectionViewCell reuse identifier.
protocol CellIdentifiable: AnyObject {
    var cellIdentifier: String { get }
}
