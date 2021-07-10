//
//  DetailNewsViewController.swift
//  NewsDemo
//
//  Created by Anushree on 08/07/21.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var input : ArticleViewModel?
   
    @IBOutlet var articelTitle: UILabel!
    @IBOutlet var Description: UILabel!
    @IBOutlet var Author: UILabel!
    @IBOutlet var publishDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
//        UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(shareTapped))
        articelTitle.text = input!.title
        Description.text = input!.description
        Author.text = "Author: \(input!.author)"
        publishDate.text = "Date: \(input!.publishedAt)"
    }
    
    private func getNews()->String{
        let news = input?.title ?? ""
        let authoDetail = "\n" + "Author: \(input!.author)" + "\n" + "Date: \(input!.publishedAt)"
        let desc =  "\n" + (input?.description ?? "")
        return news + authoDetail + desc
    }
    
    @IBAction func shareTapped(){
        let act = UIActivityViewController(activityItems: [getNews()], applicationActivities: [])
        act.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(act, animated: true) {
            //
        }
    }
}
