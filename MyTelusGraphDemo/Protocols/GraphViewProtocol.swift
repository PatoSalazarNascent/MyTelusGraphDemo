import UIKit
import Foundation

internal protocol GraphViewProtocol {
    
    var graphView: GraphView! { get set }
    
    func setCustomFont(font: UIFont)
    func setGridColor(color: UIColor?)
    func setGraphBackgroundColor(color: UIColor?, alpha: CGFloat)
    func addDataLimit(dataLimit: LineGraphData, color: UIColor, dataLimitType: AxisType)
    func addGraphFill(data: [LineGraphData], color: UIColor)
    func addGraphFill(data: [LineGraphData], color: UIColor, animateWithDuration duration: CFTimeInterval)
    func clearGraph()
}

internal extension GraphViewProtocol {
    
    internal func setCustomFont(font: UIFont) {
        graphView.setCustomFont(font: font)
    }
    
    internal func setGridColor(color: UIColor?) {
        graphView.setGridColor(color: color)
    }
    
    internal func setGraphBackgroundColor(color: UIColor?, alpha: CGFloat) {
        graphView.setGraphBackgroundColor(color: color, alpha: alpha)
    }
    
    internal func addDataLimit(dataLimit: LineGraphData, color: UIColor, dataLimitType: AxisType) {
        graphView.addDataLimit(dataLimit: dataLimit, color: color, dataLimitType: dataLimitType)
    }
    
    internal func addGraphFill(data: [LineGraphData], color: UIColor) {
        graphView.addGraphFill(data: data, color: color)
    }
    
    internal func addGraphFill(data: [LineGraphData], color: UIColor, animateWithDuration duration: CFTimeInterval) {
        graphView.addGraphFill(data: data, color: color, animateWithDuration: duration)
    }
    
    internal func clearGraph() {
        graphView.clearGraph()
    }
}
