//
//  BaseView.swift
//  BaseApplicationPractice
//
//  Created by Taesan Kim on 2021/09/07.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {

        super.init(frame: frame)

        self.viewWillApear()
    }

    required init?(coder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }

    //하위 뷰에서 오버라이딩 해서 호출
    func viewWillApear() {}

    //하위 뷰를 add 하는 메소드
    func setSubView(cellXibName: String) {

        if let view = UINib(nibName: cellXibName, bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView {

            view.frame = self.bounds    // *중요 하위 뷰 Frame에 bounce(현재 뷰 프레임) 적용

            self.addSubview(view)
        }
    }
    
    //Fragment 뷰(UIView)에 Constraint를 추가하는 메소드

    func setComponetViewOnContainer(componentView: UIView, containerView: UIView) {

        componentView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.topAnchor.constraint(equalTo: componentView.topAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: componentView.bottomAnchor, constant: 0).isActive = true
        containerView.leadingAnchor.constraint(equalTo: componentView.leadingAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: componentView.trailingAnchor, constant: 0).isActive = true
    }
}
