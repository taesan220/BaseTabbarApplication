//
//  PeriodPickerViewController.swift
//  Gametrics
//
//  Created by sdev-mac on 2021/08/19.
//

import UIKit

protocol PeriodPickerViewControllerDelegate {
    func changedPeriodPickerDate(startDate: String, endDate: String)
}

class PeriodPickerViewController: BaseViewController {

    enum SelectDateState {  //날짜 버튼 선택 상태
        case statDate   //시작 일자
        case endDate    //종료 일자
    }
    var selectDateState: SelectDateState!
    
    var periodPickerViewControllerDelegate: PeriodPickerViewControllerDelegate!
    
    @IBOutlet weak var topViewHeightLayout: NSLayoutConstraint!
    
    @IBOutlet weak var dataPickerViewHeightLayout: NSLayoutConstraint!
    
    @IBOutlet weak var btnStartDate: UIButton!
    @IBOutlet weak var btnEndDate: UIButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var lbTitle: UILabel!
    
    var startDate: String!
    var endDate: String!
    
    func setDateString(startDate: String, endDate: String) {
        self.startDate = startDate
        self.endDate = endDate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lbTitle.text = "기간 설정"
        initView()
        
        if #available(iOS 13.4, *) {    //옛날 방식을 쓸것이므로 13.4이전버전은 설정 값 적용 해당 안됨
            
            //데이터 피커 스타일  -  옛날 방식 : .wheels, 최신방식 : .inline
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        datePicker.datePickerMode = .date   //날짜만 지정
        datePicker.locale = Locale(identifier: "ko-KR") //한국 시간 지정
        
        datePicker.tintColor = .black
        
        datePicker.addTarget(self, action: #selector(chengedDate), for: .valueChanged)

        selectStandardDate(dateState: .statDate)  //시작일자 버튼 선택으로 초기 값으로 지정
    }
    
    func initView() {
        let height = self.view.frame.height
        
        topViewHeightLayout.constant = height * 0.35
        dataPickerViewHeightLayout.constant = height * 0.65
        
        let startDateTitle = self.startDate.convertDateFormat(fromFormat: "yyyyMMdd", toFormat: "yyyy.MM.dd")
        let endDateTitle = self.endDate.convertDateFormat(fromFormat: "yyyyMMdd", toFormat: "yyyy.MM.dd")
        
        self.btnStartDate.setTitle(startDateTitle, for: .normal)
        self.btnEndDate.setTitle(endDateTitle, for: .normal)
        
        self.btnStartDate.setTitle(startDateTitle, for: .selected)
        self.btnEndDate.setTitle(endDateTitle, for: .selected)
    }
    
    //DatePicker 상태를 초기화 하는 메소드
    
    func selectStandardDate(dateState: SelectDateState) {
        
        self.selectDateState = dateState
        
        let selectButtonImage = UIImage(named: "main_btn_click")
        
        let unSelectButtonImage = UIImage(named: "main_btn")
        
        if dateState == .statDate {
            
            btnStartDate.setBackgroundImage(selectButtonImage, for: .normal)
            btnEndDate.setBackgroundImage(unSelectButtonImage, for: .normal)
            
            if let date = startDate.convertToDate(format: "yyyyMMdd") {
                
                self.datePicker.setDate(date, animated: false)
            }
            
        } else if dateState == .endDate {
            
            btnEndDate.setBackgroundImage(selectButtonImage, for: .normal)
            btnStartDate.setBackgroundImage(unSelectButtonImage, for: .normal)
            
            
            if let date = endDate.convertToDate(format: "yyyyMMdd") {
                self.datePicker.setDate(date, animated: false)
            }
        }
    }
    
    
    @objc func chengedDate( ) {
        print("Date changed")
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyyMMdd"
        let dateString = dateformatter.string(from: datePicker.date)
        
        let titledateString = dateString.convertDateFormat(fromFormat: "yyyyMMdd", toFormat: "yyyy.MM.dd")
        
        if selectDateState == .statDate {

            self.startDate = dateString

            self.btnStartDate.setTitle(titledateString, for: .normal)
            self.btnStartDate.setTitle(titledateString, for: .selected)
            
        } else if selectDateState == .endDate {
            self.endDate = dateString
            
            self.btnEndDate.setTitle(titledateString, for: .normal)
            self.btnEndDate.setTitle(titledateString, for: .selected)
        }
    }
    
//MARK: - Button
    @IBAction func startDateButtonPressed(_ sender: Any) {
     
        selectStandardDate(dateState: .statDate)
    }
    
    @IBAction func endDateButtonPressed(_ sender: Any) {
        
        selectStandardDate(dateState: .endDate)
    }
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        
        if !checkPossibilityChangePeriod() { //날짜 변경 가능 여부를 체크
            
            print("Fail to change period -- 기간 변경 실패")
            return
        }
        
        if periodPickerViewControllerDelegate == nil {
            print("periodPickerViewControllerDelegate = nil")
            return
        }
        
        periodPickerViewControllerDelegate.changedPeriodPickerDate(startDate: self.startDate, endDate: self.endDate)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //날짜 변경 가능 여부를 체크하는 메소드
    func checkPossibilityChangePeriod() -> Bool {
        
        var isAllowChangingPeriod = true
        
        var errorMessage = ""
        
        guard let startDate = self.startDate.convertToDate(format: "yyyyMMdd") else { return false }
        
        guard let endDate = self.endDate.convertToDate(format: "yyyyMMdd") else { return false }
        
        if startDate.compare(endDate) == .orderedDescending {
            
            errorMessage = "시작일자는 종료일자 이전이어야 합니다."
            
            isAllowChangingPeriod = false
        }
        
        if endDate.compare(Date()) == .orderedDescending {
            errorMessage = "종료일자는 오늘 이전이어야 합니다."
            isAllowChangingPeriod = false
        }
        
        if isAllowChangingPeriod {
            //회원 등급에 따른 날짜 변경 가능 여부 체크
            
            var maxSearchDay = 0    //검색일 변수
            var maxPeriod = 0       //최대 검색 기간 변수
                        
//            switch LoginResultModel.shared.gradeCode {
//            case "01":  //골드
//
//                maxSearchDay = 31 * 3; // 3개월
//                maxPeriod = 31 * 36; // 36개월
//                break
//
//            case "02":  //실버
//
//                maxSearchDay = 31; // 1개월
//                maxPeriod = 31 * 18; // 18개월
//                break
//
//            case "03":  //라이트
//
//                maxSearchDay = 31; // 1개월
//                maxPeriod = 31 * 3; // 3개월
//                break
//            default:
//
//                errorMessage = "검색 날짜를 변경하기 위해서는 로그인을 완료 해야 합니다."
//                isAllowChangingPeriod = false
//
//                print("등급이 이안에 포함되지 않는 경우 비회원으로 간주, 에러메시지 리턴")
//            }
            
//            //최대 검색 기간 제한
//            let periodBetweenStartDateAndEndDate =  self.startDate.convertToDate(format: "yyyyMMdd")?.compareDaysBetween(toDate: self.endDate.convertToDate(format: "yyyyMMdd")!, isAbsolute: true, isEncludeToday: false) ?? 9999
//
//            if maxSearchDay < periodBetweenStartDateAndEndDate {
//
//                errorMessage = "\(LoginResultModel.shared.gradeName) 등급 최대검색기간은 \(maxSearchDay)일 입니다."
//                isAllowChangingPeriod = false
//
//            }
//
//            //최대 검색날짜 제한
//            let periodFromCurrentDate = Date().compareDaysBetween(toDate: self.endDate.convertToDate(format: "yyyyMMdd")!, isAbsolute: true, isEncludeToday: false)
//
//
//            //%@등급 최대검색일자는 %@ ~ %@입니다.
//
//            if periodFromCurrentDate > maxPeriod {
//
//                let maxSearchDateString = Date().getTimeBeforeDays(days: maxSearchDay, dateFormat: "yyyy-MM-dd")
//
//                let currentDate = Date().convertDateToString(format: "yyyy-MM-dd")
//
//
//                errorMessage = "\(LoginResultModel.shared.gradeName) 등급 최대검색일자는 \(maxSearchDateString!) ~ \(currentDate!) 입니다."
//                isAllowChangingPeriod = false
//
//            }
        }
        
        
        if !isAllowChangingPeriod {     //날짜 변경에 승인되지 않았을 경우 에러 메시지 팝업
            
  //          let alert = Alert.shared.createAlert(title: "알림", message: errorMessage, completion: {})
           
//            DispatchQueue.main.async {
//                self.present(alert, animated: true, completion: nil)
//            }
            
        }

        
        return isAllowChangingPeriod
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
                
        self.dismiss(animated: true, completion: nil)

    }
}
