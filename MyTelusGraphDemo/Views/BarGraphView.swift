import Foundation
import UIKit

internal class BarGraphView: CustomView, GraphViewProtocol {
    
    // MARK: IBOutlets
    
    @IBOutlet weak internal var graphView: GraphView!
    
    // MARK: Internal Methods
    
    internal func initializeBarGraph(graph: BarGraph, gridType: GridType) {
        initBarGraph(graph: graph, gridType: gridType, graphType: .barGraph)
    }
    
    internal func drawBars(data: [BarGraphData], color: UIColor, barWidth: CGFloat) {
        graphView.drawableView.drawBars(data: data, color: color, barWidth: barWidth, animated: false, duration: 0, animationType: .none)
    }
    
    internal func drawBars(data: [BarGraphData], color: UIColor, barWidth: CGFloat, withAnimationDuration duration: CFTimeInterval, animationType: BarGraphAnimationType) {
        graphView.drawableView.drawBars(data: data, color: color, barWidth: barWidth, animated: true, duration: duration, animationType: animationType)
    }
    
    // MARK: Private Methods
    
    private func initBarGraph(graph: BarGraph, gridType: GridType, graphType: GraphType) {
        graphView.gridView.initGrid(horizontalSegmentsCount: graph.xConfig.categoryValues.count, verticalSegmentsCount: graph.yConfig.numberOfSegments, graphType: graphType)
        
        graphView.drawableView.initDrawableView(verticalAxis: graph.yConfig, horizontalAxis: graph.xConfig)
        
        graphView.maskingView.initMaskingView(verticalAxis: graph.yConfig, horizontalAxis: graph.xConfig)
        
        graphView.gridView.addGrid(gridType)
        
        createCategoryAxis(config: graph.xConfig, type: .horizontal)
        createAxis(config: graph.yConfig, type: .vertical)
        
        // call ui cycle to allow logic access component frame after autolayouts adjustments
        setNeedsLayout()
        layoutIfNeeded()
    }

    private func createAxis(config: NumericGraphAxisConfig, type: AxisType) {
        
        let segmentedValues = type == .horizontal ? config.segmentValues.enumerated() : config.segmentValues.reversed().enumerated()
        
        let initialIndex = type == .horizontal ? 0 : config.segmentValues.count - 1
        
        for (index, value) in segmentedValues {
            
            let axisView: AxisView = type == .horizontal ? HorizontalAxisView() : VerticalAxisView()
            
            if index == initialIndex {
                axisView.bindInitialNumericSegment(minValue: "\(config.minValue)", segmentValue: "\(value)", unitOfMeasure: config.unitOfMeasure)
            }
            else {
                axisView.bindNumericSegment(value: "\(value)", unitOfMeasure: config.unitOfMeasure)
            }
            
            if let stackview = type == .horizontal ? graphView.horizontalAxis : graphView.verticalAxis, let view = axisView as? UIView {
                stackview.addArrangedSubview(view)
            }
        }
    }
    
    private func createCategoryAxis(config: CategoryGraphAxisConfig, type: AxisType) {
        
        let test = config.categoryValues + [""]
        
        let categoryValues = (type == .horizontal ? test : test.reversed())
                
        for value in categoryValues {
            
            let axisView: AxisView = type == .horizontal ? HorizontalAxisView() : VerticalAxisView()
            
            axisView.bindCategoryValue(value: value)

            if let stackview = type == .horizontal ? graphView.horizontalAxis : graphView.verticalAxis, let view = axisView as? UIView {
                stackview.addArrangedSubview(view)
            }
        }
    }
}
