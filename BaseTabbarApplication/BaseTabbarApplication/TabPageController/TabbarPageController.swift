//
//  TabPageController.swift
//  BaseApplicationPractice
//
//  Created by Taesan Kim on 2021/09/07.
//

import UIKit

protocol TabbarPageControllerDelegate {
    func tabbarButtonPressed(index: Int)    //탭바 버튼을 누르면 호출되는 사용자 델리게이트 메소드
}

class TabbarPageController: BaseView, CustomTabBarDelegate {
    
    // Custom Delegate
    var tabbarPageControllerDelegate: TabbarPageControllerDelegate!
    
    // Container

    @IBOutlet weak var pageViewContainer: UIView!
    @IBOutlet weak var tabBarContainer: UIView!
    
    
    // PageViewController
    var pageViewController: CustomPageViewController!
    
    // TabBarView
    var tabbar: CustomTabBar!
    
//    var subViewCount: Int = 0
    
    var currentPageIndex = 0
    
    override func viewWillApear() {
       
        super.viewWillApear()
        
        super.setSubView(cellXibName: "TabbarPageController")
        
        print("TabPageController")

        print("self.elementViewContainer.bounds = \(self.bounds)")

        self.initPageView()  // PageView에 들어갈 화면 초기화

        self.initTabBar()    // Tabbar 초기화
    }
    
    override func subviewInitialization() {
        super.subviewInitialization()
        
        //탭바 인디케이터 바 넓이 적용
        self.tabbar.setIndicatorBarWidth(tabBarButtonCount:  self.pageViewController.viewControllerList.count)
    }
    
//MARK: - PageView
    // PageView에 들어갈 화면을 초기화 하는 메소드
    func initPageView() {
        
        self.pageViewController = CustomPageViewController()
        self.pageViewContainer.addSubview(pageViewController.view)
        
        //페이지뷰, 탭바 화면에 고정
        super.setComponetViewOnContainer(componentView: pageViewController.view, containerView: pageViewContainer)
    }
    
    func setPageViewControllerList(viewControllerList: [UIViewController]) {
        
//        self.subViewCount = viewControllerList.count
        
        self.pageViewController.viewControllerList = viewControllerList
    }
    
    func setPageView(index: Int, animated: Bool = true) {
        
        self.currentPageIndex = index   //변경된 페이지를 현재 페이지로 기록
        
        print("setPageView = \(index)")
        
        self.pageViewController.setPage(index: self.currentPageIndex)
                
        tabbar.setButtonStateSwitch(index: self.currentPageIndex)   //버튼 상태 변경
        
        tabbar.moveIndicatorLocation(selectedTabIndex: index, animated: animated)   //탭바 인디케이터 이동
    }
    
//MARK: - Tabbar
    // Tabbar를 초기화 하는 메소드
    func initTabBar() {
        
        print("Tab bar bounds width = \(self.tabBarContainer.bounds.width)")
        
        tabbar = CustomTabBar(frame: self.tabBarContainer.bounds)
        tabbar.customTabBarDelegate = self
        self.tabBarContainer.addSubview(tabbar)
        super.setComponetViewOnContainer(componentView: tabbar, containerView: tabBarContainer)
    }
    
    func tabBarButtonPressed(index: Int) {
 
        self.currentPageIndex = index   //변경된 페이지를 현재 페이지로 기록
        
        if self.tabbarPageControllerDelegate != nil {
            
            //이동할 페이지에 데이터를 먼저 전달 하기 위해 뷰 변경전, 사용자 델리게이트 메소드 호출
            self.tabbarPageControllerDelegate.tabbarButtonPressed(index: self.currentPageIndex) //메인 뷰 컨트롤러에 전달
        }
        
        self.setPageView(index: self.currentPageIndex)  //페이지뷰 변경
    }
}
