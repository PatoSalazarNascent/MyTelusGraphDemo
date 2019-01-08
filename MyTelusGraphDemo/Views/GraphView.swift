import Foundation
import UIKit

internal class GraphView: CustomView {
    
    // MARK: Constructors
    internal override init() {
        super.init()
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        
        // call super constructor
        super.init(coder: aDecoder)
    }
    
    
    // MARK: IBOUtlets
    
    @IBOutlet internal weak var verticalAxis: UIStackView!
    @IBOutlet internal weak var horizontalAxis: UIStackView!
    
    @IBOutlet internal weak var backgroundView: UIView!
    @IBOutlet internal weak var gridView: GridView!
    @IBOutlet internal weak var maskingView: MaskingView!
    @IBOutlet internal weak var drawableView: DrawableView!
        
    // MARK: Internal Methods
    
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
}
