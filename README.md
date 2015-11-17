JAGestureRecognizerExamples
===========================

##Overview

UIGestureRecognizer Examples written in Swift. These cover pan, swipe, tap, long press, pinch, and rotate gestures. 

##Example Project
An example project is provided that requires IOS8 and XCode 7.0. 
When using gestures, you must first instantiate each recognizer with a target/action. Then you can add this recognizer to a view. Below are examples from the sample project that demonstrates how each `UIGestureRecognizer` is used. 

###UIPanGestureRecognizer

```objc
let panGestureRecognizer = UIPanGestureRecognizer(target:self, action: "panHandler:");
imageView.addGestureRecognizer(panGestureRecognizer);

// Pan gesture handler
func panHandler(recognizer:UIPanGestureRecognizer) {
    let translation = recognizer.translationInView(view);
    recognizer.view!.center = CGPoint(x: recognizer.view!.center.x + translation.x, y: recognizer.view!.center.y + translation.y);
    recognizer.setTranslation(CGPointZero, inView: view);
}

```

###UISwipeGestureRecognizer

```objc
// Swipe gestures have a specified direction that the gesture listens to. You can add multiple swipe gestures that can be
// handled in one common handler. 
let rightSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeHandler:");
rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Right;

let leftSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeHandler:");
leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Left;

imageView.addGestureRecognizer(rightSwipeGestureRecognizer);
imageView.addGestureRecognizer(leftSwipeGestureRecognizer);

// Swipe gesture handler
func swipeHandler(recognizer:UISwipeGestureRecognizer) {
    switch recognizer.direction {
    case UISwipeGestureRecognizerDirection.Left:
        if imageView.alpha > 0.2 {
            imageView.alpha *= kALPHA_FACTOR;
        }
        println("Swipe Left");
    case UISwipeGestureRecognizerDirection.Right:
        if imageView.alpha < 1.0 {
            imageView.alpha /= kALPHA_FACTOR;
        }
        println("Swipe Right");
    default:
        println("Undefined swipe direction");
    }
}
```

###UITapGestureRecognizer

```objc
let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapHandler:");
imageView.addGestureRecognizer(tapGestureRecognizer);

// Tap gesture handler
func tapHandler(recognizer:UITapGestureRecognizer) {
    imageView.center = view.center;
    imageView.transform = CGAffineTransformIdentity;
    imageView.image = UIImage(named: "earth.png");
    imageView.alpha = 1.0;
}
```

###UILongPressGestureRecognizer

```objc
let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressHandler:");
imageView.addGestureRecognizer(longPressGestureRecognizer);

// Long press gesture handler
func longPressHandler(recognizer:UILongPressGestureRecognizer) {
    if recognizer.state == UIGestureRecognizerState.Began {
        if earthBW {
            imageView.image = UIImage(named: "earth.png");
        } else {
            imageView.image = UIImage(named: "earthRipple.png");
        }
        earthBW = !earthBW;
    }
}
```

###UIPinchGestureRecognizer

```objc
let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: "pinchHandler:");
imageView.addGestureRecognizer(pinchGestureRecognizer);

// Pinch gesture handler
func pinchHandler(recognizer:UIPinchGestureRecognizer) {
    recognizer.view!.transform = CGAffineTransformScale(recognizer.view!.transform, recognizer.scale, recognizer.scale);
    // Reset the scale factor
    recognizer.scale = 1;
}

```

###UIRotationGestureRecognizer

```objc
let rotateGestureRecognizer = UIRotationGestureRecognizer(target: self, action: "rotateHandler:");
imageView.addGestureRecognizer(rotateGestureRecognizer);

// Rotate gesture handler
func rotateHandler(recognizer:UIRotationGestureRecognizer) {
    recognizer.view!.transform = CGAffineTransformRotate(recognizer.view!.transform, recognizer.rotation);
    // Reset the rotation
    recognizer.rotation = 0;
}
```


##Creator
Jose Alvarez

##License
JAGestureRecognizerExamples is available under the MIT license. See the LICENSE file for more info.
