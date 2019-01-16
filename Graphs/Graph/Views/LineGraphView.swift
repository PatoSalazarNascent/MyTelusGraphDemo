import Foundation
import UIKit
import Toolkit

public class LineGraphView: BaseView {
    
    // MARK: Properties
    
    private var verticalAxisFormatter: ((Double) -> String?)?
    private var horizontalAxisFormatter: ((Double) -> String?)?
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var graphView: GraphView!
    
    // MARK: Internal Methods
    
    public func addFormatter(_ formatter: @escaping ((Double) -> String?), for axis: AxisType) {
        
        if axis == .vertical {
            verticalAxisFormatter = formatter
        } else {
            horizontalAxisFormatter = formatter
        }
    }
    
    public func initializeLineGraph(_ graph: LineGraph, gridType: GridType) {
        
        // horizontal and vertical values
        let verticalAxisValues = (min: graph.yConfig.minValue, max: graph.yConfig.maxValue)
        let horizontalAxisValues = (min: graph.xConfig.minValue, max: graph.xConfig.maxValue)
        
        // creates grid layer
        graphView.gridView.initGridView(verticalSegmentsCount: graph.yConfig.numberOfSegments, horizontalSegmentsCount: graph.xConfig.numberOfSegments, type: gridType)
        
        // gives basic data to drawable view
        graphView.drawableView.initDrawableView(verticalAxisValues: verticalAxisValues, horizontalAxisValues: horizontalAxisValues)
        
        // give basic data to masking view
        graphView.maskingView.initMaskingView(verticalAxisValues: verticalAxisValues, horizontalAxisValues: horizontalAxisValues)
        
        // create axis
        graphView.createNumericAxis(config: graph.xConfig, type: .horizontal)
        graphView.createNumericAxis(config: graph.yConfig, type: .vertical)
    }
    
    public func drawLine(title: String, data: [LineGraphData], color: UIColor, lineWidth: CGFloat) {

    }
    
    public func drawLine(title: String, data: [LineGraphData], color: UIColor, lineWidth: CGFloat, animateWithDuration duration: CFTimeInterval) {
        
    }    
}
