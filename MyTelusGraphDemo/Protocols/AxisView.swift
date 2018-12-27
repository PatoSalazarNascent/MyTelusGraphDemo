import UIKit

internal protocol AxisView {
    func bindFirstSegment(minValue: Int, segmentValue: Int, unitOfMeasure: String?)
    func bindSegmentValue(value: Int, unitOfMeasure: String?)
}

extension AxisView where Self: UIView {}
