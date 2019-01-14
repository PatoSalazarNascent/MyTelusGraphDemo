import Foundation

public class LineGraph {
    
    // MARK: Properties
    
    public let yConfig: NumericGraphAxisConfig
    public let xConfig: NumericGraphAxisConfig
    
    // MARK: Constructor
    
    public init(yConfig: NumericGraphAxisConfig, xConfig: NumericGraphAxisConfig) {
        self.yConfig = yConfig
        self.xConfig = xConfig
    }
}
