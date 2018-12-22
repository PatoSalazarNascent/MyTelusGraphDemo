import Foundation

internal class LineChart {
    
    // MARK: Properties
    
    internal let xConfig: LineChartAxisConfig
    internal let yConfig: LineChartAxisConfig
    
    // MARK: Constructor
    
    internal init(xConfig: LineChartAxisConfig, yConfig: LineChartAxisConfig) {
        self.xConfig = xConfig
        self.yConfig = yConfig
    }
}
