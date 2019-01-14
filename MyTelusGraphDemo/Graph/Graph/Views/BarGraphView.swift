import Foundation
import UIKit

public class BarGraphView: BaseView, GraphViewProtocol {
    
    // MARK: Properties
    
    private var verticalAxisFormatter: ((Double) -> String?)?
    private var horizontalAxisFormatter: ((Double) -> String?)?
    
    // MARK: IBOutlets
    
    @IBOutlet weak public var graphView: GraphView!
    
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
    
    // MARK: Private Methods
    
    private func initBarGraph(_ graph: BarGraph, gridType: GridType) {
        
        graphView.gridView.addGrid(verticalSegmentsCount: graph.xConfig.categoryValues.count, horizontalSegmentsCount: graph.xConfig.categoryValues.count, type: gridType)
        
        graphView.drawableView.initDrawableView(verticalAxis: graph.yConfig, horizontalAxis: graph.xConfig)
        graphView.maskingView.initMaskingView(verticalAxis: graph.yConfig, horizontalAxis: graph.xConfig)
        createCategoryAxis(config: graph.xConfig, type: .horizontal)
        createAxis(config: graph.yConfig, type: .vertical)
        
        requesteLatestFrame()
    }

    private func createAxis(config: NumericGraphAxisConfig, type: AxisType) {
        
        let segmentedValues = type == .horizontal ? config.segmentValues.enumerated() : config.segmentValues.reversed().enumerated()
        
        let initialIndex = type == .horizontal ? 0 : config.segmentValues.count - 1
        
        for (index, value) in segmentedValues {
            
            let axisView: AxisView = type == .horizontal ? HorizontalAxisView() : VerticalAxisView()
            let formattedValue = verticalAxisFormatter?(value) ?? "\(value)"
            
            if index == initialIndex {
                
                let formattedMinValue = verticalAxisFormatter?(Double(config.minValue)) ?? "\(Double(config.minValue))"
                
                axisView.bindInitialNumericSegment(minValue: formattedMinValue, segmentValue: formattedValue, unitOfMeasure: config.unitOfMeasure)
            } else {
                axisView.bindNumericSegment(value: formattedValue, unitOfMeasure: config.unitOfMeasure)
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
