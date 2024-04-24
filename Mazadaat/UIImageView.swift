//
//  UIImageView.swift
//
//  Created by abdullah tarek
//

import Kingfisher


extension UIImageView {
    func setWith(url: String? ,withLoder : Bool = true) {
        self.kf.indicatorType = withLoder ? .activity : .none
        if let newURL = ((url ?? "")).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            self.kf.setImage(with: URL(string: newURL), placeholder: UIImage(named: "def-icon"), options: [.transition(.fade(0.2))])
            return
        }
        self.kf.setImage(with: URL(string: (url ?? "")), placeholder: UIImage(named: "def-icon"), options: [.transition(.fade(0.2))])
    }
}
