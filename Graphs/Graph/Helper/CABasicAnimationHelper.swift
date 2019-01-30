import UIKit
import Toolkit

public class CABasicAnimationHelper {
    
    public func addStrokeEndAnimation(to layer: CAShapeLayer, duration: CFTimeInterval) {
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = duration
        animation.delegate = CoreAnimationListener { _ in
            layer.removeAllAnimations()
        }
        layer.add(animation, forKey: nil)
    }
    
    public func addVerticalTranslationAnimation(to layer: CAShapeLayer, duration: CFTimeInterval, fromValue: CGFloat, toValue: CGFloat) {
        
        let animation = CABasicAnimation(keyPath: "transform.translation.y")
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.duration = duration
        
        animation.delegate = CoreAnimationListener { _ in
            layer.frame = CGRect(x: layer.bounds.minX, y: toValue, width: layer.frame.width, height: layer.frame.height)
            layer.removeAllAnimations()
        }
        
        layer.add(animation, forKey: nil)
    }
}
