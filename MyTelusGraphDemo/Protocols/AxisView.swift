import UIKit

internal protocol AxisView {
    
    var minValue: UILabel! { get set }
    var value: UILabel! { get set }
    
    func bindInitialNumericSegment(minValue: String, segmentValue: String, unitOfMeasure: String?)
    func bindNumericSegment(value: String, unitOfMeasure: String?)
    func bindCategoryValue(value: String)
}

extension AxisView where Self: UIView {}
