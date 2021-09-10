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

class BaseElementViewController: UIViewController {

//MARK: - Global Variation

    var elementViewControllerDelegate: ElementViewControllerDelegate!
    
    var indicator: CustomIndicatorView!
    

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
    
    // 최상위 뷰 컨트롤러에 인디케이터를 표시하는 메소드
    func startIndicator() {
        
        print("BaseViewController")
        
        DispatchQueue.main.async {
            
            print("frame = \(self.view.bounds)")
            
            if self.indicator == nil || self.indicator.indicator == nil {
                self.indicator = CustomIndicatorView(viewController: self, frame: self.view.bounds, backGroundAlpha: 0.3, indicatorColor: .black, moveYPosition: 0)
                
                self.view.addSubview(self.indicator)
                
                self.indicator.startIndicator(viewController: self)
            } else {
                if !self.indicator.isIndicatorWorking {
                    self.indicator.startIndicator(viewController: self)
                }
            }
        }
    }
    
    //나타난 인디케이터를 종료하는 메소드@objc
    func stopIndicator() {
        
        if self.indicator != nil {
            
            indicator.stopIndicator()
            
            self.indicator.removeFromSuperview()
            
            
            self.indicator = nil
        }
    }
}
