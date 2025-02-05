//
//  WorkListViewTest.swift
//  FitnessAppUITests
//
//  Created by admin on 03/02/25.
//

import XCTest



final class WorkoutListViewTest : XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Initialize the app and reset its state
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testWorkoutListViewElementsVisibility() throws {
            // Check if the navigation title is visible
            XCTAssertTrue(app.navigationBars["Workouts"].exists, "The Workout list title is not visible.")

            // Check if the Edit button exists
            let editButton = app.buttons["Edit"]
            XCTAssertTrue(editButton.exists, "The Edit button should be visible.")
            
            // Check if the Add button exists
            let addButton = app.buttons["Add"]
        
            XCTAssertTrue(addButton.exists, "The Add button (plus) should be visible.")
            
        }

        func testWorkoutCellVisibilityAfterAddition() throws {
            // Add a workout to make sure the list contains items
            app.buttons["Add"].tap()

            let workoutNameField = app.textFields["Workout Name"]
            workoutNameField.tap()
            workoutNameField.typeText("Test Workout")
            
            app.buttons["Save"].tap()
            
            // Verify the newly added workout is visible in the list
            XCTAssertTrue(app.staticTexts["Test Workout"].exists, "The workout should be visible in the list after being added.")
        }
    
    }
