//
//  ViewController.swift
//  YBSApp
//
//  Created by hanif hussain on 08/05/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        // Do any additional setup after loading the view.
        Task {
           try await NetworkManager.shared.getImages(of: "Yorkshire", page: 1)
        }
    }


}

