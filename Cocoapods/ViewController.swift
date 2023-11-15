//
//  ViewController.swift
//  Cocoapods
//
//  Created by Beto Salcido on 10/11/23.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet private var imageViewA: UIImageView!
    @IBOutlet private var imageViewB: UIImageView!
    @IBOutlet private var imageViewC: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// `Kingfisher` es una librería que se utiliza para cargar imágenes mediante URLs.
        let urlA = URL(string: "https://plus.unsplash.com/premium_photo-1699537318938-7af01500c359?q=80&w=2187&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
        let urlB = URL(string: "https://images.unsplash.com/photo-1699539963148-d8701725421b?q=80&w=2340&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
        let urlC = URL(string: "https://images.unsplash.com/photo-1699383824460-9708bc6f998f?q=80&w=2187&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
        
        imageViewA.kf.setImage(with: urlA)
        imageViewB.kf.setImage(with: urlB)
        imageViewC.kf.setImage(with: urlC)
    }
}

