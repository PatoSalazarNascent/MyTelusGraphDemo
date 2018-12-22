import UIKit
import Foundation

internal extension UIView {
    
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
        
    internal func anchorToParent(_ parent: UIView) {
        
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
}

