import Foundation

public class BarGraph {

    // MARK: Properties
    
    public let yConfig: NumericGraphAxisConfig
    public let xConfig: CategoryGraphAxisConfig
    
    // MARK: Constructor
    
    public init(yConfig: NumericGraphAxisConfig, xConfig: CategoryGraphAxisConfig) {
        self.yConfig = yConfig
        self.xConfig = xConfig
    }
}
