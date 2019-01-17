import Foundation
import UIKit
import Toolkit

internal class GraphView: BaseView {
    
    // MARK: IBOUtlets
    
    @IBOutlet internal weak var verticalAxis: UIStackView!
    @IBOutlet internal weak var horizontalAxis: UIStackView!
    
    @IBOutlet internal weak var backgroundView: UIView!
    @IBOutlet internal weak var gridView: GridView!
    @IBOutlet internal weak var maskingView: MaskingView!
    @IBOutlet internal weak var drawableView: DrawableView!
        
    // MARK: Internal  Methods
    
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
    
    internal func setGraphBackgroundColor(color: UIColor?, alpha: CGFloat) {
        let customColor = color ?? UIColor(red: 239 / 255, green: 239 / 255, blue: 244 / 255, alpha: alpha)
        backgroundView.backgroundColor = customColor
    }
    
    internal func addDataLimit(dataLimit: LineGraphData, color: UIColor, dataLimitType: AxisType) {
        drawableView.addDataLimit(dataLimit: dataLimit, color: color, dataLimitType: dataLimitType)
    }
    
    internal func addGraphFill(data: [LineGraphData], color: UIColor) {
        maskingView.addMaskingFill(data: data, color: color, animate: false, duration: 0)
    }
    
    internal func addGraphFill(data: [LineGraphData], color: UIColor, animateWithDuration duration: CFTimeInterval) {
        maskingView.addMaskingFill(data: data, color: color, animate: true, duration: duration)
    }
    
    internal func clearGraphData() {
        drawableView.clearDrawableView()
        maskingView.clearMaskingView()
    }
    
    internal func resetGraph() {
        drawableView.clearDrawableView()
        maskingView.clearMaskingView()
        resetAxisValues()
    }
    
    internal func createNumericAxis(config: NumericGraphAxisConfig, type: AxisType) {
        
        let segmentedValues = type == .horizontal ? config.segmentValues.enumerated() : config.segmentValues.reversed().enumerated()
        
        let initialIndex = type == .horizontal ? 0 : config.segmentValues.count - 1
        //let formatter = type == .horizontal ? horizontalAxisFormatter : verticalAxisFormatter
        
        for (index, value) in segmentedValues {
            
            let axisView: AxisView = type == .horizontal ? HorizontalAxisView() : VerticalAxisView()
            
            let formattedValue = "\(value)"
            
            if index == initialIndex {
                
                let formattedMinValue = "\(Double(config.minValue))"
                
                axisView.bindInitialNumericSegment(minValue: formattedMinValue, segmentValue: formattedValue, unitOfMeasure: config.unitOfMeasure)
            } else {
                axisView.bindNumericSegment(value: formattedValue, unitOfMeasure: config.unitOfMeasure)
            }
            
            if let stackview = type == .horizontal ? horizontalAxis : verticalAxis, let view = axisView as? UIView {
                stackview.addArrangedSubview(view)
            }
        }
    }

    // MARK: Private Methods
    
    private func resetAxisValues() {
        for arrangedViews in horizontalAxis.arrangedSubviews {
            horizontalAxis.removeArrangedSubview(arrangedViews)
            arrangedViews.removeFromSuperview()
        }
        
        for arrangedViews in verticalAxis.arrangedSubviews {
            horizontalAxis.removeArrangedSubview(arrangedViews)
            arrangedViews.removeFromSuperview()
        }
    }
}
