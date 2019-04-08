//
//  ErrorThrow.swift
//  CMShmup
//
//  Created by K Y on 4/8/19.
//  Copyright © 2019 KY. All rights reserved.
//

import Foundation

struct ErrorThrow {
    private init() { }
    
    static func fatalFileMissing(_ fileName: String) -> String {
        return "Fatal: File \(fileName) could not be found!"
    }
}
