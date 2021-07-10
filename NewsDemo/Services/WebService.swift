//
//  WebService.swift
//  NewsDemo
//
//  Created by Anushree on 08/07/21.
//

import Foundation

class Webservice {
    
    /// Singleton Webservice
    public class var shared : Webservice {
        struct Static {
            static let instance = Webservice()
        }
        return Static.instance
    }
    
    private init() {}
    
    
    /// pass url and type of expected response
    func newsListRequest<T:Decodable & Encodable>(with url: URL,ofType:T.Type, success: @escaping (T?) -> (),failure: ((String) -> Swift.Void)? = nil){
        requestToServer(with: url) { (responseData, httpUrlResponse, error) in
            if(error == nil && responseData != nil && responseData?.count != 0){
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: responseData!)
                    success(result)
                }
                catch let error{
                    failure?("error occured while decoding = \(error)")
                    debugPrint("error occured while decoding = \(error)")
                }
            }
        }
    }
    
    func requestToServer(with url: URL, response: @escaping (Data?,URLResponse?,Error?) -> ()){
        URLSession.shared.dataTask(with: url) { (responseData, httpUrlResponse, error) in
            response(responseData,httpUrlResponse,error)
        }.resume()
    }
    
    func newsUrl(countryCode:String)->URL{
        URL(string: baseNewsUrl + countryCode + apiKey)!
    }
}
