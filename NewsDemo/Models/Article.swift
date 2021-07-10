//
//  Article.swift
//  NewsDemo
//
//  Created by Anushree on 08/07/21.
//


import Foundation

struct ArticleList: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let title: String?
    let description: String?
    let url: String?
    let author: String?
    let publishedAt: String?
    let content: String?
}
