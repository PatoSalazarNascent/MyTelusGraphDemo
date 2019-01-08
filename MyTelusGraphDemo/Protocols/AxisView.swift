import UIKit

internal protocol AxisView {
    
    var minValue: UILabel! { get set }
    var value: UILabel! { get set }
    
    func bindFirstSegment(minValue: String, segmentValue: String, unitOfMeasure: String?)
    func bindSegmentValue(value: String, unitOfMeasure: String?)
}

extension AxisView where Self: UIView {}
