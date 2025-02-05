//
//  AddWorkoutViewTest.swift
//  FitnessAppUITests
//
//  Created by admin on 03/02/25.
//

import XCTest


final class AddWorkoutViewTest: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testAddWorkoutViewElementsExist() {
        // Navigate to AddWorkoutView
        app.buttons["Add"].tap()

        // Check navigation title visibility
        XCTAssertTrue(app.navigationBars["Add Workout"].exists, "The Add Workout screen should be displayed.")

        // Check for text field visibility
        let workoutNameField = app.textFields["Workout Name"]
        XCTAssertTrue(workoutNameField.exists, "The Workout Name text field should be visible.")

        // Check for Save button visibility
        let saveButton = app.buttons["Save"]
        XCTAssertTrue(saveButton.exists, "The Save button should be visible.")
    }

    func testSaveWorkout() {
        // Navigate to AddWorkoutView
        app.buttons["Add"].tap()

        // Enter a workout name
        let workoutNameField = app.textFields["Workout Name"]
        workoutNameField.tap()
        workoutNameField.typeText("Test Workout")

        // Tap the Save button
        app.buttons["Save"].tap()

        // Verify that the AddWorkoutView is dismissed
        XCTAssertFalse(app.navigationBars["Add Workout"].exists, "The Add Workout screen should be dismissed after saving.")
    }

    func testEmptyWorkoutNamePreventsSaving() {
        // Navigate to AddWorkoutView
        app.buttons["plus"].tap()

        // Attempt to save without entering a workout name
        app.buttons["Save"].tap()

        // Verify that the screen remains because workoutName is empty
        XCTAssertTrue(app.navigationBars["Add Workout"].exists, "The Add Workout screen should remain when trying to save without a name.")
    }
}
