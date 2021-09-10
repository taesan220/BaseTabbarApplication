//
//  CustomIndicatorView.swift
//  IndicatorPractice
//
//  Created by Taesan Kim on 2021/09/07.
//

import UIKit

class CustomIndicatorView: UIView {
    
//MARK: - Global variables

    var backGroundView: UIView!
    
    var indicator: UIActivityIndicatorView!
    
    var testButton:UIButton!

#if DEBUG
    var isTest = true
#else
    var isTest = false
#endif

    let indicatorWidth = 80
    let indicatorHeight = 80
    
    let BASE_ALPHA:CGFloat = 0.5

    var isIndicatorWorking = false
    
//MARK: - initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .black
        self.alpha = BASE_ALPHA
        
        setIndicator()
        startIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //사용자 초기화 메소드
    init(viewController: UIViewController? = nil, frame: CGRect, backgroundColor: UIColor = UIColor.black, backGroundAlpha: CGFloat = -1, indicatorColor: UIColor = UIColor.white, moveYPosition: CGFloat = 0) {
        
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        
        if backGroundView == nil {
            self.backGroundView = UIView(frame: frame)
            
            self.backGroundView.backgroundColor = backgroundColor
          
            self.alpha = backGroundAlpha
            
            if backGroundAlpha == -1 {  //기본 값이 없을 경우 설정된 초기값으로 Alpha값 지정
                self.alpha = BASE_ALPHA
            }
            
            self.backGroundView.alpha = self.alpha
            self.addSubview(self.backGroundView)
            
            setIndicator(viewController: viewController, indicatorColor: indicatorColor, moveYPosition: moveYPosition)
        }
    }
    
    func InitCustomIndicator(viewController: UIViewController? = nil, frame: CGRect, backgroundColor: UIColor = UIColor.black, backGroundAlpha: CGFloat = 0.5, indicatorColor: UIColor = UIColor.white, moveYPosition: CGFloat = 0) {
        
        if indicator == nil {
            self.frame = frame
            self.backgroundColor = backgroundColor
            self.alpha = backGroundAlpha
            
            setIndicator(viewController: viewController, indicatorColor: indicatorColor, moveYPosition: moveYPosition)
        }
    }
    
    private func setIndicator(viewController: UIViewController? = nil, indicatorColor: UIColor = UIColor.white, moveYPosition: CGFloat = 0) {
        
        if self.indicator == nil {
            
            let indicatorX = (Int(self.frame.width) / 2) - (indicatorWidth / 2)
            let indicatorY = (Int(self.frame.height) / 2) - (indicatorHeight / 2)
            
            self.indicator = UIActivityIndicatorView.init(frame: CGRect(x: indicatorX, y: indicatorY, width: indicatorWidth, height: indicatorHeight))
            self.indicator.hidesWhenStopped = true
            self.indicator.style = .whiteLarge
            self.indicator.color = indicatorColor
            
            if isTest {
                if testButton == nil {
                    
                    self.testButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                    self.testButton.setTitle("STOP", for: .normal)
                    self.testButton.addTarget(self, action: #selector(stopButtonPressed(_ :)), for: .touchUpInside)
                    
                }
            }
            
            if viewController == nil {
                
                let topViewController = AppDelegate.shared.topViewController()
                
                topViewController.view.addSubview(indicator)
                
                if isTest {
                    topViewController.view.addSubview(testButton)

                }
            } else {
                viewController?.view.addSubview(indicator)
                
                if isTest {
                    viewController!.view.addSubview(testButton)
                }
            }
            
        }
    }
    
    
//MARK: - indicator control
    func startIndicator(viewController: UIViewController? = nil) {
        
        if self.isIndicatorWorking {
            return
        }
        
        self.isIndicatorWorking = true
        
        self.indicator.startAnimating()
        
        
        if viewController == nil {
            let topViewController = AppDelegate.shared.topViewController()

            topViewController.view.bringSubviewToFront(indicator)
            
            if isTest {
                topViewController.view.bringSubviewToFront(self.testButton)
            }
        } else {
            viewController?.view.bringSubviewToFront(self.backGroundView)

            viewController?.view.bringSubviewToFront(indicator)
            
            if isTest {
                viewController?.view.bringSubviewToFront(self.testButton)
            }
        }
    }
    
    func stopIndicator() {
        
        if isIndicatorWorking {
            self.indicator.stopAnimating()
            self.removeFromSuperview()
            
            self.indicator.removeFromSuperview()
            self.indicator = nil
            
            backGroundView.removeFromSuperview()
            backGroundView = nil
           
            if isTest {
                self.testButton.removeFromSuperview()
                self.testButton = nil
            }
        }
        
        self.isIndicatorWorking = false

        self.removeFromSuperview()
    }

    
//MARK: - Test Button event
    @objc func stopButtonPressed(_ sender: UIButton) {
        stopIndicator()
    }
}
