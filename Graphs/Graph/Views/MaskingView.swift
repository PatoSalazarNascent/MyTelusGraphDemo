import Foundation
import UIKit

public class MaskingView: UIView {
    
    // MARK: Properties
    
    private var verticalAxisValues: (min: Int, max: Int)?
    private var horizontalAxisValues: (min: Int, max: Int)?
    
    // MARK: Internal Methods
    
    public func initMaskingView(verticalAxisValues: (min: Int, max: Int), horizontalAxisValues: (min: Int, max: Int)) {
        self.verticalAxisValues = verticalAxisValues
        self.horizontalAxisValues = horizontalAxisValues
    }
    

    
    public func addMaskingFill(data: [LineGraphData], color: UIColor, animate: Bool, duration: CFTimeInterval) {
        guard let xValues = horizontalAxisValues, let yValues = verticalAxisValues else {
            fatalError("x or y min or max value are missing and fill can't be created")
        }
        
        let sortedData = data.sorted(by: { $1.x > $0.x })
        
        if let lastXDataPoint = sortedData.last?.x {
            
            let xDistance = frame.width / CGFloat(xValues.max - xValues.min)
            let yDistance = frame.height / CGFloat(yValues.max - yValues.min)
            
            let path = UIBezierPath()
            
            for (index, dataPoint) in sortedData.enumerated() {
                
                let xCoord = (CGFloat(dataPoint.x) - CGFloat(xValues.min)) * xDistance
                let yCoord = frame.height - ((CGFloat(dataPoint.y) - CGFloat(yValues.min)) * yDistance)
                
                if index == 0 {
                    path.move(to: CGPoint(x: xCoord, y: yCoord))
                } else {
                    path.addLine(to: CGPoint(x: xCoord, y: yCoord))
                }
            }
            
             let lastXCoord = (CGFloat(lastXDataPoint) - CGFloat(xValues.min)) * xDistance
            
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
