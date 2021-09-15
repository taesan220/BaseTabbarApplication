//
//  String_Extension.swift
//  Gametrics
//
//  Created by sdev-mac on 2021/08/18.
//

import Foundation
import UIKit

extension String {
 
    func urlEncode() -> String? { return self.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[]{} ").inverted) }

    func urlDecode() -> String? { return self.removingPercentEncoding }
    
    /**
     String 형태의 Date 값을 Date형으로 변환하는 메소드
     */
    func convertToDate(format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        let date = dateFormatter.date(from: self)
        
        return date
    }
    
    //Date String의 Format을 변경하는 메소드
    func convertDateFormat(fromFormat: String, toFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        
        guard let date = dateFormatter.date(from: self) else { return nil }
        
        dateFormatter.dateFormat = toFormat
        
        return dateFormatter.string(from: date)
    }
    
    //특정 문자의 Text Color을 변경하는 메소드
    //Label에 적용시키기 위해서는 attributedText를 사용해야함
    func setAttributeColor(color: UIColor, forText stringValues: [String], baseColor: UIColor = .black) -> NSMutableAttributedString? {
        
        let attributeString: NSAttributedString = NSAttributedString(string: self)
        let attributeMutableString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attributeString)
        let allRange = (self as NSString).range(of: self)
        
        attributeMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: baseColor.cgColor, range: allRange)
        
        //반복문으로 특정 문자들의 색을 변경
        for stringValue in stringValues {
            let range = (self as NSString).range(of: stringValue)
        
            if range.length > 0 {
                attributeMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range);
            }
        }
                       
        return attributeMutableString
    }
}

