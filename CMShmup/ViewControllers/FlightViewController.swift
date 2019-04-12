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
    var startButton: UIButton!
    
    // MARK: - Movement & Location Properties
    var motion: MotionManager!
    var initialPos: PivotValue!
    var maxBounds: MovementBounds!
    
    // MARK: - Lifecycle Methods
    
    override func loadView() {
        super.loadView()
        
        planeView = PlaneView()
        planeView.isHidden = true
        view.addSubview(planeView)
        
        view.backgroundColor = .white
        
        // todo: setup background
        //
        //
        
        startButton = UIButton(frame: CGRect(x: 0.0, y: 0.0,
                                             width: 300.0, height: 100.0))
        startButton.setTitle("START", for: .normal)
        startButton.setTitleColor(startButton.tintColor, for: .normal)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startButton)
        let buttonConstraints = [
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(buttonConstraints)
        startButton.addTarget(self,
                              action: #selector(startButtonAction),
                              for: .touchUpInside)
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
    
    private func setupMotion() {
        MotionManager.getInitialPos({ (first) in
            self.initialPos = first
            self.motion = MotionManager({ (pivot) in
                // print("x: \(pivot.horizontal) y: \(pivot.vertical)")
                self.movePlane(with: pivot)
            })
        })
    }
    
    private func showPlane() {
        planeView.center.x = view.center.x
        planeView.center.y = view.frame.height * GlobalParams.relativeStartingPos
        maxBounds = MovementBounds(minX: (-planeView.frame.size.width / 2.0) * GlobalParams.relativeMaxEscapeArea,
                                   maxX: (view.frame.size.width + (planeView.frame.size.width / 2.0)) * GlobalParams.relativeMaxEscapeArea,
                                   minY: (-planeView.frame.size.width / 2.0) * GlobalParams.relativeMaxEscapeArea,
                                   maxY: (view.frame.size.width + (planeView.frame.size.width / 2.0)) * GlobalParams.relativeMaxEscapeArea)
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
        // todo
    }
    private func stopFiring() {
        // todo
    }
    
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
        else if newYPos > maxBounds.maxY {
            newYPos = maxBounds.maxY
        }
        else if newYPos < maxBounds.minY {
            newYPos = maxBounds.minY
        }
        
        self.planeView.center.x = newXPos
        self.planeView.center.y = newYPos
    }
}
