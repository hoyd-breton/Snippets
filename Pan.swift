


// Add UIGestureRecognizerDelegate Protocol


let panRec = UIPanGestureRecognizer()
var originalLocation: CGPoint!
var originalContentOrigin: CGPoint!


// Add in ViewDidLoad


panRec.addTarget(self, action: "draggedView:")
self.VIEW_TO_PAN.addGestureRecognizer(panRec)


// func


func draggedView(sender: UIPanGestureRecognizer) {
    
    let location = sender.locationInView(view)
    var translation = sender.translationInView(view)
    var velocity = sender.velocityInView(view)
    
    var viewToPan = self.VIEW_TO_PAN
    
    
    if sender.state == UIGestureRecognizerState.Began {
        
        // get where the object what is interacted with
        originalLocation = location
        
        // get where the object is
        originalContentOrigin = viewToPan.frame.origin
        
        
    } else if sender.state == UIGestureRecognizerState.Changed {
        
        let newOrigin = originalContentOrigin.y + location.y - originalLocation.y
        
        
        
        viewToPan.frame.origin.y = newOrigin
        
        print( viewToPan.frame.origin.y )
        
        
        
        
        
    } else if sender.state == UIGestureRecognizerState.Ended {
        var yOrigin = CGFloat(0)
        let newOrigin = viewToPan.frame.origin.y;
        
        switch(true){
            
        case newOrigin < 60 && newOrigin > -60 : // snap back
            yOrigin = 0;
            
            break;
            
        case newOrigin > 60 : // hide
            yOrigin = 600;
            
            break;
            
        default:
            
            // something
            
            break;
        }
        
        
        // animate to snap position
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            viewToPan.frame.origin.y = yOrigin
        })
        
    }
    
}