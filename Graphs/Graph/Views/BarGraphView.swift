import Foundation
import UIKit
import Toolkit

public class BarGraphView: BaseView, WithGraphViewProtocol {
    
    // MARK: Properties
    
    private var sortGraph: CategorySorting = .byDefault
    
    // MARK: IBOutlets
    
    @IBOutlet weak public var graphView: GraphView!
    
    // MARK: Internal Methods
    
    public func initializeBarGraph(graph: BarGraph, gridType: GridType, sorted: CategorySorting) {
        // Drawer Helper
        let shapesHelper = ShapesHelper()
        let animationHelper = CABasicAnimationHelper()
        let padding = 1
        
        // horizontal and vertical values
        let verticalAxisValues = (min: graph.yConfig.minValue, max: graph.yConfig.maxValue)
        let horizontalAxisValues = (min: 0, max: graph.xConfig.categoryValues.count)
        
        graphView.gridView.initGridView(verticalSegmentsCount: graph.xConfig.categoryValues.count, horizontalSegmentsCount: graph.xConfig.categoryValues.count + padding, type: gridType)
        
        graphView.drawableView.initDrawableView(verticalAxisValues: verticalAxisValues, horizontalAxisValues: horizontalAxisValues, shapesHelper: shapesHelper, animationHelper: animationHelper)
        
        graphView.maskingView.initMaskingView(verticalAxisValues: verticalAxisValues, horizontalAxisValues: horizontalAxisValues)
        
        // create axis
        graphView.createCategoryAxis(config: graph.xConfig, type: .horizontal, sorted: sorted)
        graphView.createNumericAxis(config: graph.yConfig, type: .vertical)
        
        sortGraph = sorted
        
        // update frame after UI is set and autolayouts have done his thing
        layoutIfNeeded()
    }
    
    public func drawBars(title: String, data: [BarGraphData], color: UIColor, barWidth: CGFloat) {
        
        var sortedData: [BarGraphData] {
            switch sortGraph {
            case .byCategoryAsc:
                return data.sorted(by: { $1.x > $0.x })
            case .byCategoryDesc:
                return data.sorted(by: { $1.x < $0.x })
            case .byDefault:
                return data
            }
        }
        
        graphView.drawableView.drawBars(data: sortedData, color: color, barWidth: barWidth, animated: false, duration: 0)
    }
    
    public func drawBars(title: String, data: [BarGraphData], color: UIColor, barWidth: CGFloat, withAnimationDuration duration: CFTimeInterval) {
        
        graphView.drawableView.drawBars(data: data, color: color, barWidth: barWidth, animated: true, duration: duration)
    }
}
