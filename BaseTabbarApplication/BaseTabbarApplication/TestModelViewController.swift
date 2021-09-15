//
//  TestModelViewController.swift
//  BaseTabbarApplication
//
//  Created by sdev-mac on 2021/09/15.
//

import UIKit

class TestModelViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
