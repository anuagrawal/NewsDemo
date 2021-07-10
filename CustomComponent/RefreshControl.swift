//
//  RefreshControl.swift
//  NewsDemo
//
//  Created by Anushree on 09/07/21.
//

import UIKit

public class RefreshControl: UIRefreshControl {
    var action : (()->())?
    func addRefreshControl(_ block:@escaping ()->()) -> UIRefreshControl {
        action = block
        self.tintColor = .red
        self.addTarget(self, action: #selector(loadRefreshing), for: .valueChanged)
        return self
    }
    
    @IBAction func loadRefreshing() {
        action!()
        self.endRefreshing()
    }
}
