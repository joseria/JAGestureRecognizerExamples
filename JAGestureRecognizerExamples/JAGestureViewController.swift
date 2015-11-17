//
//  JAGestureViewController.swift
//  JAGestureRecognizerExamples
//
//  Created by Alvarez, Jose (MTV) on 10/11/14.
//  Copyright (c) 2014 Jose Alvarez. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit

class JAGestureViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var swipeLabel: UILabel!
    var panGestureRecognizer:UIPanGestureRecognizer!
    var leftSwipeGestureRecognizer:UISwipeGestureRecognizer!
    var rightSwipeGestureRecognizer:UISwipeGestureRecognizer!
    var earthBW = false
    let kALPHA_FACTOR:CGFloat = 0.8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Gesture Recognizer Example";
        textView.text = "This example demonstrates the use of pan, swipe, tap, long press, rotation, and pinch gestures. Try it out for yourself!"
        
        imageView.userInteractionEnabled = true
        imageView.backgroundColor = UIColor.clearColor()
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.clipsToBounds = true
        imageView.center = view.center
        
        swipeLabel.hidden = true

        view.addSubview(imageView)
        view.backgroundColor = UIColor.whiteColor()
        
        panGestureRecognizer = UIPanGestureRecognizer(target:self, action: "panHandler:")
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapHandler:")
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressHandler:")
        let rotateGestureRecognizer = UIRotationGestureRecognizer(target: self, action: "rotateHandler:")
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: "pinchHandler:")
        leftSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeHandler:")
        leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Left
        rightSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeHandler:")
        rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Right
        
        imageView.addGestureRecognizer(panGestureRecognizer)
        imageView.addGestureRecognizer(tapGestureRecognizer)
        imageView.addGestureRecognizer(longPressGestureRecognizer)
        imageView.addGestureRecognizer(rotateGestureRecognizer)
        imageView.addGestureRecognizer(pinchGestureRecognizer)
    }

    // Switch between panning or swiping
    @IBAction func segmentedControlTapped(sender: AnyObject) {
        if (sender as! UISegmentedControl).selectedSegmentIndex == 0 {
            swipeLabel.hidden = true
            imageView.removeGestureRecognizer(leftSwipeGestureRecognizer)
            imageView.removeGestureRecognizer(rightSwipeGestureRecognizer)
            imageView.addGestureRecognizer(panGestureRecognizer)
        } else {
            swipeLabel.hidden = false
            swipeLabel.text = String(format:"Alpha %.02f", imageView.alpha)
            imageView.removeGestureRecognizer(panGestureRecognizer)
            imageView.addGestureRecognizer(leftSwipeGestureRecognizer)
            imageView.addGestureRecognizer(rightSwipeGestureRecognizer)
        }
    }
    
    // MARK:- Gesture Recognizer Handler methods
    
    // Pan gesture handler
    func panHandler(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(view)
        recognizer.view!.center = CGPoint(x: recognizer.view!.center.x + translation.x, y: recognizer.view!.center.y + translation.y)
        recognizer.setTranslation(CGPointZero, inView: view)
    }
    
    // Tap gesture handler
    func tapHandler(recognizer:UITapGestureRecognizer) {
        imageView.center = view.center
        imageView.transform = CGAffineTransformIdentity
        imageView.image = UIImage(named: "earth.png")
        imageView.alpha = 1.0
    }
    
    // Long press gesture handler
    func longPressHandler(recognizer:UILongPressGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.Began {
            if earthBW {
                imageView.image = UIImage(named: "earth.png")
            } else {
                imageView.image = UIImage(named: "earthRipple.png")
            }
            earthBW = !earthBW
        }
    }
    
    // Rotate gesture handler
    func rotateHandler(recognizer:UIRotationGestureRecognizer) {
        recognizer.view!.transform = CGAffineTransformRotate(recognizer.view!.transform, recognizer.rotation)
        // Reset the rotation
        recognizer.rotation = 0
    }
    
    // Pinch gesture handler
    func pinchHandler(recognizer:UIPinchGestureRecognizer) {
        recognizer.view!.transform = CGAffineTransformScale(recognizer.view!.transform, recognizer.scale, recognizer.scale)
        // Reset the scale factor
        recognizer.scale = 1
    }

    // Swipe gesture handler
    func swipeHandler(recognizer:UISwipeGestureRecognizer) {
        switch recognizer.direction {
        case UISwipeGestureRecognizerDirection.Left:
            if imageView.alpha > 0.2 {
                imageView.alpha *= kALPHA_FACTOR
                swipeLabel.text = String(format:"Alpha %.02f", imageView.alpha)
            }
            print("Swipe Left");
        case UISwipeGestureRecognizerDirection.Right:
            if imageView.alpha < 1.0 {
                imageView.alpha /= kALPHA_FACTOR
                swipeLabel.text = String(format:"Alpha %.02f", imageView.alpha)
            }
            print("Swipe Right")
        default:
            print("Undefined swipe direction")
        }
    }
}
