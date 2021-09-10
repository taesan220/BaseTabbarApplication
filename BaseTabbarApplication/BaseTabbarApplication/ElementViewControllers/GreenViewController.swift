//
//  GreenViewController.swift
//  CustomPageViewController
//
//  Created by Taesan Kim on 2021/09/07.
//

import UIKit

class GreenViewController: BaseElementViewController {

//MARK: - Global variation

    var yellowView: UIView!

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var button: UIButton!

    
    var text = "Hello World!"   //다른 페이지에서 이 뷰컨트롤러를 호출할때 전달받을 문자를 담을 변수
    
//MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.yellowView == nil {
            
            self.yellowView = UIView(frame: self.view.bounds)
            
            self.yellowView.backgroundColor = .yellow
            
            self.view.addSubview(self.yellowView)

        
            self.yellowView.translatesAutoresizingMaskIntoConstraints = false
            
            self.view.topAnchor.constraint(equalTo: self.yellowView.topAnchor, constant: 0).isActive = true
            self.view.bottomAnchor.constraint(equalTo: self.yellowView.bottomAnchor, constant: 0).isActive = true
            self.view.leadingAnchor.constraint(equalTo: self.yellowView.leadingAnchor, constant: 0).isActive = true
            self.view.trailingAnchor.constraint(equalTo: self.yellowView.trailingAnchor, constant: 0).isActive = true
            
            self.view.bringSubviewToFront(button)       //버튼 맨 앞으로 보냄
            self.view.bringSubviewToFront(textField)    //텍스트 필드 맨앞으로 보냄
            self.view.bringSubviewToFront(label)        //라벨을 맨 앞으로 보냄
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.label.text = self.text  //텍스트를 라벨에 입력

        startIndicator()    //인디케이터 시작
    }
    
    
//MARK: - Initialization
    //페이지가 호출될때 라벨에 텍스트를 입력하기 위하여 값을 받아오는 메소드
    func setText(text: String?) {
        
        guard let textString = text else { return }
        
        self.text = textString
    }

//MARK: - Button Event
    @IBAction func buttonPressed(_ sender: Any) {

        print("Green ViewController Button Pressed")

        var text:String? = nil
        
        if textField.text!.count > 0 {
            text = textField.text
        }
        
        changePageView(index: 2, data: text)
    }
}
