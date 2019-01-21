import Foundation
import UIKit

internal class MaskingView: UIView {
    
    // MARK: Properties
    
    private var verticalAxisValues: (min: Int, max: Int)!
    private var horizontalAxisValues: (min: Int, max: Int)!
    
    private var xDistance: CGFloat {
        return frame.width / CGFloat(horizontalAxisValues.max - horizontalAxisValues.min)
    }
    
    private var yDistance: CGFloat {
        return frame.height / CGFloat(verticalAxisValues.max - verticalAxisValues.min)
    }
    
    // MARK: Internal Methods
    
    internal func initMaskingView(verticalAxisValues: (min: Int, max: Int), horizontalAxisValues: (min: Int, max: Int)) {
        self.verticalAxisValues = verticalAxisValues
        self.horizontalAxisValues = horizontalAxisValues
    }
    
    internal func addMaskingFill(data: [LineGraphData], color: UIColor, animate: Bool, duration: CFTimeInterval) {

        let sortedData = data.sorted(by: { $1.x > $0.x })
        
        if let lastXDataPoint = sortedData.last?.x {
                        
            let path = UIBezierPath()
            
            for (index, dataPoint) in sortedData.enumerated() {
                
                let xCoord = (CGFloat(dataPoint.x) - CGFloat(horizontalAxisValues.min)) * xDistance
                let yCoord = frame.height - ((CGFloat(dataPoint.y) - CGFloat(verticalAxisValues.min)) * yDistance)
                
                if index == 0 {
                    path.move(to: CGPoint(x: xCoord, y: yCoord))
                } else {
                    path.addLine(to: CGPoint(x: xCoord, y: yCoord))
                }
            }
            
             let lastXCoord = (CGFloat(lastXDataPoint) - CGFloat(horizontalAxisValues.min)) * xDistance
            
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
    
    internal func clearMaskingView() {
        layer.mask = nil
        backgroundColor = .clear
    }
}
