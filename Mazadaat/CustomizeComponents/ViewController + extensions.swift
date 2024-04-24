//
//  NaviagtionController + extensions.swift
//  Zi Elengaz
//
//  Created by mahmoudhajar on 4/18/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import Foundation
import UIKit
import AVKit
class AppUtilities {
    static func changeRoot(root:UIViewController, animated:Bool = true, completion: (() -> Void)? = nil )  {
        let coordinator = (UIApplication.shared.delegate as! AppDelegate).coordinator
        guard animated else {
            coordinator.setRoot(root)
            return
        }
        
        UIView.transition(with: coordinator.window, duration: 0.7, options: .transitionCrossDissolve, animations: {
            let oldState: Bool = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            coordinator.setRoot(root)
            UIView.setAnimationsEnabled(oldState)
        }, completion: { (finished: Bool) -> () in
            if (completion != nil) {
                completion!()
            }
        })
    }
}


extension UIViewController {
    
    func popToView(ofClass: AnyClass, animated: Bool = true) {
        if let vc = navigationController?.viewControllers.last(where: { $0.isKind(of: ofClass) }) {
            navigationController?.popToViewController(vc, animated: animated)
        }
    }
    
    func hideNavigationShadow() {
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    func setRoot(_ viewController: UIViewController, withNavigation: Bool = false, animated: Bool = true) {
        let controller: UIViewController
        if withNavigation {
            controller = UINavigationController(rootViewController: viewController)
        } else {
            controller = viewController
        }
        AppUtilities.changeRoot(root: controller, animated: animated)
    }
    
//        func setRoot(_ viewController: UIViewController, withNavigation: Bool = false, animated: Bool = true) {
//            let controller: UIViewController
//            if withNavigation {
//                controller = UINavigationController(rootViewController: viewController)
//            } else {
//                controller = viewController
//            }
//            AppUtilities.changeRoot(root: controller, animated: animated)
//        }
//    
    
    func hideNavigationBar(){
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    func showNavigationBar() {
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
     func setTranslucentForNavigation() {
         let navigationBar = self.navigationController?.navigationBar
         navigationBar?.setBackgroundImage(UIImage(), for: .default)
         navigationBar?.shadowImage = UIImage()
         navigationBar?.isTranslucent = true
       }
    
    
    func setImageForNavigation (img: UIImage) { self.navigationController?.navigationBar.setBackgroundImage(img.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
    }
    
}
extension UIImageView {
    func downlodImage(str:String){
        guard let url = URL(string: str) else {return}
print(url)
    DispatchQueue.global().async {
        let data = try? Data(contentsOf: url)
        print(data)//make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        DispatchQueue.main.async {
            return  self.image = UIImage(data: data ?? Data())
        }
    }
    }
}



