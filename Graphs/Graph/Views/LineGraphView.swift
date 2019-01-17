import Foundation
import UIKit
import Toolkit

public class LineGraphView: BaseView, GraphViewProtocol {
    
    // MARK: Properties
    
    private var verticalAxisFormatter: ((Double) -> String?)?
    private var horizontalAxisFormatter: ((Double) -> String?)?
    
    // MARK: IBOutlet
    
    @IBOutlet public weak var graphView: GraphView!
    
    // MARK: Internal Methods
    
    public func addFormatter(_ formatter: @escaping ((Double) -> String?), for axis: AxisType) {
        
        if axis == .vertical {
            verticalAxisFormatter = formatter
        } else {
            horizontalAxisFormatter = formatter
        }
    }
    
    public func initializeLineGraph(_ graph: LineGraph, gridType: GridType) {
        
        // Resolve dependencies for LineGraph
        
        // Drawer Helper
        let shapesHelper = ShapesHelper()
        
        // horizontal and vertical values
        let verticalAxisValues = (min: graph.yConfig.minValue, max: graph.yConfig.maxValue)
        let horizontalAxisValues = (min: graph.xConfig.minValue, max: graph.xConfig.maxValue)
        
        // creates grid layer
        graphView.gridView.initGridView(verticalSegmentsCount: graph.yConfig.numberOfSegments, horizontalSegmentsCount: graph.xConfig.numberOfSegments, type: gridType)
        
        // gives basic data to drawable view
        graphView.drawableView.initDrawableView(verticalAxisValues: verticalAxisValues, horizontalAxisValues: horizontalAxisValues, shapesHelper: shapesHelper)
        
        // publico masking view
        graphView.maskingView.initMaskingView(verticalAxisValues: verticalAxisValues, horizontalAxisValues: horizontalAxisValues)
        
        // create axis
        graphView.createNumericAxis(config: graph.xConfig, type: .horizontal)
        graphView.createNumericAxis(config: graph.yConfig, type: .vertical)
        
        // update frame after UI is set and autolayouts have done his thing
        layoutIfNeeded()
    }
    
    public func drawLine(title: String, data: [LineGraphData], color: UIColor, lineWidth: CGFloat) {
        graphView.drawableView.drawLine(data: data, color: color, lineWidth: lineWidth, animated: false, duration: 0)
    }
    
    public func drawLine(title: String, data: [LineGraphData], color: UIColor, lineWidth: CGFloat, animateWithDuration duration: CFTimeInterval) {
        graphView.drawableView.drawLine(data: data, color: color, lineWidth: lineWidth, animated: true, duration: duration)
    }    
}
