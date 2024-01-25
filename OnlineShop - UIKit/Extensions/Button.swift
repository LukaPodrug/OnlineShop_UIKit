//
//  Button.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 17.01.2024..
//

import Foundation
import UIKit

extension UIButton {
    func onButtonPressAnimation() {
        UIView.transition(
            with: self,
            duration: 0.0,
            options: .transitionCrossDissolve,
            animations: { self.alpha = 0.5 },
            completion: { _ in self.onButtonPressAnimationEnd() }
        )
    }
    
    func onButtonPressAnimationEnd() {
        UIView.transition(
            with: self,
            duration: 0.2,
            options: .transitionCrossDissolve,
            animations: { self.alpha = 1 },
            completion: nil
        )
    }
    
    func updateBackgroundColor(backgroundColor: UIColor) {
        UIView.transition(
            with: self,
            duration: 0.2,
            options: .transitionCrossDissolve,
            animations: { self.backgroundColor = backgroundColor },
            completion: nil
        )
    }
    
    func updateTintColor(tintColor: UIColor) {
        UIView.transition(
            with: self,
            duration: 0.2,
            options: .transitionCrossDissolve,
            animations: { self.tintColor = tintColor },
            completion: nil
        )
    }
}
