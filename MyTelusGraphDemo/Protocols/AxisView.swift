import UIKit

internal protocol AxisView {
    func bindFirstSegment(minValue: String, segmentValue: String, unitOfMeasure: String?)
    func bindSegmentValue(value: String, unitOfMeasure: String?)
}

extension AxisView where Self: UIView {}
