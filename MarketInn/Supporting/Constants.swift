//
//  Constants.swift
//  MarketInn
//
//  Created by Nezih on 16.03.2023.
//

import Foundation
import UIKit

class Constants {
    struct CornerRadius {
        static let main : CGFloat = 5
        static let buttonWithTen : CGFloat = 10
    }
    
    struct Paddings {
        static let five : CGFloat = 5
        static let ten : CGFloat = 10
        static let fifteen : CGFloat = 15
        static let thirty : CGFloat = 30
        static let fifty : CGFloat = 50
    }
    
    struct Fonts {
        static let text = UIFont.systemFont(ofSize: 16)
        static let boldText = UIFont.boldSystemFont(ofSize: 16)
        static let italicText = UIFont.italicSystemFont(ofSize: 16)
        static let smallItalicText = UIFont.italicSystemFont(ofSize: 12)
        static let smallText = UIFont.systemFont(ofSize: 12)
        static let midSmallText = UIFont.systemFont(ofSize: 14)
        static let title = UIFont.systemFont(ofSize: 20, weight: .medium)
    }
}
