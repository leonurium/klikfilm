//
//  KFImageBlurView.swift
//  klikfilm
//
//  Created by Rangga Leo on 06/01/21.
//

import UIKit
import Kingfisher

class KFImageBlurView: UIImageView {
    private var gradientView: UIView? {
        didSet {
            gradientView?.backgroundColor = .clear
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        contentMode = .scaleAspectFill
        gradientView = UIView()
//        gradientView?.gradient(colors: [UIColor.red.cgColor, UIColor.red.cgColor])
        gradientView?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        guard let gradient = gradientView else { return }
        addSubview(gradient)
        let screen = UIScreen.main.bounds
        gradient.center = center
        gradient.frame = CGRect(x: frame.minX, y: frame.midY, width: screen.width, height: frame.height/2)

        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = CGRect(x: frame.minX, y: frame.minY, width: screen.width, height: frame.height)
        addSubview(blurEffectView)
    }
}

extension UIView {
    func gradient(colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        
        layer.addSublayer(gradientLayer)
    }
}
