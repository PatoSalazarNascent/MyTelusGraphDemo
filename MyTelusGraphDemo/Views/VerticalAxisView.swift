import Foundation
import UIKit

internal class VerticalAxisView: CustomView, AxisView {

    // MARK: Instance Properties
    
    // MARK: IBOUtlets
    
    @IBOutlet private weak var minValue: UILabel!
    @IBOutlet private weak var value: UILabel!
    @IBOutlet private weak var valueTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var minValueBottomConstraint: NSLayoutConstraint!
    
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
        
        minValueBottomConstraint.constant = self.minValue.intrinsicContentSize.height / 2
        valueTopConstraint.constant = -(self.value.intrinsicContentSize.height / 2)
    }
    
    internal func bindSegmentValue(value: String, unitOfMeasure: String?) {
        self.value.text = "\(value)\(unitOfMeasure ?? "")"
        self.minValue.isHidden = true
        
        valueTopConstraint.constant = -(self.value.intrinsicContentSize.height / 2)
    }
}

