public class CoreAnimationListener: NSObject, CAAnimationDelegate {
    
    public let didStop: (Bool) -> Void
    
    public init(didStop: @escaping (Bool) -> Void) {
        
        self.didStop = didStop
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        didStop(flag)
    }
}
