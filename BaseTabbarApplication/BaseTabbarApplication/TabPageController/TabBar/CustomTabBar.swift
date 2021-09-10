//
//  CustomTabBarController.swift
//  BaseApplicationPractice
//
//  Created by Taesan Kim on 2021/09/07.
//

import UIKit

protocol CustomTabBarDelegate {
    func tabBarButtonPressed(index: Int)
}

class CustomTabBar: BaseView {

//MARK: - Global Variation
    //Custom delegate
    var customTabBarDelegate: CustomTabBarDelegate!
    
    
    @IBOutlet weak var tabbarIndicatView: UIView!
    
    @IBOutlet weak var indicatorBarXGapConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var indicatorBarWidthConstraint: NSLayoutConstraint!
    
    var indicatorBarWidth: CGFloat = 0
    
    //Buttons
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    
//MARK: - Life Cycle
    override func viewWillApear() {
        super.setSubView(cellXibName: "CustomTabBar")
    }
    
//MARK: - Initialization
    
    // 탭바의 인디케이터 바 넓이를 적용하는 메소드
    func setIndicatorBarWidth(viewControllerCount: Int) {
        
        // Tabbar Indicator 넓이를 구함
        self.indicatorBarWidth = self.bounds.width / CGFloat(viewControllerCount)
        
        self.indicatorBarWidthConstraint.constant = self.indicatorBarWidth
    }
    
//MARK: - Button Pressed
    
    @IBAction func oneButtonPressed(_ sender: Any) {
        
        tabbedButton(index: 0)
    }
    
    @IBAction func twoButtonPressed(_ sender: Any) {
        
        tabbedButton(index: 1)
    }
    
    @IBAction func threeButtonPressed(_ sender: Any) {
        
        tabbedButton(index: 2)
    }
    
    // 탭바의 인디케이터 바 위치를 이동시키는 메소드
    func moveIndicatorLocation(selectedTabIndex: Int, animated: Bool = true) {
        
        if animated {
            DispatchQueue.main.async {
            
                UIView.animate(withDuration: 0.2) {
                    self.indicatorBarXGapConstraint.constant = self.indicatorBarWidth * CGFloat(selectedTabIndex)
                    
                    self.layoutIfNeeded()
                }
            }
        } else {
         
            indicatorBarXGapConstraint.constant = indicatorBarWidth * CGFloat(selectedTabIndex)
        }
    }
    
    //탭바 버튼이 눌러지면 호출되는 메소드
    func tabbedButton(index: Int) {
                
        if customTabBarDelegate != nil {
            customTabBarDelegate.tabBarButtonPressed(index: index)
        }        
    }
    
    //냅바의 버튼 상태를 변경하는 메소드
    func setButtonStateSwitch(index: Int) {
        
        button1.setTitleColor(.black, for: .normal)
        button2.setTitleColor(.black, for: .normal)
        button3.setTitleColor(.black, for: .normal)
        
        switch index {
        case 0:
            button1.setTitleColor(.white, for: .normal)     //선택한 탭 버튼 텍스트 색 변경
            break
        case 1:
            button2.setTitleColor(.white, for: .normal)     //선택한 탭 버튼 텍스트 색 변경
            break
        case 2:
            button3.setTitleColor(.white, for: .normal)     //선택한 탭 버튼 텍스트 색 변경
            break
        default:
            print("Index number is over than Viewcontroller count")
        }
    }
}
