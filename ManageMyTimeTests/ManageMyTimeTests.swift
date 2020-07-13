//
//  ManageMyTimeTests.swift
//  ManageMyTimeTests
//
//  Created by רן א on 21/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import XCTest
@testable import ManageMyTime

class ManageMyTimeTests: XCTestCase {

    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        var hour =  Hour()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSubtractHour() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                  
                  //We need to create a context from this container
                  let managedContextTemp = appDelegate.persistentContainer.viewContext
                  
        
        let newHourlyTime = Hour(context: managedContextTemp)

             newHourlyTime.hour=2
             newHourlyTime.minutes=10

            let newHourlyTime2 = Hour(context: managedContextTemp)

             newHourlyTime2.hour=1
             newHourlyTime2.minutes=50

    
            
        let result = newHourlyTime.subtract(newHour:newHourlyTime2)
             
        XCTAssertEqual(result.hour,0)
        XCTAssertEqual(result.minutes,20)
        
        
        
    }
    
    
    func testAddHour() throws {
         // This is an example of a functional test case.
         // Use XCTAssert and related functions to verify your tests produce the correct results.
             guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                       
                       //We need to create a context from this container
                       let managedContextTemp = appDelegate.persistentContainer.viewContext
                       
             
            let newHourlyTime = Hour(context: managedContextTemp)

                  newHourlyTime.hour=1
                  newHourlyTime.minutes=50

             let newHourlyTime2 = Hour(context: managedContextTemp)

                  newHourlyTime2.hour=1
                  newHourlyTime2.minutes=20

            var result : Hour
                 
             result = newHourlyTime.add(newHour:newHourlyTime2)
                  
             XCTAssertEqual(result.hour,3)
             XCTAssertEqual(result.minutes,10)
    
         
     }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
