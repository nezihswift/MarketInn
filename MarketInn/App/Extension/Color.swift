//
//  Color.swift
//  MarketInn
//
//  Created by Nezih on 16.03.2023.
//

import Foundation
import UIKit

extension UIColor {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = UIColor(named: "AccentColor")
    let secondary = UIColor(named: "SecondaryColor")
    let text = UIColor(named: "TextColor")
    let grayTextColor = UIColor.systemGray
    let errorTextColor = UIColor.systemRed
    let clickableTextColor = UIColor.systemBlue
}
