//
//  ViewController.swift
//  NewsDemo
//
//  Created by Anushree on 08/07/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var radioUS: UIButton!
    @IBOutlet weak var radioCanada: UIButton!
    var conutryCode = String()
    
    var countries = ["us","ca"]
    
    @IBAction func btnRadioTapped(_ sender: UIButton) {
        radioUS.setImage(#imageLiteral(resourceName: "Unchecked"), for: .normal)
        radioCanada.setImage(#imageLiteral(resourceName: "Unchecked"), for: .normal)
        if sender.currentImage == #imageLiteral(resourceName: "Unchecked"){
            if sender.tag == 1 {
                conutryCode = "us"
            }else{
                conutryCode = "ca"
            }
            sender.setImage(#imageLiteral(resourceName: "Checked"), for: .normal)
        }else{
            sender.setImage(#imageLiteral(resourceName: "Unchecked"), for: .normal)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! NewsListTableViewController
        //  let articleVM = self.articleListVM.articleAtIndex(index ?? 0)
        vc.selectedCountryCode = conutryCode
    }
    override func viewDidLoad() {
        radioUS.setImage(#imageLiteral(resourceName: "Unchecked"), for: .normal)
        radioCanada.setImage(#imageLiteral(resourceName: "Unchecked"), for: .normal)
    }
    
}
