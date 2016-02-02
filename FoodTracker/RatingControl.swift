//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Parker Donat on 1/31/16.
//  Copyright © 2016 Parker Donat. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    
    // MARK: Properties
    var rating = 0 {
        // Property observer
        didSet {
            setNeedsLayout()
        }
    }
    
    var ratingButtons = [UIButton]()
    
    var spacing = 5
    
    var stars = 5

    // MARK: Initialzation
    required init?(coder aDecoder: NSCoder) {
        // Call the superclass's initializer
        super.init(coder: aDecoder)
        
        let filledStarImage = UIImage(named: "filledStar")
        let emptyStarImage = UIImage(named: "emptyStar")
        
        // Create a total of five button
        for _ in 0..<stars {
            let button = UIButton()
            button.setImage(emptyStarImage, forState: .Normal)
            button.setImage(filledStarImage, forState: .Selected)
            button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
            // Disable the image highlight during state change
            button.adjustsImageWhenHighlighted = false
            // Attaching the action ratingButtonTapped to the button, which triggers whenver .TouchDown event occurs
            button.addTarget(self, action: "ratingButtonTapped:", forControlEvents: .TouchDown)
            // Track the buttons in the array
            ratingButtons += [button]
            addSubview(button)
        }
    }
    
    // Creates a frame, and uses a for-in loop to iterate over all of the buttons to set their frames.
    override func layoutSubviews() {
        // Set the button's width and height to the square size of the frame's height
        let buttonSize = Int(frame.size.height)
        
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        // Offset each button's orgin by the length of the button plus spacing.
        for(index, button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        
        updateButtonSelectionStates()
    }

    // Tell the stack view how to lay out the button
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize + spacing) * stars
        return CGSize(width: width, height: buttonSize)
    }
    
    // MARK: Button Action
    func ratingButtonTapped(button: UIButton) {
        rating = ratingButtons.indexOf(button)! + 1
        
        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerate() {
            // If the index of a button is less than the rating, that button should be selected.
            button.selected = index < rating
        }
    }
}
