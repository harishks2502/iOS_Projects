//
//  MathOperationsTest.swift
//  FitnessAppTests
//
//  Created by admin on 01/02/25.
//

import XCTest
import FitnessApp
@testable import FitnessApp

final class MathOperationsTest: XCTestCase {

    
    //AAA
    var mathOperations:MathOperations!
    
    override func setUp()  {
        super.setUp()
        //A - arrange
        mathOperations = MathOperations()
    }
    
    override func tearDown() {
        mathOperations = nil
        super.tearDown()
    }
    
    
    func testAddition() throws{
        //Action - perform action
        let result = mathOperations.add(2,3)
        //Assertion
        XCTAssertEqual(result,5,"Expected 2 + 3 equal 5")
    }
    
    func testSubtraction() throws{
        //Action
        let result = mathOperations.subtract(4,2)
        XCTAssertEqual(result,2, "Expected 4 - 2 equal 2 ")
    }
}
