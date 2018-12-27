import Foundation
import UIKit

internal class CustomView: UIView {
    // MARK: private variables
    
    private let defaultFrame = CGRect(x: 0, y: 0, width: 375, height: 128)
    
    // MARK: constructors
    
    public init() {
        
        super.init(frame: defaultFrame)
        loadFromNib()
    }
    
    internal init(viewName: String, frame: CGRect) {
        
        // call super constructor
        super.init(frame: frame)
        
        // bind to nib
        bindNib(viewName: viewName)
    }
    
    internal init?(viewName: String, coder aDecoder: NSCoder) {
        
        // call super constructor
        super.init(coder: aDecoder)
        
        // bind to nib
        bindNib(viewName: viewName)
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        
        // call super constructor
        super.init(coder: aDecoder)
        
        // fail
        loadFromNib()
    }
    
    internal override init(frame: CGRect) {
        
        // call super.init(frame:)
        super.init(frame: frame)
        
        // fail
        loadFromNib()
    }
    
    // MARK: private methods
    
    private func loadFromNib() {
        
        let viewName = String(describing: type(of: self))
        bindNib(viewName: viewName)
    }
}
