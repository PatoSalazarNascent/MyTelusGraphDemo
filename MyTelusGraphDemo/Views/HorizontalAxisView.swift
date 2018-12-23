import Foundation
import UIKit

internal class HorizontalAxisView: CustomView {
    
    // MARK: IBOUtlets
    
    @IBOutlet weak var minValue: UILabel!
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
        self.minValue.isHidden = true
    }
    
    internal func bind(initValue: String, value: String) {
        
        self.minValue.text = initValue
        self.value.text = value
    }
    
    // MARK: Private Methods
}
