import UIKit
import Foundation

public extension UIView {
    
    internal func bindNib(viewName: String) {
        
        // load xib
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: viewName, bundle: bundle)
        
        let childView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        // initialize to fit container
        childView.frame = bounds
        
        // add child
        addSubview(childView)
        childView.anchorToParent(self)
    }
        
    public func anchorToParent(_ parent: UIView) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["view": self]
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(
            contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views))
        
        constraints.append(
            contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views))
        
        parent.addConstraints(constraints)
        parent.updateConstraints()
    }
    
    public func setAnchorPoint(anchorPoint: CGPoint) {
        var newPoint = CGPoint(x: self.bounds.size.width * anchorPoint.x, y: self.bounds.size.height * anchorPoint.y)
        var oldPoint = CGPoint(x: self.bounds.size.width * self.layer.anchorPoint.x, y: self.bounds.size.height * self.layer.anchorPoint.y)
        
        newPoint = newPoint.applying(self.transform)
        oldPoint = oldPoint.applying(self.transform)
        
        var position: CGPoint = self.layer.position
        
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        self.layer.position = position
        self.layer.anchorPoint = anchorPoint
    }
}
