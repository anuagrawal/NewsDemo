//
//  AppUserDefault.swift
//  NewsDemo
//
//  Created by Anushree on 09/07/21.
//

import Foundation
class AppUserDefault: UserDefaults {
    
    ///Shared User default
    public class var shared : AppUserDefault{
        struct Static{
            static let instance = AppUserDefault()
        }
        return Static.instance
    }
    
    var userDefault = UserDefaults.standard

    
    
    /// return country code is that en,es,in etc
    func countryCode() -> String?{
        return userDefault.object(forKey: "COUNTRY_CODE") as? String
    }
    
    /// set country code is that en,es,in etc
    open func setCountryCode(countryCode : String){
        userDefault.set(countryCode, forKey: "COUNTRY_CODE")
    }
    
    ///remove country code
    public func removeCountryCode(){
        userDefault.removeObject(forKey: "COUNTRY_CODE")
    }
    
    /// return country code is that en,es,in etc
    func countryName() -> String?{
        return userDefault.object(forKey: "COUNTRY_NAME") as? String
    }
    
    /// set country code is that en,es,in etc
    open func setCountryName(countryName : String){
        userDefault.set(countryName, forKey: "COUNTRY_NAME")
    }
    
    ///remove country code
    public func removeCountryName(){
        userDefault.removeObject(forKey: "COUNTRY_NAME")
    }
}
