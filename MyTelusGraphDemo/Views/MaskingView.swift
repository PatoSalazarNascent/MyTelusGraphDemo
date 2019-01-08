import Foundation
import UIKit

internal class MaskingView: UIView {
    
    // MARK: Properties
    
    private var horizontalAxisMinValue: Int?
    private var horizontalAxisMaxValue: Int?
    private var verticalAxisMinValue: Int?
    private var verticalAxisMaxValue: Int?
    
    // MARK: Constructor
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // only called when built from interface builder
    internal required init?(coder aDecoder: NSCoder) {
        
        // call super constructor
        super.init(coder: aDecoder)
    }
    
    // MARK: Internal Methods
    
    internal func initMaskingView(horizontalAxisMinValue: Int, horizontalAxisMaxValue: Int, verticalAxisMinValue: Int, verticalAxisMaxValue: Int) {
        self.horizontalAxisMinValue = horizontalAxisMinValue
        self.horizontalAxisMaxValue = horizontalAxisMaxValue
        self.verticalAxisMinValue = verticalAxisMinValue
        self.verticalAxisMaxValue = verticalAxisMaxValue
    }
    
    internal func addMaskingFill(data: [LineGraphData], color: UIColor, animate: Bool, duration: CFTimeInterval) {
        guard let xMinValue = horizontalAxisMinValue, let xMaxValue = horizontalAxisMaxValue, let yMinValue = verticalAxisMinValue, let yMaxValue = verticalAxisMaxValue else {
            fatalError("x or y min or max value are missing and fill can't be created")
        }
        
        let sortedData = data.sorted(by: { $1.x > $0.x })
        
        if let lastXDataPoint = sortedData.last?.x {
            
            let xDistance = frame.width / CGFloat(xMaxValue - xMinValue)
            let yDistance = frame.height / CGFloat(yMaxValue - yMinValue)
            
            let path = UIBezierPath()
            
            for (index, dataPoint) in sortedData.enumerated() {
                
                let xCoord = (dataPoint.x - CGFloat(xMinValue)) * xDistance
                let yCoord = frame.height - ((dataPoint.y - CGFloat(yMinValue)) * yDistance)
                
                if index == 0 {
                    path.move(to: CGPoint(x: xCoord, y: yCoord))
                }
                else {
                    path.addLine(to: CGPoint(x: xCoord, y: yCoord))
                }
            }
            
             let lastXCoord = (lastXDataPoint - CGFloat(xMinValue)) * xDistance
            
            path.addLine(to: CGPoint(x: lastXCoord, y: frame.height))
            path.addLine(to: CGPoint(x: 0, y: frame.height))
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
