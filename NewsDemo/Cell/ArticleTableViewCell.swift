//
//  ArticleTableViewCell.swift
//  NewsDemo
//
//  Created by Anushree on 08/07/21.
//

import Foundation
import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(for vm: ArticleViewModel) {
        self.titleLabel.text = vm.title
        self.descriptionLabel.text = vm.description
    }
}
