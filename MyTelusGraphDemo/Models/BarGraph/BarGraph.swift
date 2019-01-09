import Foundation

internal class BarGraph {
    
    // MARK: Properties
    
    internal let yConfig: NumericGraphAxisConfig
    internal let xConfig: CategoryGraphAxisConfig
    
    // MARK: Constructor
    
    internal init(yConfig: NumericGraphAxisConfig, xConfig: CategoryGraphAxisConfig) {
        self.yConfig = yConfig
        self.xConfig = xConfig
    }
}
