import Foundation
import UIKit

internal class HorizontalAxisView: CustomView, AxisView {
    
    // MARK: IBOUtlets
    
    @IBOutlet weak var minValue: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet private weak var minValueLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var valueTrailingConstraint: NSLayoutConstraint!
    
    // MARK: Constructors
    
    internal override init() {
        super.init()
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        
        // call super constructor
        super.init(coder: aDecoder)
    }
    
    // MARK: Internal Methods
    
    internal func bindFirstSegment(minValue: String, segmentValue: String, unitOfMeasure: String?) {
        self.minValue.text = "\(minValue)\(unitOfMeasure ?? "")"
        self.value.text = "\(segmentValue)\(unitOfMeasure ?? "")"
        
        minValueLeadingConstraint.constant = -(self.minValue.intrinsicContentSize.width / 2)
        valueTrailingConstraint.constant = self.value.intrinsicContentSize.width / 2
    }
    
    internal func bindSegmentValue(value: String, unitOfMeasure: String?) {
        self.value.text = "\(value)\(unitOfMeasure ?? "")"
        self.minValue.isHidden = true
        
        valueTrailingConstraint.constant = self.value.intrinsicContentSize.width / 2
    }
}
