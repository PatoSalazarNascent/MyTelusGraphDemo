import Foundation
import UIKit
import Toolkit

public class BarGraphView: BaseView, GraphViewProtocol {
    
    // MARK: Properties
    
    private var verticalAxisFormatter: ((Double) -> String?)?
    private var horizontalAxisFormatter: ((Double) -> String?)?
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var graphView: GraphView!
    
    // MARK: Internal Methods
    
    public func initializeBarGraph(graph: BarGraph, gridType: GridType) {
        initBarGraph(graph, gridType: gridType)
    }
    
    public func drawBars(title: String, data: [BarGraphData], color: UIColor, barWidth: CGFloat) {
        
        graphView.drawableView.drawBars(data: data, color: color, barWidth: barWidth, animated: false, duration: 0, animationType: .none)
    }
    
    public func drawBars(title: String, data: [BarGraphData], color: UIColor, barWidth: CGFloat, withAnimationDuration duration: CFTimeInterval, animationType: BarGraphAnimationType) {
        
        graphView.drawableView.drawBars(data: data, color: color, barWidth: barWidth, animated: true, duration: duration, animationType: animationType)
    }
    
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
    
    // MARK: Private Methods
    
    private func initBarGraph(_ graph: BarGraph, gridType: GridType) {
        
        // Drawer Helper
        let shapesHelper = ShapesHelper()
        
        // horizontal and vertical values
        let verticalAxisValues = (min: graph.yConfig.minValue, max: graph.yConfig.maxValue)
        let horizontalAxisValues = (min: 0, max: graph.xConfig.categoryValues.count)
        
        graphView.gridView.initGridView(verticalSegmentsCount: graph.xConfig.categoryValues.count, horizontalSegmentsCount: graph.xConfig.categoryValues.count, type: gridType)
        
        graphView.drawableView.initDrawableView(verticalAxisValues: verticalAxisValues, horizontalAxisValues: horizontalAxisValues, shapesHelper: shapesHelper)
        
        graphView.maskingView.initMaskingView(verticalAxisValues: verticalAxisValues, horizontalAxisValues: horizontalAxisValues)
        
        // create axis
        graphView.createCategoryAxis(config: graph.xConfig, type: .horizontal)
        graphView.createNumericAxis(config: graph.yConfig, type: .vertical)
        
        // update frame after UI is set and autolayouts have done his thing
        layoutIfNeeded()
    }
}
