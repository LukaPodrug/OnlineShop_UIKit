//
//  View.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 23.01.2024..
//

import Foundation
import UIKit

extension UIView {
    func onViewPressAnimation() {
        UIView.transition(
            with: self,
            duration: 0.0,
            options: .transitionCrossDissolve,
            animations: { self.alpha = 0.5 },
            completion: { _ in self.onViewPressAnimationEnd() }
        )
    }
    
    func onViewPressAnimationEnd() {
        UIView.transition(
            with: self,
            duration: 0.2,
            options: .transitionCrossDissolve,
            animations: { self.alpha = 1 },
            completion: nil
        )
    }
}
