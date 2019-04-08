//
//  PlaneView.swift
//  CMShmup
//
//  Created by K Y on 4/8/19.
//  Copyright © 2019 KY. All rights reserved.
//

import UIKit

final class PlaneView: UIView {
    
    private var image: UIImage!
    private var imageView: UIImageView!
    
    init() {
        let frame = CGRect(origin: .zero, size: .zero)
        super.init(frame: frame)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        // create plane image
        image = UIImage(fileName: .plane)
        
        // create and setup ImageView
        let imageFrame = CGRect(origin: .zero, size: image.size)
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        imageView.frame = imageFrame
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        let imageConstraints = [
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(imageConstraints)
        
        // set up rest of view
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
    }

}
