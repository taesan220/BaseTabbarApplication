//
//  TabPageController.swift
//  BaseApplicationPractice
//
//  Created by Taesan Kim on 2021/09/07.
//

import UIKit

class TabbarPageController: BaseView, CustomTabBarDelegate {
    
    // Container

    @IBOutlet weak var pageViewContainer: UIView!
    @IBOutlet weak var tabBarContainer: UIView!
    
    
    // PageViewController
    var pageViewController: CustomPageViewController!
    
    // TabBarView
    var tabbar: CustomTabBar!
    
    override func viewWillApear() {
       
        super.setSubView(cellXibName: "TabbarPageController")
        
        print("TabPageController")

        self.initPageView()  // PageView에 들어갈 화면 초기화
        
 
        self.initTabBar()    // Tabbar 초기화
        
        tabbar = CustomTabBar(frame: self.tabBarContainer.bounds)
        tabbar.customTabBarDelegate = self
        self.tabBarContainer.addSubview(tabbar)
        super.setComponetViewOnContainer(componentView: tabbar, containerView: tabBarContainer)
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
        pageViewController.viewControllerList = viewControllerList
        
        DispatchQueue.main.async {  // 가로의 크기가 정의되고 그에 맞게 탭바 인디케이터 넓이를 구함
            //탭바 인디케이터 바 넓이 적용
            self.tabbar.setIndicatorBarWidth(viewControllerCount: viewControllerList.count)
        }
    }
    
    func setPageView(index: Int, animated: Bool = true) {
        self.pageViewController.setPage(index: index)
        
        tabbar.moveIndicatorLocation(selectedTabIndex: index, animated: animated)   //탭바 인디케이터 이동
        
        tabbar.setButtonStateSwitch(index: index)   //버튼 상태 변경
    }
    
//MARK: - Tabbar
    // Tabbar를 초기화 하는 메소드
    func initTabBar() {
        tabbar = CustomTabBar(frame: self.tabBarContainer.bounds)
        tabbar.customTabBarDelegate = self
        self.tabBarContainer.addSubview(tabbar)
        super.setComponetViewOnContainer(componentView: tabbar, containerView: tabBarContainer)
    }
    
    func tabBarButtonPressed(index: Int) {
        self.setPageView(index: index)  //페이지뷰 변경
    }
    
    
}
