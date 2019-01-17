import UIKit
import Foundation

public protocol GraphViewProtocol {
    
    var graphView: GraphView! { get }
    
    func setCustomFont(font: UIFont)
    func setGridColor(color: UIColor?)
    func setGraphBackgroundColor(color: UIColor?, alpha: CGFloat)
    func addDataLimit(dataLimit: LineGraphData, color: UIColor, axis: AxisType)
    func addGraphFill(data: [LineGraphData], color: UIColor)
    func addGraphFill(data: [LineGraphData], color: UIColor, animateWithDuration duration: CFTimeInterval)
    func clearGraphData()
    func resetGraph()
}

public extension GraphViewProtocol {

    public func setCustomFont(font: UIFont) {
        graphView.setCustomFont(font: font)
    }

    public func setGridColor(color: UIColor?) {
        graphView.setGridColor(color: color)
    }

    public func setGraphBackgroundColor(color: UIColor?, alpha: CGFloat) {
        graphView.setGraphBackgroundColor(color: color, alpha: alpha)
    }

    public func addDataLimit(dataLimit: LineGraphData, color: UIColor, axis: AxisType) {
        graphView.addDataLimit(dataLimit: dataLimit, color: color, axis: axis)
    }

    public func addGraphFill(data: [LineGraphData], color: UIColor) {
        graphView.addGraphFill(data: data, color: color)
    }

    public func addGraphFill(data: [LineGraphData], color: UIColor, animateWithDuration duration: CFTimeInterval) {
        graphView.addGraphFill(data: data, color: color, animateWithDuration: duration)
    }

    public func clearGraphData() {
        graphView.clearGraphData()
    }

    public func resetGraph() {
        graphView.resetGraph()
    }
}
