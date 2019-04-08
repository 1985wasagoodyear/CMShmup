//
//  ViewController.swift
//  CMShmup
//
//  Created by K Y on 4/8/19.
//  Copyright © 2019 KY. All rights reserved.
//

import UIKit

class FlightViewController: UIViewController {

    // MARK: - Lifecycle Methods
    
    var planeView: PlaneView!
    var startButton: UIButton!
    
    override func loadView() {
        super.loadView()
        
        planeView = PlaneView()
        planeView.isHidden = true
        view.addSubview(planeView)
        
        view.backgroundColor = .white
        // todo: setup background
        
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
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
            
    // MARK: Custom Action Methods
    
    @objc private func startButtonAction() {
        // hide button
        startButton.isHidden = true
        showPlane()
    }
    
    private func showPlane() {
        planeView.center.x = view.center.x
        planeView.center.y = view.frame.height * 1.5
        planeView.isHidden = false
        UIView.animate(withDuration: 2.0, animations: {
            self.planeView.center = self.view.center
        }) { (completed) in
            if completed == true {
                print("Done")
            }
        }
    }


}

