//
//  BaseViewController.swift
//  BaseApplicationPractice
//
//  Created by sdev-mac on 2021/09/15.
//

import UIKit

class BaseViewController: UIViewController {

//MARK: - Global Variation
    
    //서브뷰를 ViewDidApear에서 추가하기 위해, 한번만 호출하도록 체크하는 변수
    var isViewsinitialized = false
    
    var indicator: CustomIndicatorView!

//MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isViewsinitialized {
            
            DispatchQueue.main.async {
             
                // 뷰 초기화를 최초 실행시 하기 위해 최초 한번만 메소드 호출 -> 뷰를 다 그리고 서브뷰를 Add 해야 사이즈가 변형이 안됨
                self.subviewInitialize()
                
                self.isViewsinitialized = true
            }
        }
    }
    
    func subviewInitialize() {}    //뷰를 최초 실행시 화면 사이즈에 맞게 초기화 하기 위해 하위 메소드에서 호출
    
//MARK: - Indicator
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
