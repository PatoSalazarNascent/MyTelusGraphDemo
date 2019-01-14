import Foundation
import UIKit

public class VerticalAxisView: BaseView, AxisView {

    // MARK: IBOUtlets
    
    @IBOutlet internal weak var minValue: UILabel!
    @IBOutlet internal weak var value: UILabel!
    @IBOutlet private weak var valueTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var minValueBottomConstraint: NSLayoutConstraint!
        
    // MARK: Internal Methods
    
    public func bindInitialNumericSegment(minValue: String, segmentValue: String, unitOfMeasure: String?) {
        self.minValue.text = "\(minValue)\(unitOfMeasure ?? "")"
        self.value.text = "\(segmentValue)\(unitOfMeasure ?? "")"
        
        minValueBottomConstraint.constant = self.minValue.intrinsicContentSize.height / 2
        valueTopConstraint.constant = -(self.value.intrinsicContentSize.height / 2)
    }
    
    public func bindNumericSegment(value: String, unitOfMeasure: String?) {
        self.value.text = "\(value)\(unitOfMeasure ?? "")"
        self.minValue.isHidden = true
        
        valueTopConstraint.constant = -(self.value.intrinsicContentSize.height / 2)
    }
    
    public func bindCategoryValue(value: String) {
        self.value.text = value
        self.minValue.isHidden = true
        
        valueTopConstraint.constant = -(self.value.intrinsicContentSize.height / 2)
    }
}
