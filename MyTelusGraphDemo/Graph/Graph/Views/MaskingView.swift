import Foundation
import UIKit

public class MaskingView: UIView {
    
    // MARK: Properties
    
    private var horizontalAxisMinValue: Int?
    private var horizontalAxisMaxValue: Int?
    private var verticalAxisMinValue: Int?
    private var verticalAxisMaxValue: Int?
    
    // MARK: Internal Methods
    
    public func initMaskingView(verticalAxis: NumericGraphAxisConfig, horizontalAxis: NumericGraphAxisConfig) {
        self.verticalAxisMinValue = verticalAxis.minValue
        self.verticalAxisMaxValue = verticalAxis.maxValue
        self.horizontalAxisMinValue = horizontalAxis.minValue
        self.horizontalAxisMaxValue = horizontalAxis.maxValue
    }
    
    public func initMaskingView(verticalAxis: NumericGraphAxisConfig, horizontalAxis: CategoryGraphAxisConfig) {
        self.verticalAxisMinValue = verticalAxis.minValue
        self.verticalAxisMaxValue = verticalAxis.maxValue
        self.horizontalAxisMinValue = 0
        self.horizontalAxisMaxValue = horizontalAxis.categoryValues.count
    }
    
    public func addMaskingFill(data: [LineGraphData], color: UIColor, animate: Bool, duration: CFTimeInterval) {
        guard let xMinValue = horizontalAxisMinValue, let xMaxValue = horizontalAxisMaxValue, let yMinValue = verticalAxisMinValue, let yMaxValue = verticalAxisMaxValue else {
            fatalError("x or y min or max value are missing and fill can't be created")
        }
        
        let sortedData = data.sorted(by: { $1.x > $0.x })
        
        if let lastXDataPoint = sortedData.last?.x {
            
            let xDistance = frame.width / CGFloat(xMaxValue - xMinValue)
            let yDistance = frame.height / CGFloat(yMaxValue - yMinValue)
            
            let path = UIBezierPath()
            
            for (index, dataPoint) in sortedData.enumerated() {
                
                let xCoord = (CGFloat(dataPoint.x) - CGFloat(xMinValue)) * xDistance
                let yCoord = frame.height - ((CGFloat(dataPoint.y) - CGFloat(yMinValue)) * yDistance)
                
                if index == 0 {
                    path.move(to: CGPoint(x: xCoord, y: yCoord))
                } else {
                    path.addLine(to: CGPoint(x: xCoord, y: yCoord))
                }
            }
            
             let lastXCoord = (CGFloat(lastXDataPoint) - CGFloat(xMinValue)) * xDistance
            
            path.addLine(to: CGPoint(x: lastXCoord, y: frame.height))
            path.addLine(to: CGPoint(x: CGFloat(data.first?.x ?? 0.0), y: frame.height))
            path.close()
            path.miterLimit = 4
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            
            backgroundColor = color
            layer.mask = shapeLayer

            // animate
            let opacityAnimation = CABasicAnimation(keyPath: "opacity")
            opacityAnimation.fromValue = 0
            opacityAnimation.toValue = 1
            opacityAnimation.duration = duration
            shapeLayer.add(opacityAnimation, forKey: "")
        }
    }
    
    public func clearMaskingView() {
        layer.mask = nil
        backgroundColor = .clear
    }
}
