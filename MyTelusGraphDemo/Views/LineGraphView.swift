import Foundation
import UIKit

internal class LineGraphView: CustomView {
    
    // MARK IBOulet
    
    @IBOutlet weak private var graphView: GraphView!
    
    // MARK: Internal Methods
    
    internal func initializeLineGraph(lineChart: LineGraph, gridType: GridType) {
        commonGraphInit(lineChart: lineChart, gridType: gridType)
    }
    
    internal func drawLine(data: [LineGraphData], color: UIColor, lineWidth: CGFloat) {
        graphView.drawableView.drawLine(data: data, color: color, lineWidth: lineWidth, animated: false, duration: 0)
    }
    
    internal func drawLine(data: [LineGraphData], color: UIColor, lineWidth: CGFloat, animateWithDuration duration: CFTimeInterval) {
        graphView.drawableView.drawLine(data: data, color: color, lineWidth: lineWidth, animated: true, duration: duration)
    }
    
    internal func clearGraph() {
        graphView.drawableView.clearDrawableView()
        graphView.maskingView.clearMaskingView()
    }
    
    internal func setCustomFont(font: UIFont) {
        graphView.setCustomFont(font: font)
    }
    
    internal func setGridColor(color: UIColor?) {
        graphView.setGridColor(color: color)
    }
    
    internal func setGraphBackgroundColor(color: UIColor?, alpha: CGFloat) {
        graphView.setGraphBackgroundColor(color: color, alpha: alpha)
    }
    
    internal func addDataLimit(dataLimit: LineGraphData, color: UIColor, dataLimitType: AxisType) {
        graphView.addDataLimit(dataLimit: dataLimit, color: color, dataLimitType: dataLimitType)
    }
    
    internal func addGraphFill(data: [LineGraphData], color: UIColor) {
        graphView.addGraphFill(data: data, color: color)
    }
    
    internal func addGraphFill(data: [LineGraphData], color: UIColor, animateWithDuration duration: CFTimeInterval) {
        graphView.addGraphFill(data: data, color: color, animateWithDuration: duration)
    }
    
    // MARK Private Methods
    
    private func commonGraphInit(lineChart: LineGraph, gridType: GridType) {
        graphView.gridView.initGrid(horizontalSegmentsCount: lineChart.xConfig.numberOfSegments, verticalSegmentsCount: lineChart.yConfig.numberOfSegments)
        
        graphView.drawableView.initDrawableView(horizontalAxisMinValue: lineChart.xConfig.minValue, horizontalAxisMaxValue: lineChart.xConfig.maxValue, verticalAxisMinValue: lineChart.yConfig.minValue, verticalAxisMaxValue: lineChart.yConfig.maxValue)
        
        graphView.maskingView.initMaskingView(horizontalAxisMinValue: lineChart.xConfig.minValue, horizontalAxisMaxValue: lineChart.xConfig.maxValue, verticalAxisMinValue: lineChart.yConfig.minValue, verticalAxisMaxValue: lineChart.yConfig.maxValue)
        
        graphView.gridView.addGrid(gridType)
        
        createAxis(config: lineChart.xConfig, type: .horizontal)
        createAxis(config: lineChart.yConfig, type: .vertical)
        
        
        // call ui cycle to allow logic access component frame after autolayouts adjustments
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    private func createAxis(config: LineGraphAxisConfig, type: AxisType) {
        
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
    
}
