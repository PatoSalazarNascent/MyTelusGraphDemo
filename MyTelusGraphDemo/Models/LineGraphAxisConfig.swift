import Foundation

internal class LineGraphAxisConfig {
    
    // MARK: Properies
    
    internal let minValue: Int
    internal let maxValue: Int
    internal let numberOfSegments: Int
    internal let unitOfMeasure: String?
    internal let title: String?
    
    internal init(minValue: Int, maxValue: Int, numberOfSegments: Int, unitOfMeasure: String?, title: String?) {
        self.minValue = minValue
        self.maxValue = maxValue
        self.numberOfSegments = numberOfSegments
        self.unitOfMeasure = unitOfMeasure
        self.title = title
    }
    
    internal var segmentValues: [Int] {
        let segmentDistance = (maxValue - minValue) / numberOfSegments
        let values = Array(stride(from: minValue, through: maxValue, by: segmentDistance)).filter({ $0 != minValue})
        return values
    }
}
