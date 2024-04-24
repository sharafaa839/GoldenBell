//
//  CollapsibleTableViewHeader.swift
//  ios-swift-collapsible-table-section
//
//  Created by Yong Su on 5/30/16.
//  Copyright © 2016 Yong Su. All rights reserved.
//

import UIKit

protocol CollapsibleTableViewHeaderDelegate {
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int)
}


class CollapsibleTableViewHeader: UITableViewHeaderFooterView {
    
    var delegate: CollapsibleTableViewHeaderDelegate?
     var section: Int = 0
    let titleLabel = UILabel()
    let arrowLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        // Content View
        contentView.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        
        let marginGuide = contentView.layoutMarginsGuide
        
        // Arrow label
        contentView.addSubview(arrowLabel)
        arrowLabel.textColor = UIColor.white
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowLabel.widthAnchor.constraint(equalToConstant: 12).isActive = true
        arrowLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        arrowLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        arrowLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        
        // Title label
        contentView.addSubview(titleLabel)
        titleLabel.textColor = UIColor.white

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        
        titleLabel.font = UIFont.systemFont(ofSize: 20,weight: .medium)

        
        //
        // Call tapHeader when tapping on this header
        //
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CollapsibleTableViewHeader.tapHeader(_:))))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
         guard let cell = gestureRecognizer.view as? CollapsibleTableViewHeader else {
             return
         }
         delegate?.toggleSection(self, section: cell.section)
     }
     
    func setCollapsed(_ collapsed: Bool) {
        //
        // Animate the arrow rotation (see Extensions.swf)
        //
        arrowLabel.rotate(collapsed ? 0.0 : .pi / 2)
    }
    
//    var delegate: CollapsibleTableViewHeaderDelegate?
//    var section: Int = 0
//
//    @IBOutlet weak var clickButton: UIButton!
//    @IBOutlet weak var arrowImg: UIImageView!
//    @IBOutlet weak var titlbl: UILabel!
//
//
//    @IBAction func TappedCell(_ sender: Any) {
//
//        print("XXX")
////        guard let cell = gestureRecognizer.view as? CollapsibleTableViewHeader else {
////            return
////        }
////
//
//        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CollapsibleTableViewHeader.tapHeader(_:))))
//
//        delegate?.toggleSection(self, section: self.section)
//    }
//
//    @objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
//        guard let cell = gestureRecognizer.view as? CollapsibleTableViewHeader else {
//            return
//        }
//
//        delegate?.toggleSection(self, section: cell.section)
//    }
//
//    func setCollapsned(_ collapsed: Bool) {
//        //
//        // Animate the arrow rotation (see Extensions.swf)
//        //
//
//        if collapsed {
//
////            arrowImg.image = #imageLiteral(resourceName: "iconfinder_icon-arrow-down-b_211614")
//
//        }else{
////            arrowImg.image = #imageLiteral(resourceName: "iconfinder_arrow_sans_up_103304")
//
//        }
//
////        arrowLabel.rotate(collapsed ? 0.0 : .pi / 2)
//    }
    
}


extension UIColor {
    
    convenience init(hex:Int, alpha:CGFloat = 1.0) {
        self.init(
            red:   CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8)  / 255.0,
            blue:  CGFloat((hex & 0x0000FF) >> 0)  / 255.0,
            alpha: alpha
        )
    }
    
}

extension UIView {

    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(animation, forKey: nil)
    }

}
