//
//  MotionManager.swift
//  CMShmup
//
//  Created by K Y on 4/8/19.
//  Copyright © 2019 KY. All rights reserved.
//

import Foundation
import CoreMotion

typealias PivotValue = (horizontal: Double, vertical: Double)
typealias PivotHandler = (PivotValue) -> Void

final class MotionManager {
    private let motion = CMMotionManager()
    private let update: PivotHandler?
    
    init(_ handler: @escaping PivotHandler) {
        update = handler
        
        motion.deviceMotionUpdateInterval = 1.0/30.0 // 0.01
        motion.startDeviceMotionUpdates(to: .main) { (dat, _) in
            guard let data = dat else { return }
            let gravity = data.gravity
            let change = (horizontal: gravity.x, vertical: -gravity.y)
            self.update?(change)
        }
    }
    
}

// MARK: - Unused, Old Implementation

extension MotionManager {
    static func getInitialPos(_ completion: @escaping PivotHandler) {
        let manager = CMMotionManager()
        manager.startDeviceMotionUpdates(to: .main) { (dat, _) in
            guard let data = dat else { return }
            let gravity = data.gravity
            let change = (horizontal: gravity.x, vertical: -gravity.y)
            completion(change)
            manager.stopDeviceMotionUpdates()
        }
    }
}

// MARK: - Unused, Old Implementation

extension MotionManager {
    func oldGyroScope() {
        motion.gyroUpdateInterval = 1.0/30.0
        motion.startGyroUpdates(to: OperationQueue.main) { (dat, _) in
            guard let data = dat else { return }
            let horizontalPivot = data.rotationRate.y
            let verticalPivot = data.rotationRate.x
            self.update?((horizontal: horizontalPivot, vertical: verticalPivot))
        }
    }
}
