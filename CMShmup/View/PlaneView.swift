//
//  PlaneView.swift
//  CMShmup
//
//  Created by K Y on 4/8/19.
//  Copyright © 2019 KY. All rights reserved.
//

import UIKit

final class PlaneView: UIView {
    
    private var image: UIImage! {
        didSet {
            // create and setup ImageView
            let imageFrame = CGRect(origin: .zero, size: image.size)
            imageView = UIImageView(image: image)
            imageView.frame = imageFrame
        }
    }
    private var imageView: UIImageView! {
        didSet {
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(imageView)
            NSLayoutConstraint.activate([
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                imageView.topAnchor.constraint(equalTo: topAnchor),
                imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
                ])
        }
    }
    
    init() {
        super.init(frame: CGRect(origin: .zero, size: .zero))
        commonInit()
    }
    /*
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        // create plane image
        image = UIImage(fileName: .plane)
        
        // set up rest of view
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin,
                            .flexibleTopMargin, .flexibleBottomMargin]
    }

}
