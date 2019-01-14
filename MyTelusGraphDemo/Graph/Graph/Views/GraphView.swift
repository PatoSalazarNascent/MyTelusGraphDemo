import Foundation
import UIKit

public class GraphView: BaseView {
    
    // MARK: IBOUtlets
    
    @IBOutlet internal weak var metadataStackview: UIStackView!
    @IBOutlet internal weak var verticalAxis: UIStackView!
    @IBOutlet internal weak var horizontalAxis: UIStackView!
    
    @IBOutlet internal weak var backgroundView: UIView!
    @IBOutlet internal weak var gridView: GridView!
    @IBOutlet internal weak var maskingView: MaskingView!
    @IBOutlet internal weak var drawableView: DrawableView!
        
    // MARK: Internal Methods
    
    public func setCustomFont(font: UIFont) {
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
        
    public func setGridColor(color: UIColor?) {
        gridView.setGridColor(color: color)
    }
    
    public func setGraphBackgroundColor(color: UIColor?, alpha: CGFloat) {
        let customColor = color ?? UIColor(red: 239 / 255, green: 239 / 255, blue: 244 / 255, alpha: alpha)
        backgroundView.backgroundColor = customColor
    }
    
    public func addDataLimit(dataLimit: LineGraphData, color: UIColor, dataLimitType: AxisType) {
        drawableView.addDataLimit(dataLimit: dataLimit, color: color, dataLimitType: dataLimitType)
    }
    
    public func addGraphFill(data: [LineGraphData], color: UIColor) {
        maskingView.addMaskingFill(data: data, color: color, animate: false, duration: 0)
    }
    
    public func addGraphFill(data: [LineGraphData], color: UIColor, animateWithDuration duration: CFTimeInterval) {
        maskingView.addMaskingFill(data: data, color: color, animate: true, duration: duration)
    }
    
    public func addMetaData(iconColor: UIColor, text: String) {
        
        let metaView = GraphMetaDataView()
        metaView.bindMetaData(iconColor: iconColor, text: text)
        
        metadataStackview.addArrangedSubview(metaView)
    }
    
    public func addMetaData(iconImage: String, text: String) {
        
        let metaView = GraphMetaDataView()
        metaView.bindMetaData(iconImage: iconImage, text: text)
        
        metadataStackview.addArrangedSubview(metaView)
    }
    
    public func clearGraphData() {
        drawableView.clearDrawableView()
        maskingView.clearMaskingView()
        clearMetaData()
    }
    
    public func resetGraph() {
        drawableView.clearDrawableView()
        maskingView.clearMaskingView()
        clearMetaData()
        resetAxisValues()
    }
    
    // MARK: Private Methods
    
    private func clearMetaData() {
        for arrangedViews in metadataStackview.arrangedSubviews {
            metadataStackview.removeArrangedSubview(arrangedViews)
            arrangedViews.removeFromSuperview()
        }
    }
    
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
