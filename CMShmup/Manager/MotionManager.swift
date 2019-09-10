//
//  MotionManager.swift
//  CMShmup
//
//  Created by K Y on 4/8/19.
//  Copyright © 2019 KY. All rights reserved.
//

import Foundation
import CoreMotion

typealias PivotValue = (horizontal: Double, vertical: Double) // in pi-radians
typealias PivotHandler = (PivotValue) -> Void

final class MotionManager {
    private let motion = CMMotionManager()
    private let update: PivotHandler
    private var timer: Timer!
    
    init(interval: TimeInterval, _ handler: @escaping PivotHandler) {
        guard motion.isAccelerometerAvailable else {
            fatalError("accelerometer not found")
        }
        update = handler
        motion.deviceMotionUpdateInterval = interval
        motion.startDeviceMotionUpdates(to: .main) { (motion, _) in
            guard let attitude = motion?.attitude else { return }
            let change = (horizontal: attitude.roll,
                          vertical: attitude.pitch)
            self.update(change)
        }
    }
    
    deinit {
        motion.stopDeviceMotionUpdates()
    }
    
}

// MARK: - Unused, Old Implementation

extension MotionManager {
    static func getInitialPos(_ completion: @escaping PivotHandler) {
        let manager = CMMotionManager()
        manager.startDeviceMotionUpdates(to: .main) { (motion, _) in
            guard let attitude = motion?.attitude else { return }
            let change = (horizontal: attitude.roll,
                          vertical: attitude.pitch)
            completion(change)
            manager.stopDeviceMotionUpdates()
        }
    }
}

// MARK: - Unused, Old Implementation

/*

extension MotionManager {
    private static func getInitialPosOld(_ completion: @escaping PivotHandler) {
        let manager = CMMotionManager()
        manager.startDeviceMotionUpdates(to: .main) { (dat, _) in
            guard let data = dat else { return }
            let gravity = data.gravity
            let change = (horizontal: gravity.x, vertical: -gravity.y)
            completion(change)
            manager.stopDeviceMotionUpdates()
        }
    }
    
    private func oldGyroScope() {
        motion.startDeviceMotionUpdates(to: .main) { (dat, _) in
            guard let data = dat else { return }
            let gravity = data.gravity
            let change = (horizontal: gravity.x, vertical: -gravity.y)
            self.update(change)
        }
    }
    
    private func old2() {
        motion.deviceMotionUpdateInterval = 1.0/30.0 // 0.01
        
        motion.startGyroUpdates(to: OperationQueue.main) { (dat, _) in
            guard let data = dat else { return }
            let horizontalPivot = data.rotationRate.y
            let verticalPivot = data.rotationRate.x
            print("\(horizontalPivot), \(verticalPivot)")
            self.update((horizontal: horizontalPivot, vertical: verticalPivot))
        }
    }
}
*/

