//
//  Instantiate + ViewController.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 07/07/2022.
//

import UIKit

extension UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: id, bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: id) as? Self else {
            return Self()
        }
        return controller
    }
}
