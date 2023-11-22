//
//  StoryboardInitializable.swift
//  SessionManagment
//
//  Created by Beto Salcido on 22/11/23.
//

import UIKit

protocol StoryboardInitializable {
    // MARK: - Properties
    /// The name of the storyboard resource file without the filename extension.
    static var storyboardName: String { get }
    
    /// The bundle that contains the storyboard file.
    static var storyboardBundle: Bundle { get }
    
    /// An identifier string that uniquely identifies the view controller in the storyboard file.
    static var storyboardIdentifier: String { get }
    
    // MARK: - Methods
    /// Returns a view controller instance corresponding to the `storyboardIdentifier`.
    static func instantiate() -> Self
}

/// We define a protocol extension for the Storyboardable protocol and use a generic where clause to require that Self is a subclass of UIViewController.
/// Self refers to the type conforming to the Storyboardable protocol.
extension StoryboardInitializable where Self: UIViewController {

    static var storyboardBundle: Bundle {
        return .main
    }
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    static func instantiate() -> Self {
        guard let viewController = UIStoryboard(name: storyboardName, bundle: storyboardBundle).instantiateViewController(withIdentifier: storyboardIdentifier) as? Self else {
            fatalError("Unable to Instantiate View Controller With Storyboard Identifier \(storyboardIdentifier)")
        }

        return viewController
    }
}

