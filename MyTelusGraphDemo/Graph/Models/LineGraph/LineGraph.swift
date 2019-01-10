import Foundation

internal class LineGraph {
    
    // MARK: Properties
    
    internal let yConfig: NumericGraphAxisConfig
    internal let xConfig: NumericGraphAxisConfig
    
    // MARK: Constructor
    
    internal init(yConfig: NumericGraphAxisConfig, xConfig: NumericGraphAxisConfig) {
        self.yConfig = yConfig
        self.xConfig = xConfig
    }
}
