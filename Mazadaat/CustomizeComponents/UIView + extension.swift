//
//  UIView + extension.swift
//  Iris
//
//  Created by mahmoudhajar on 2/5/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit

enum AIEdge: Int {
    case
        Top,
        Left,
        Bottom,
        Right,
        Top_Left,
        Top_Right,
        Bottom_Left,
        Bottom_Right,
        All,
        None
}

extension UIView {
    // MRK:- Layer
    func coloringboder(color: UIColor) {
        layer.borderColor = color.cgColor
    }

    func addActionn(vc: UIViewController, action: Selector) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: vc, action: action)
        isUserInteractionEnabled = true
        addGestureRecognizer(tapGestureRecognizer)
    }

    func setRoundCorners(_ radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }

    func floatView(raduis: CGFloat, color: UIColor) {
        layer.cornerRadius = raduis
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 4
        layer.shadowColor = color.cgColor

        layer.borderWidth = 0
    }

    func pinEdges(to other: UIView) {
        leadingAnchor.constraint(equalTo: other.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: other.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: other.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: other.bottomAnchor).isActive = true
    }

    func prepareView(vcView: UIView, width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        vcView.addSubview(self)
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: vcView.centerXAnchor),
            centerYAnchor.constraint(equalTo: vcView.centerYAnchor),
            heightAnchor.constraint(equalToConstant: height),
            widthAnchor.constraint(equalToConstant: width),
        ])
    }

    func applyShadowWithCornerRadius(color: UIColor, opacity: Float, radius: CGFloat, edge: AIEdge, shadowSpace: CGFloat, cornerRadius: CGFloat) {
        var sizeOffset: CGSize = CGSize.zero

        switch edge {
        case .Top:
            sizeOffset = CGSize(width: 0, height: -shadowSpace)
        case .Left:
            sizeOffset = CGSize(width: -shadowSpace, height: 0)
        case .Bottom:
            sizeOffset = CGSize(width: 0, height: shadowSpace)
        case .Right:
            sizeOffset = CGSize(width: shadowSpace, height: 0)

        case .Top_Left:
            sizeOffset = CGSize(width: -shadowSpace, height: -shadowSpace)
        case .Top_Right:
            sizeOffset = CGSize(width: shadowSpace, height: -shadowSpace)
        case .Bottom_Left:
            sizeOffset = CGSize(width: -shadowSpace, height: shadowSpace)
        case .Bottom_Right:
            sizeOffset = CGSize(width: shadowSpace, height: shadowSpace)

        case .All:
            sizeOffset = CGSize(width: 0, height: 0)
        case .None:
            sizeOffset = CGSize.zero
        }

        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true

        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = sizeOffset
        layer.shadowRadius = radius
        layer.masksToBounds = false

        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }

    func roundSingleConrner(_ corners: UIRectCorner, _ cormerMask: CACornerMask, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            self.clipsToBounds = false
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = cormerMask
        } else {
            let rectShape = CAShapeLayer()
            rectShape.bounds = frame
            rectShape.position = center
            rectShape.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
            layer.mask = rectShape
        }
    }

    func appStoreView() {
        layer.cornerRadius = 20.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 12.0
        layer.shadowOpacity = 0.7
        layer.masksToBounds = false
    }

    func floating(raduis: CGFloat, color: CGColor = UIColor.clear.cgColor) {
        layer.cornerRadius = raduis
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowOpacity = 0.6
        layer.shadowRadius = 4
        layer.borderWidth = 0.8
        layer.borderColor = color

        // self.layer.masksToBounds = true
    }

    func setBottomRoundedEdge(desiredCurve: CGFloat?) {
        let offset: CGFloat = frame.width / desiredCurve!
        let bounds: CGRect = self.bounds

        let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height / 2)
        let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
        let ovalBounds: CGRect = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
        let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)

        // Create the shape layer and set its path
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath

        // Set the newly created shape layer as the mask for the view's layer
        layer.mask = maskLayer
    }

    // MARK: - Animations

    func fadeIn(duration: TimeInterval = 0.5,
                delay: TimeInterval = 1,
                completion: @escaping ((Bool) -> Void) = { (_: Bool) in }) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: .curveEaseIn,
                       animations: {
                           self.alpha = 1.0
                       }, completion: completion)
    }

    func fadeOut(duration: TimeInterval = 0.5,
                 delay: TimeInterval = 0.0,
                 completion: @escaping (Bool) -> Void = { (_: Bool) in }) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: .curveEaseIn,
                       animations: {
                           self.alpha = 0.0
                       }, completion: completion)
    }

    func fadeIn1(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = { (_: Bool) in }) {
        alpha = 0.0

        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.isHidden = false
            self.alpha = 1.0
        }, completion: completion)
    }

    func fadeOut1(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = { (_: Bool) in }) {
        alpha = 1.0

        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.isHidden = true
            self.alpha = 0.0
        }, completion: completion)
    }

//      func showView(objView:UIView){
//
//          objView.alpha = 0.0
//          UIView.animate(withDuration: 0.5, animations: {
//              objView.alpha = 0.0
//          }, completion: { (completeFadein: Bool) -> Void in
//              objView.alpha = 1.0
//              let transition = CATransition()
//              transition.duration = 0.5
//            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//            transition.type = CATransitionType.fade
//              objView.layer.add(transition, forKey: nil)
//          })
//      }
//
//      func HideView(objView:UIView){
//
//          UIView.animate(withDuration: 0.5, animations: {
//              objView.alpha = 1.0
//          }, completion: { (completeFadein: Bool) -> Void in
//              objView.alpha = 0.0
//              let transition = CATransition()
//              transition.duration = 0.5
//            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//            transition.type = CATransitionType.fade
//              objView.layer.add(transition, forKey: nil)
//          })
//      }
//
//    func shakeF() {
//               let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
//               animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
//               animation.duration = 0.6
//               animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
//               layer.add(animation, forKey: "shake")
//           }
//

    // MARK: - Colors

    static var nib: UINib {
        return UINib(nibName: "\(self)", bundle: nil)
    }

    static var identifier: String {
        return String(describing: self)
    }

    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)

        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)

        layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}

extension UIView {
    func applyDropShadow(withOffset offset: CGSize,
                         opacity: Float,
                         radius: CGFloat,
                         color: UIColor) {
        layer.applyDropShadow(withOffset: offset,
                              opacity: opacity,
                              radius: radius,
                              color: color)
    }

    func removeDropShadow() {
        layer.removeDropShadow()
    }
}

extension CALayer {
    func applyDropShadow(withOffset offset: CGSize,
                         opacity: Float,
                         radius: CGFloat,
                         color: UIColor) {
        shadowOffset = offset
        shadowOpacity = opacity
        shadowRadius = radius
        shadowColor = color.cgColor
        shouldRasterize = true
        rasterizationScale = UIScreen.main.scale
    }

    func removeDropShadow() {
        shadowOffset = .zero
        shadowOpacity = 0
        shadowRadius = 0
        shadowColor = UIColor.clear.cgColor
        shouldRasterize = false
    }
}
