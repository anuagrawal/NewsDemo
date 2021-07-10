//
//  NewsListTableViewController.swift
//  NewsDemo
//
//  Created by Anushree on 08/07/21.
//

import Foundation
import UIKit
import Firebase
class NewsListTableViewController: UITableViewController {
    
    private var articleListVM: ArticleListViewModel!
    @IBOutlet var articleTableView: UITableView!
    let dropDownIcon = "\u{25BC}"

    var selectedCountryCode : String?
    var index:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
          AnalyticsParameterItemID: "id-\(title ?? "")",
          AnalyticsParameterItemName: title ?? "",
          AnalyticsParameterContentType: "cont",
        ])
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:rightBarTitle, style: .done, target: self, action: #selector(openCountrySelection))

        weak var weakSelf = self
        title = AppUserDefault.shared.countryName()
        articleTableView.addRefreshControl {
            weakSelf?.getNewsDetailFromServer()
        }
        getNewsDetailFromServer()
    }
    
    var rightBarTitle:String{
        if let countryCode = AppUserDefault.shared.countryCode() {
            return countryCode.uppercased() + dropDownIcon
        }
        return dropDownIcon
    }
    
    
    @IBAction func pullToRefreshAction(refreshControl: UIRefreshControl) {
        getNewsDetailFromServer()
    }
    
    private func getNewsDetailFromServer() {
        if let countryCode = AppUserDefault.shared.countryCode(){
            selectedCountryCode = countryCode
            if  NetworkReachability.shared.isConnected {
              loadNewsForCountryCode(countryCode: selectedCountryCode!)
              }else{
                  showAlert(title: "Alert", message: "Internet Connection not Available!")
              }
            
        }else{
            openCountrySelection()
        }
        title = AppUserDefault.shared.countryName()
    }
    
    
    private func loadNewsForCountryCode(countryCode:String){
        weak var weakSelf = self
        Webservice.shared.newsListRequest(with: Webservice.shared.newsUrl(countryCode: countryCode), ofType: ArticleList.self) { (response) in
            if let articles = response?.articles {
                weakSelf?.articleListVM = ArticleListViewModel(articles: articles)
                DispatchQueue.main.async {
                    weakSelf?.tableView.reloadData()
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.articleListVM == nil ? 0 : self.articleListVM.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("ArticleTableViewCell not found!")
        }
        let articleVM = self.articleListVM.articleAtIndex(indexPath.row)
        cell.configure(for: articleVM)
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        if index != nil {
            performSegue(withIdentifier: detailSegue, sender: self)
        } else {
            print("index nil")
            return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailViewController
        let articleVM = self.articleListVM.articleAtIndex(index ?? 0)
        vc.input = articleVM
    }
    
    
    @IBAction func openCountrySelection(){
        let ac = UIAlertController(title: "Country Selector", message: "Please choose county of your choice to get the news", preferredStyle: .actionSheet)
        let canada = UIAlertAction(title: "Canada", style: .default, handler: reloadPage)
        let usa = UIAlertAction(title: "USA", style: .default, handler: reloadPage)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        ac.addAction(canada)
        ac.addAction(usa)
        ac.addAction(cancel)
        present(ac, animated: true) {
            //
        }
    }
    
    func reloadPage(actionAlert: UIAlertAction){
        if actionAlert.title == "Canada"{
            selectedCountryCode = "ca"
        }else if actionAlert.title == "USA" {
            selectedCountryCode = "us"
        }else{
            showAlert(title: "Select Country", message: "Please select country.")
        }
        AppUserDefault.shared.setCountryCode(countryCode: selectedCountryCode!)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: rightBarTitle, style: .done, target: self, action: #selector(openCountrySelection))
        let title = (actionAlert.title ?? "") + " News"
        AppUserDefault.shared.setCountryName(countryName: title)
        getNewsDetailFromServer()
    }
    
}
