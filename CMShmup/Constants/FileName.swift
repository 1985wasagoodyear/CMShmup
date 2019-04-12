//
//  FileName.swift
//  CMShmup
//
//  Created by K Y on 4/8/19.
//  Copyright © 2019 KY. All rights reserved.
//

import UIKit

enum FileName: String {
    case plane = "SuperHornet"
    case bullet = "bullet"
}

extension UIImage {
    convenience init?(fileName: FileName) {
        self.init(named: fileName.rawValue)
    }
    static func fileName(_ fileName: FileName) -> UIImage {
        guard let image = UIImage(fileName: fileName) else {
            preconditionFailure(ErrorThrow.fatalFileMissing(fileName.rawValue))
        }
        return image
    }
}
