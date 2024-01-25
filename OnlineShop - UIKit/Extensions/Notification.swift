//
//  Notification.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 17.01.2024..
//

import Foundation
import UIKit

extension NSNotification {
    func getKeyboardHeightBegin() -> CGFloat {
        let userInfo: [AnyHashable : Any]? = self.userInfo
        
        if userInfo == nil {
            return 0
        }
        
        var keyboardFrame: CGRect = (userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = UIView().convert(keyboardFrame, from: nil)
        
        return keyboardFrame.size.height
    }
    
    func getKeyboardHeightEnd() -> CGFloat {
        let userInfo: [AnyHashable : Any]? = self.userInfo
        
        if userInfo == nil {
            return 0
        }
        
        var keyboardFrame: CGRect = (userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = UIView().convert(keyboardFrame, from: nil)
        
        return keyboardFrame.size.height
    }
}
