import Foundation

internal class LineGraph {
    
    // MARK: Properties
    
    internal let xConfig: LineGraphAxisConfig
    internal let yConfig: LineGraphAxisConfig
    
    // MARK: Constructor
    
    internal init(xConfig: LineGraphAxisConfig, yConfig: LineGraphAxisConfig) {
        self.xConfig = xConfig
        self.yConfig = yConfig
    }
}
