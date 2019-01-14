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
        initLineGraph(lineGraph: lineGraph, gridType: gridType)
    }
    
    public func drawLine(title: String, data: [LineGraphData], color: UIColor, lineWidth: CGFloat) {
        
        setNeedsLayout()
        layoutIfNeeded()
        
        graphView.drawableView.drawLine(data: data, color: color, lineWidth: lineWidth, animated: false, duration: 0)
    }
    
    public func drawLine(title: String, data: [LineGraphData], color: UIColor, lineWidth: CGFloat, animateWithDuration duration: CFTimeInterval) {
        
        setNeedsLayout()
        layoutIfNeeded()
        
        graphView.drawableView.drawLine(data: data, color: color, lineWidth: lineWidth, animated: true, duration: duration)
        
        //graphView.addMetaData(iconColor: color, text: title)
    }
    
    // MARK: Private Methods
    
    private func initLineGraph(lineGraph: LineGraph, gridType: GridType) {
        
        graphView.gridView.addGrid(verticalSegmentsCount: lineGraph.yConfig.numberOfSegments, horizontalSegmentsCount: lineGraph.xConfig.numberOfSegments, type: gridType)
        
        graphView.drawableView.initDrawableView(verticalAxis: lineGraph.yConfig, horizontalAxis: lineGraph.xConfig)
        
        graphView.maskingView.initMaskingView(verticalAxis: lineGraph.yConfig, horizontalAxis: lineGraph.xConfig)
        
        createAxis(config: lineGraph.xConfig, type: .horizontal)
        createAxis(config: lineGraph.yConfig, type: .vertical)
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
