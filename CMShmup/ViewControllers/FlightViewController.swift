//
//  ViewController.swift
//  CMShmup
//
//  Created by K Y on 4/8/19.
//  Copyright © 2019 KY. All rights reserved.
//

import UIKit


class FlightViewController: UIViewController {

    // MARK: - View Properties
    
    var planeView: PlaneView!
    lazy var startButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0.0, y: 0.0,
                                             width: 300.0, height: 100.0))
        btn.setTitle("START", for: .normal)
        btn.setTitleColor(btn.tintColor, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(btn)
        let buttonConstraints = [
            btn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btn.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(buttonConstraints)
        return btn
    }()
    
    // MARK: - Movement & Location Properties
    
    var motion: MotionManager!
    var initialPos: PivotValue!
    var fire: Timer!
    
    lazy var maxBounds: MovementBounds = {
        let escapeArea = GlobalParams.relativeMaxEscapeArea
        let viewSize = view.frame.size
        let planeSize = planeView.frame.size
        return MovementBounds(minX: 0,
                              maxX: viewSize.width,
                              minY: 0,
                              maxY: viewSize.height)
        /*
        return MovementBounds(minX: -(planeSize.width * escapeArea),
                              maxX: viewSize.width + (planeSize.width * escapeArea),
                              minY: -(planeSize.height * escapeArea),
                              maxY: viewSize.height + (planeSize.height * escapeArea))*/
    }()
    
    // MARK: - Lifecycle Methods
    
    override func loadView() {
        super.loadView()
        
        setupPlaneView()
        setupStartButton()
        
        // todo: setup background
        //
        //
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Touches Behavior
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        startFiring()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        stopFiring()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        stopFiring()
    }
    
}

// MARK: - Setup & Start Methods
extension FlightViewController {
    
    @objc private func startButtonAction() {
        // hide button
        startButton.isHidden = true
        showPlane()
    }
    
    private func setupPlaneView() {
        planeView = PlaneView()
        planeView.isHidden = true
        view.addSubview(planeView)
    }
    
    private func setupStartButton() {
        startButton.addTarget(self,
                              action: #selector(startButtonAction),
                              for: .touchUpInside)
    }
    
    private func setupMotion() {
        MotionManager.getInitialPos({ (first) in
            self.initialPos = first
            self.motion = MotionManager(interval: GlobalParams.updateInterval) { (pivot) in
                // print("x: \(pivot.horizontal) y: \(pivot.vertical)")
                self.movePlane(with: pivot)
            }
        })
    
    }
    
    private func showPlane() {
        planeView.center.x = view.center.x
        planeView.center.y = view.frame.height * GlobalParams.relativeStartingPos
        planeView.isHidden = false
        UIView.animate(withDuration: GlobalParams.entrySpeed, animations: {
            self.planeView.center = self.view.center
        }) { (completed) in
            if completed == true {
                self.setupMotion()
            }
        }
    }

}

// MARK: - Movement & Action Methods
extension FlightViewController {
    
    private func startFiring() {
        fire = Timer.scheduledTimer(withTimeInterval: 1.0,
                                    repeats: true,
                                    block: { (_) in
            print("boom")
        })
    }
    
    private func stopFiring() {
        fire.invalidate()
        fire = nil
    }
    
    // pivot - in pi-radians
    // should check if it fits within -pi...pi, where 0 is straight-up
    // TODO - ensure it fits within the range
    //        if it does, normalize it within range
    //        if not, bound to maximum range
    // need to determine max-tolerable angles to tilt, doesn't always fit in -pi...pi
    private func movePlane(with pivot: PivotValue) {
        let center = planeView.center
        
        var newXPos = center.x + ((pivot.horizontal - initialPos.horizontal) * GlobalParams.movement)
        var newYPos = center.y + ((pivot.vertical - initialPos.vertical) * GlobalParams.movement)
        if newXPos > maxBounds.maxX {
            newXPos = maxBounds.maxX
        }
        else if newXPos < maxBounds.minX {
            newXPos = maxBounds.minX
        }
        if newYPos > maxBounds.maxY {
            newYPos = maxBounds.maxY
        }
        else if newYPos < maxBounds.minY {
            newYPos = maxBounds.minY
        }
        
        self.planeView.center.x = newXPos
        self.planeView.center.y = newYPos
    }
    
}
