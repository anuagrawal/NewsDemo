//
//  ArticleListViewController.swift
//  NewsDemo
//
//  Created by Anushree on 08/07/21.
//

import Foundation

struct ArticleListViewModel {
    let articles: [Article]
}

extension ArticleListViewModel {
    
    var numberOfSections: Int {1}
    func numberOfRowsInSection(_ section: Int) -> Int {self.articles.count}
    
    func articleAtIndex(_ index: Int) -> ArticleViewModel {
        let article = articles[index]
        return ArticleViewModel(article)
    }
    
}

struct ArticleViewModel {
    private let article: Article
}

extension ArticleViewModel {
    init(_ article: Article) {
        self.article = article
    }
}

extension ArticleViewModel {
    
    var title: String {
        return self.article.title ?? ""
    }
    var url: String {
        return self.article.url ?? ""
    }
    var description: String {
        return self.article.description ?? ""
    }
    var author: String {
        return self.article.author ?? ""
    }
    var publishedAt: String {
        return self.article.publishedAt ?? ""
    }
    var content: String {
        return self.article.content ?? ""
    }
    
}


