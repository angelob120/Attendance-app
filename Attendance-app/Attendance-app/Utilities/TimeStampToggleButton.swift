//
//  TimeClockToggleButton.swift
//  Attendance-app
//
//  Created by Keon Johnson on 10/10/24.
//


import UIKit

/// A custom UIButton subclass that toggles between two states (on/off)
class TimeClockToggleButton: UIButton {
    /// Tracks the current state of the button
    var isOn: Bool = false {
        didSet {
            updateAppearance()
        }
    }
    
    /// Custom initializer for creating the button programmatically
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Sets up the initial button configuration
    private func setupButton() {
        // Add tap gesture recognizer
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        // Set initial appearance
        updateAppearance()
    }
    
    /// Handles the button tap event
    @objc private func buttonTapped() {
        // Toggle the button state
        isOn.toggle()
    }
    
    /// Updates the button's appearance based on its current state
    private func updateAppearance() {
        // Change background color based on state
        backgroundColor = isOn ? .green : .red
        // Update button text based on state
        setTitle(isOn ? "Clock Out" : "Clock In", for: .normal)
    }
}



import UIKit

/// A custom UIButton subclass that toggles between two states (on/off)
class TimeClockToggleButtonHold: UIButton {
    /// Tracks the current state of the button
    var isOn: Bool = false {
        didSet {
            updateAppearance()
        }
    }
    
    /// Custom initializer for creating the button programmatically
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    /// This code requires an initializer for creating the button from a storyboard or XIB
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    /// Sets up the initial button configuration
    private func setupButton() {
        // Add tap gesture recognizer
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        // Set initial appearance
        updateAppearance()
    }
    
    /// Handles the button tap event
    /// The frameworks in Object-C are needed to interact with certain APIs. This code instructs Swift to make available to make thing availble to Objective-C. Anytime a method is called from a UIBarButtonItem or timer, it has to mark the method using @objc to expose it.
    @objc private func buttonTapped() {
        // Toggle the button state
        isOn.toggle()
    }
    
    /// Updates the button's appearance based on its current state
    private func updateAppearance() {
        // Change background color based on state
        backgroundColor = isOn ? .green : .red
        // Update button text based on state
        setTitle(isOn ? "Clock Out" : "Clock In", for: .normal)
    }
}
