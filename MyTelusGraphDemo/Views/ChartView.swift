import Foundation
import UIKit

internal class ChartView: CustomView {
    
    // MARK: IBOUtlets
    
    @IBOutlet private weak var verticalAxis: UIStackView!
    @IBOutlet private weak var horizontalAxis: UIStackView!
    
    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet private weak var gridView: GridView!
    @IBOutlet private weak var maskingView: MaskingView!
    @IBOutlet private weak var drawableView: DrawableView!
    
    // MARK: Constructors
    internal override init() {
        super.init()
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        
        // call super constructor
        super.init(coder: aDecoder)
    }
    
    // MARK: Internal Methods
    
    // MARK: ======== COMMOM UI CONFIGURATION =========
    
    internal func setCustomFont(font: UIFont) {
        for view in horizontalAxis.arrangedSubviews {
            if let axisView = view as? AxisView {
                axisView.minValue.font = font
                axisView.value.font = font
            }
        }
        
        for view in verticalAxis.arrangedSubviews {
            if let axisView = view as? AxisView {
                axisView.minValue.font = font
                axisView.value.font = font
            }
        }
    }
    
    internal func setGridColor(color: UIColor?) {
        gridView.setGridColor(color: color)
    }
    
    internal func setChartBackgroundColor(color: UIColor?, alpha: CGFloat) {
        let customColor = color ?? UIColor(red: 239 / 255, green: 239 / 255, blue: 244 / 255, alpha: alpha)
        backgroundView.backgroundColor = customColor
    }
    
    internal func addDataLimit(dataLimit: LineGraphData, color: UIColor, dataLimitType: AxisType) {
        drawableView.addDataLimit(dataLimit: dataLimit, color: color, dataLimitType: dataLimitType)
    }
    
    internal func addChartFill(data: [LineGraphData], color: UIColor) {
        maskingView.addMaskingFill(data: data, color: color, animate: false, duration: 0)
    }
    
    internal func addChartFill(data: [LineGraphData], color: UIColor, animateWithDuration duration: CFTimeInterval) {
        maskingView.addMaskingFill(data: data, color: color, animate: true, duration: duration)
    }
    
    // MARK: ======== LINE CHART ============
    
    internal func initializeLineChart(lineChart: LineGraph, gridType: GridType) {
        commonGraphInit(lineChart: lineChart, gridType: gridType)
    }
    
    internal func drawLineChart(data: [LineGraphData], color: UIColor, lineWidth: CGFloat) {
        drawableView.drawLineChart(data: data, color: color, lineWidth: lineWidth, animated: false, duration: 0)
    }
    
    internal func drawLineChart(data: [LineGraphData], color: UIColor, lineWidth: CGFloat, animateWithDuration duration: CFTimeInterval) {
        drawableView.drawLineChart(data: data, color: color, lineWidth: lineWidth, animated: true, duration: duration)
    }
    
    internal func clearChart() {
        drawableView.clearDrawableView()
        maskingView.clearMaskingView()
    }
    
    // MARK Private Methods
    
    private func commonGraphInit(lineChart: LineGraph, gridType: GridType) {
        gridView.initGrid(horizontalSegmentsCount: lineChart.xConfig.numberOfSegments, verticalSegmentsCount: lineChart.yConfig.numberOfSegments)
        
        drawableView.initDrawableView(horizontalAxisMinValue: lineChart.xConfig.minValue, horizontalAxisMaxValue: lineChart.xConfig.maxValue, verticalAxisMinValue: lineChart.yConfig.minValue, verticalAxisMaxValue: lineChart.yConfig.maxValue)
        
        maskingView.initMaskingView(horizontalAxisMinValue: lineChart.xConfig.minValue, horizontalAxisMaxValue: lineChart.xConfig.maxValue, verticalAxisMinValue: lineChart.yConfig.minValue, verticalAxisMaxValue: lineChart.yConfig.maxValue)
        
        gridView.addGrid(gridType)
        
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
            
            if let stackview = type == .horizontal ? horizontalAxis : verticalAxis, let view = axisView as? UIView {
                stackview.addArrangedSubview(view)
            }
        }
    }
}
