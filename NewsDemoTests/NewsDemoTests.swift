//
//  NewsDemoTests.swift
//  NewsDemoTests
//
//  Created by Anushree on 08/07/21.
//

import XCTest
@testable import NewsDemo

class NewsDemoTests: XCTestCase {
    

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testNewsUrl(){
        let sut = Webservice.shared
        let testForCountryCode = "en"
        let wsUrl = sut.newsUrl(countryCode: testForCountryCode)
        let promise = expectation(description: "News URL Check")
        if (wsUrl.absoluteURL.absoluteString) == (baseNewsUrl + testForCountryCode + apiKey){
            promise.fulfill()
        }else{
            XCTFail("Url not matcing")
        }
        wait(for: [promise], timeout: 5)
    }
    
    func testAPISuccess(){
        let sut = Webservice.shared
        let promise = expectation(description: "Success block called on success")
        let urlToTest = sut.newsUrl(countryCode: "en")
        sut.newsListRequest(with: urlToTest, ofType: Article.self) { (success) in
            promise.fulfill()
        } failure: { (failureString) in
            XCTAssertFalse(failureString.isEmpty)
        }
        wait(for: [promise], timeout: 5)
    }
    
    
    func testServerRequest200(){
        let sut = Webservice.shared
        let promise = expectation(description: "Status Code : 200")
        let urlToTest = sut.newsUrl(countryCode: "en")
        sut.requestToServer(with: urlToTest) { (data, response, error) in
            if error != nil{
                XCTFail("Getting Error response")
            }else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200{
                    promise.fulfill()
                }else{
                    XCTFail("Getting server response other than 200.")
                }
            }
        }
        wait(for: [promise], timeout: 5)
    }
}
