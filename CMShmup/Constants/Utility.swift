//
//  Utility.swift
//  CMShmup
//
//  Created by K Y on 4/11/19.
//  Copyright © 2019 KY. All rights reserved.
//

import UIKit

extension CGFloat {
    static func +(left: CGFloat, right: Double) -> CGFloat {
        return left + CGFloat(right)
    }
    static func *(left: CGFloat, right: Double) -> CGFloat {
        return left * CGFloat(right)
    }
    var half: CGFloat {
        return self / 2.0
    }
    var double: CGFloat {
        return self * 2.0
    }
}
