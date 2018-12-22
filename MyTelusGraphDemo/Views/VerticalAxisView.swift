import Foundation
import UIKit

internal class VerticalAxisView: CustomView {
    
    // MARK: Instance Properties
    
    // MARK: IBOUtlets
    
    @IBOutlet weak var value: UILabel!
    
    // MARK: Constructors
    
    internal override init() {
        super.init()
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        
        // call super constructor
        super.init(coder: aDecoder)
    }
    
    // MARK: Internal Methods
    
    internal func bind(value: String) {
        self.value.text = value
    }
    
    // MARK: Private Methods
}

