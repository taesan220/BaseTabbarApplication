//
//  ViewController.swift
//  CustomPageViewController
//
//  Created by sdev-mac on 2021/09/07.
//

import UIKit

class MainViewController: BaseViewController, ElementViewControllerDelegate {


//MARK: - Global variation
    var tabbarPageController: TabbarPageController!
    
    // ViewController list
    private var viewControllerList: [UIViewController] = []
    
    // ViewControllers
    var redVC: RedViewController!
    var greenVC: GreenViewController!
    var blueVC: BlueViewController!
    
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //뷰가 모두 로드된 후 호출되는 메소드 -> SubView 초기화 (viewDidLaod에서 호출)
    override func subviewInitialize() {
        super.subviewInitialize()
        
        self.initPageViewController()  // PageView에 들어갈 화면 초기화

        self.tabbarPageController.setPageView(index: 0, animated: false)  //초기화 시 에니메이션 적용 하지 않음
    }

//MARK: - Initialization
    // PageView에 들어갈 화면을 초기화 하는 메소드
    func initPageViewController() {
        
        self.tabbarPageController = TabbarPageController(frame: self.view.bounds)
        
        self.view.addSubview(self.tabbarPageController)
        
        self.redVC = self.storyboard?.instantiateViewController(withIdentifier: "redVC") as? RedViewController
        self.greenVC = self.storyboard?.instantiateViewController(withIdentifier: "greenVC") as? GreenViewController
        self.blueVC = self.storyboard?.instantiateViewController(withIdentifier: "blueVC") as? BlueViewController
        
        self.viewControllerList = [self.redVC, greenVC, blueVC]
        
        //ViewController Element내에서 페이지를 변경하기 위한 델리게이트 지정
        //----실제 사용시 필요한 ViewController에만 델리게이트 지정
        redVC.elementViewControllerDelegate = self
        greenVC.elementViewControllerDelegate = self
        blueVC.elementViewControllerDelegate = self
        
        
        self.tabbarPageController.setPageViewControllerList(viewControllerList: viewControllerList)
    }
    
//MARK: - PageChange
    //각 뷰컨트롤러에서 호출되는 사용자 델리게이트 메소드
    func changePageView(index: Int, data: Any?) {
        
        if data != nil {
            
            if let dataString: String = data as? String {
                switch index {
                case 0:
                    redVC.setText(text: dataString)     //전달받은 텍스트를 팝업될 뷰컨트롤러로 전달
                    break
                case 1:
                    greenVC.setText(text: dataString)     //전달받은 텍스트를 팝업될 뷰컨트롤러로 전달
                    break
                case 2:
                    blueVC.setText(text: dataString)     //전달받은 텍스트를 팝업될 뷰컨트롤러로 전달
                    break
                default:
                    print("Index number is over than Viewcontroller count")
                }
            }
            

        }
        
        self.tabbarPageController.setPageView(index: index)
    }
    
//MARK: - Button Click Event

}

