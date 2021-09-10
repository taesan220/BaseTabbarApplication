//
//  RedViewController.swift
//  CustomPageViewController
//
//  Created by Taesan Kim on 2021/09/07.
//

import UIKit

class RedViewController: BaseElementViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
        
    var text = "Hello World!"   //다른 페이지에서 이 뷰컨트롤러를 호출할때 전달받을 문자를 담을 변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.label.text = self.text  //텍스트를 라벨에 입력

        super.startIndicator()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            super.stopIndicator()
        }
    }

//MARK: - Initialization
    //페이지가 호출될때 라벨에 텍스트를 입력하기 위하여 값을 받아오는 메소드
    func setText(text: String?) {
        
        guard let textString = text else { return }
        
        self.text = textString
    }


//MARK: - Button Event
    @IBAction func buttonPressed(_ sender: Any) {
        
        print("Red ViewController Button Pressed")
       
        var text:String? = nil
        
        if textField.text!.count > 0 {
            text = textField.text
        }
        
        changePageView(index: 1, data: text)
    }
}
