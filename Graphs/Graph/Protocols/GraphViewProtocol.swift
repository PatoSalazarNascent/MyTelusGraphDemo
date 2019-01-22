import UIKit
import Foundation

public protocol GraphViewProtocol {
        
    func setCustomFont(font: UIFont)
    func setGridColor(color: UIColor?)
    func setGraphBackgroundColor(color: UIColor?, alpha: CGFloat)
    func addDataLimit(dataLimit: LineGraphData, color: UIColor, axis: AxisType)
    func addGraphFill(data: [LineGraphData], color: UIColor)
    func addGraphFill(data: [LineGraphData], color: UIColor, animateWithDuration duration: CFTimeInterval)
    func clearGraphData()
    func resetGraph()
}
