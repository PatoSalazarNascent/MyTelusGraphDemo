import Foundation
import UIKit
import Toolkit

public class HorizontalAxisView: BaseView, AxisView {
    
    // MARK: IBOUtlets
    
    @IBOutlet internal weak var minValue: UILabel!
    @IBOutlet internal weak var value: UILabel!
    
    @IBOutlet private weak var minValueLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var valueTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var valueTrailingConstraint: NSLayoutConstraint!
        
    // MARK: Internal Methods
    
    public func bindInitialNumericSegment(minValue: String, segmentValue: String, unitOfMeasure: String?) {
        self.minValue.text = "\(minValue)\(unitOfMeasure ?? "")"
        self.value.text = "\(segmentValue)\(unitOfMeasure ?? "")"
        
        minValueLeadingConstraint.constant = -(self.minValue.intrinsicContentSize.width / 2)
        valueTrailingConstraint.constant = self.value.intrinsicContentSize.width / 2
    }
    
    public func bindNumericSegment(value: String, unitOfMeasure: String?) {
        self.value.text = "\(value)\(unitOfMeasure ?? "")"
        self.minValue.isHidden = true
        
        valueTrailingConstraint.constant = self.value.intrinsicContentSize.width / 2
    }
    
    public func bindCategoryValue(value: String) {
        self.value.text = value
        self.minValue.isHidden = true
        
        valueTrailingConstraint.constant = self.value.intrinsicContentSize.width / 2
        valueTopConstraint.constant = 10
        self.value.transform = CGAffineTransform(rotationAngle: 49.9)
    }
}
