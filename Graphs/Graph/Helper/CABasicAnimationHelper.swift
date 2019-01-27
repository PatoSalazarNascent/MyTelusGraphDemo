import UIKit
import Toolkit

public class CABasicAnimationHelper {
    
    public func addStrokeEndAnimation(to layer: CAShapeLayer, duration: CFTimeInterval) {
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = duration
        animation.delegate = CoreAnimationListener { _ in
            // we could pass a completion parameter to trigger something in the UI
            layer.removeAllAnimations()
        }
        layer.add(animation, forKey: nil)
    }
}
