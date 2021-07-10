//
//  UIScrollView.swift
//  NewsDemo
//
//  Created by Anushree on 09/07/21.
//

import UIKit

public extension UIScrollView {
    func addRefreshControl(_ block:@escaping ()->()) {
        self.addSubview(RefreshControl().addRefreshControl(block))
    }
}
