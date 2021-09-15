//
//  CustomPageViewController.swift
//  CustomPageViewController
//
//  Created by Taesan Kim on 2021/09/07.
//

import UIKit

class CustomPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {


//MARK: - Global variation

//    var redVC: RedViewController!
//    var greenVC: GreenViewController!
//    var blueVC: BlueViewController!
    
    var viewControllerList: [UIViewController] = []

    
//MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if viewControllerList.count <= 0 {
            
            print("There is no ViewController in ViewControllerList of PageViewController")
            return
        }
     
        self.setViewControllers([viewControllerList[0]], direction: .forward, animated: false) { isChanged in
            print("페이지 변경")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
// initialization
    
    func setPageViewControllerList(viewControllerList: [UIViewController]) {
        self.viewControllerList = viewControllerList
    }
    
    //특정 페이지로 변경하는 메소드
    func setPage(index: Int) {
        
        if self.viewControllerList.count <= 0 {
            print("There is no ViewController in ViewControllerList of PageViewController")
            return
        }
        
        self.setViewControllers([viewControllerList[index]], direction: .forward, animated: false) { isChanged in
            print("페이지 변경")
        }
    }
    
    
//MARK: - PageViewController
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return viewControllerList[0]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return viewControllerList[0]
    }
    
    
    
//    //ViewControllers 를 초기확 하는 메소드
//    func initViewController() {
//
//        self.redVC = self.storyboard?.instantiateViewController(withIdentifier: "redVC") as? RedViewController
//        self.greenVC = self.storyboard?.instantiateViewController(withIdentifier: "greenVC") as? GreenViewController
//        self.blueVC = self.storyboard?.instantiateViewController(withIdentifier: "blueVC") as? BlueViewController
//
//        self.viewControllerList = [self.redVC, self.greenVC, self.blueVC]
//    }
}
