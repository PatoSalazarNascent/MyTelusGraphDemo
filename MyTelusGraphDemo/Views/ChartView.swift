import Foundation
import UIKit

internal class ChartView: CustomView {
        
    // MARK: Instance Properties
    
    // MARK: IBOUtlets
    
    @IBOutlet private weak var verticalAxis: UIStackView!
    @IBOutlet private weak var horizontalAxis: UIStackView!
    @IBOutlet private weak var gridView: GridView!
    @IBOutlet private weak var drawableView: DrawableView!
    
    
    internal override init() {
        super.init()
    }
    
    // only called when built from interface builder
    internal required init?(coder aDecoder: NSCoder) {
        
        // call super constructor
        super.init(coder: aDecoder)
    }
    
    // MARK: Internal Methods
    
    internal func initializeLineChart(lineChart: LineGraph, gridType: GridType) {
        gridView.initGrid(xSegmentsCount: lineChart.xConfig.numberOfSegments, ySegmentsCount: lineChart.yConfig.numberOfSegments)
        drawableView.initDrawableView(horizontalMaxValue: lineChart.xConfig.maxValue, verticalMaxValue: lineChart.yConfig.maxValue)
        gridView.addGrid(gridType)
        
        createAxis(config: lineChart.xConfig, type: .horizontal)
        createAxis(config: lineChart.yConfig, type: .vertical)
    }
    
    internal func drawLineChart(data: [LineGraphData]) {
       drawableView.drawLineChart(data: data)
    }
    
    // MARK Private Methods
    
    
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
