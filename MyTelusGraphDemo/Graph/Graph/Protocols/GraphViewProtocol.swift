import UIKit
import Foundation

public protocol GraphViewProtocol {
    
    var graphView: GraphView! { get set }
    
    func setCustomFont(font: UIFont)
    func setGridColor(color: UIColor?)
    func setGraphBackgroundColor(color: UIColor?, alpha: CGFloat)
    func addDataLimit(dataLimit: LineGraphData, color: UIColor, dataLimitType: AxisType)
    func addGraphFill(data: [LineGraphData], color: UIColor)
    func addGraphFill(data: [LineGraphData], color: UIColor, animateWithDuration duration: CFTimeInterval)
    func addMetaData(iconColor: UIColor, text: String)
    func addMetaData(iconImage: String, text: String)
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
    
    public func addDataLimit(dataLimit: LineGraphData, color: UIColor, dataLimitType: AxisType) {
        graphView.addDataLimit(dataLimit: dataLimit, color: color, dataLimitType: dataLimitType)
    }
    
    public func addGraphFill(data: [LineGraphData], color: UIColor) {
        graphView.addGraphFill(data: data, color: color)
    }
    
    public func addGraphFill(data: [LineGraphData], color: UIColor, animateWithDuration duration: CFTimeInterval) {
        graphView.addGraphFill(data: data, color: color, animateWithDuration: duration)
    }
    
    public func addMetaData(iconColor: UIColor, text: String) {
        
        let metaView = GraphMetaDataView()
        metaView.bindMetaData(iconColor: iconColor, text: text)
        
        graphView.metadataStackview.addArrangedSubview(metaView)
    }
    
    public func addMetaData(iconImage: String, text: String) {
        
        let metaView = GraphMetaDataView()
        metaView.bindMetaData(iconImage: iconImage, text: text)
        
        graphView.metadataStackview.addArrangedSubview(metaView)
    }
    
    public func clearGraphData() {
        graphView.clearGraphData()
    }
    
    public func resetGraph() {
        graphView.resetGraph()
    }
}
