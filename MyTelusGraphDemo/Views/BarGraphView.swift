import Foundation
import UIKit

internal class BarGraphView: CustomView, GraphViewProtocol {
    
    // MARK: IBOutlets
    
    @IBOutlet weak internal var graphView: GraphView!
    
    // MARK: Internal Methods
    
    internal func initializeBarGraph(graph: BarGraph, gridType: GridType) {
        initBarGraph(graph: graph, gridType: gridType)
    }
    
    internal func drawBars() {
        
    }
    
    // MARK: Private Methods
    
    private func initBarGraph(graph: BarGraph, gridType: GridType) {
        graphView.gridView.initGrid(horizontalSegmentsCount: graph.xConfig.categoryValues.count, verticalSegmentsCount: graph.yConfig.numberOfSegments)
        
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
                axisView.bindFirstSegment(minValue: "\(config.minValue)", segmentValue: "\(value)", unitOfMeasure: config.unitOfMeasure)
            }
            else {
                axisView.bindSegmentValue(value: "\(value)", unitOfMeasure: config.unitOfMeasure)
            }
            
            if let stackview = type == .horizontal ? graphView.horizontalAxis : graphView.verticalAxis, let view = axisView as? UIView {
                stackview.addArrangedSubview(view)
            }
        }
    }
    
    private func createCategoryAxis(config: CategoryGraphAxisConfig, type: AxisType) {
        
        let categoryValues = type == .horizontal ? config.categoryValues : config.categoryValues.reversed()
        
        for value in categoryValues {
            
            let axisView: AxisView = type == .horizontal ? HorizontalAxisView() : VerticalAxisView()
            
            axisView.bindSegmentValue(value: "\(value)", unitOfMeasure: nil)
            
            if let stackview = type == .horizontal ? graphView.horizontalAxis : graphView.verticalAxis, let view = axisView as? UIView {
                stackview.addArrangedSubview(view)
            }
        }
    }
}
