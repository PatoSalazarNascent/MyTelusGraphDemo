import Foundation
import UIKit

internal class HorizontalAxisView: CustomView, AxisView {
    
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
    
    internal func bindFirstSegment(minValue: Int, segmentValue: Int, unitOfMeasure: String?) {
        self.minValue.text = "\(minValue)\(unitOfMeasure ?? "")"
        self.value.text = "\(segmentValue)\(unitOfMeasure ?? "")"
    }
    
    internal func bindSegmentValue(value: Int, unitOfMeasure: String?) {
        self.value.text = "\(value)\(unitOfMeasure ?? "")"
        self.minValue.isHidden = true
    }
}
