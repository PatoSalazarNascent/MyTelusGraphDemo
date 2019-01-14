import Foundation

public class NumericGraphAxisConfig {
    
    // MARK: Properies
    
    public let minValue: Int
    public let maxValue: Int
    public let numberOfSegments: Int
    public let unitOfMeasure: String?
    public let title: String?
    
    public init(minValue: Int, maxValue: Int, numberOfSegments: Int, unitOfMeasure: String?, title: String?) {
        self.minValue = minValue
        self.maxValue = maxValue
        self.numberOfSegments = numberOfSegments
        self.unitOfMeasure = unitOfMeasure
        self.title = title
    }
    
    public var segmentValues: [Double] {
        let segmentDistance: Double = Double(maxValue - minValue) / Double(numberOfSegments)
        let values = Array(stride(from: Double(minValue), through: Double(maxValue), by: segmentDistance)).filter({ $0 != Double(minValue) })
        return values
    }
}
