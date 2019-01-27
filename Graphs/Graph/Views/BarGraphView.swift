import Foundation
import UIKit
import Toolkit

public class BarGraphView: BaseView, WithGraphViewProtocol {

    // MARK: IBOutlets
    
    @IBOutlet weak public var graphView: GraphView!
    
    // MARK: Internal Methods
    
    public func initializeBarGraph(graph: BarGraph, gridType: GridType) {
        // Drawer Helper
        let shapesHelper = ShapesHelper()
        let animationHelper = CABasicAnimationHelper()
        
        // horizontal and vertical values
        let verticalAxisValues = (min: graph.yConfig.minValue, max: graph.yConfig.maxValue)
        let horizontalAxisValues = (min: 0, max: graph.xConfig.categoryValues.count)
        
        graphView.gridView.initGridView(verticalSegmentsCount: graph.xConfig.categoryValues.count, horizontalSegmentsCount: graph.xConfig.categoryValues.count + 1, type: gridType)
        
        graphView.drawableView.initDrawableView(verticalAxisValues: verticalAxisValues, horizontalAxisValues: horizontalAxisValues, shapesHelper: shapesHelper, animationHelper: animationHelper)
        
        graphView.maskingView.initMaskingView(verticalAxisValues: verticalAxisValues, horizontalAxisValues: horizontalAxisValues)
        
        // create axis
        graphView.createCategoryAxis(config: graph.xConfig, type: .horizontal)
        graphView.createNumericAxis(config: graph.yConfig, type: .vertical)
        
        // update frame after UI is set and autolayouts have done his thing
        layoutIfNeeded()
    }
    
    public func drawBars(title: String, data: [BarGraphData], color: UIColor, barWidth: CGFloat) {
        graphView.drawableView.drawBars(data: data, color: color, barWidth: barWidth, animated: false, duration: 0, animationType: .none)
    }
    
    public func drawBars(title: String, data: [BarGraphData], color: UIColor, barWidth: CGFloat, withAnimationDuration duration: CFTimeInterval, animationType: BarGraphAnimationType) {
        
        graphView.drawableView.drawBars(data: data, color: color, barWidth: barWidth, animated: true, duration: duration, animationType: animationType)
    }
}
