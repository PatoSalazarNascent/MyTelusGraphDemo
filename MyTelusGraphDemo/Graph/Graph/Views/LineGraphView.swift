import Foundation
import UIKit

public class LineGraphView: BaseView, GraphViewProtocol {
    
    // MARK: Properties
    
    private var verticalAxisFormatter: ((Double) -> String?)?
    private var horizontalAxisFormatter: ((Double) -> String?)?
    
    // MARK: IBOulet
    
    @IBOutlet weak public var graphView: GraphView!
    
    // MARK: Internal Methods
    
    public func addFormatter(_ formatter: @escaping ((Double) -> String?), for axis: AxisType) {
        
        if axis == .vertical {
            verticalAxisFormatter = formatter
        } else {
            horizontalAxisFormatter = formatter
        }
    }
    
    public func initializeLineGraph(lineGraph: LineGraph, gridType: GridType) {
        initLineGraph(lineGraph, gridType: gridType)
    }
    
    public func drawLine(title: String, data: [LineGraphData], color: UIColor, lineWidth: CGFloat) {
        
        graphView.drawableView.drawLine(data: data, color: color, lineWidth: lineWidth, animated: false, duration: 0)
    }
    
    public func drawLine(title: String, data: [LineGraphData], color: UIColor, lineWidth: CGFloat, animateWithDuration duration: CFTimeInterval) {
        
        graphView.drawableView.drawLine(data: data, color: color, lineWidth: lineWidth, animated: true, duration: duration)
    }
    
    // MARK: Private Methods
    
    private func initLineGraph(_ graph: LineGraph, gridType: GridType) {
        
        graphView.gridView.addGrid(verticalSegmentsCount: graph.yConfig.numberOfSegments, horizontalSegmentsCount: graph.xConfig.numberOfSegments, type: gridType)
        
        graphView.drawableView.initDrawableView(verticalAxis: graph.yConfig, horizontalAxis: graph.xConfig)
        
        graphView.maskingView.initMaskingView(verticalAxis: graph.yConfig, horizontalAxis: graph.xConfig)
        
        createAxis(config: graph.xConfig, type: .horizontal)
        createAxis(config: graph.yConfig, type: .vertical)
        
        requesteLatestFrame()
    }
    
    private func createAxis(config: NumericGraphAxisConfig, type: AxisType) {
        
        let segmentedValues = type == .horizontal ? config.segmentValues.enumerated() : config.segmentValues.reversed().enumerated()
        
        let initialIndex = type == .horizontal ? 0 : config.segmentValues.count - 1
        let formatter = type == .horizontal ? horizontalAxisFormatter : verticalAxisFormatter
        
        for (index, value) in segmentedValues {
            
            let axisView: AxisView = type == .horizontal ? HorizontalAxisView() : VerticalAxisView()
            
            let formattedValue = formatter?(value) ?? "\(value)"
            
            if index == initialIndex {
                
                let formattedMinValue = formatter?(Double(config.minValue)) ?? "\(Double(config.minValue))"
                
                axisView.bindInitialNumericSegment(minValue: formattedMinValue, segmentValue: formattedValue, unitOfMeasure: config.unitOfMeasure)
            } else {
                axisView.bindNumericSegment(value: formattedValue, unitOfMeasure: config.unitOfMeasure)
            }
            
            if let stackview = type == .horizontal ? graphView.horizontalAxis : graphView.verticalAxis, let view = axisView as? UIView {
                stackview.addArrangedSubview(view)
            }
        }
    }
}
