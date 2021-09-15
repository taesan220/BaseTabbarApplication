//
//  BaseViewController.swift
//  CustomPageViewController
//
//  Created by Taesan Kim on 2021/09/07.
//

import UIKit

protocol ElementViewControllerDelegate {
    func changePageView(index: Int, data: Any?)
}

class BaseElementViewController: BaseViewController {

//MARK: - Global Variation

    var elementViewControllerDelegate: ElementViewControllerDelegate!

//MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

// 페이지뷰를 변경하는 메소드 by ViewController
    func changePageView(index: Int, data: Any? = nil) {
        
        if self.elementViewControllerDelegate != nil {
            
            self.elementViewControllerDelegate.changePageView(index: index, data: data)
        }
    }
}
