import Foundation
import UIKit
import Toolkit

internal class DrawableView: UIView {
    
    // MARK: Properties
    
    private var animationHelper: CABasicAnimationHelper!
    private var shapesHelper: ShapesHelper!
    private var verticalAxisValues: (min: Int, max: Int)!
    private var horizontalAxisValues: (min: Int, max: Int)!
    
    private var xDistance: CGFloat {
        return frame.width / CGFloat(horizontalAxisValues.max - horizontalAxisValues.min)
    }
    
    private var yDistance: CGFloat {
        return frame.height / CGFloat(verticalAxisValues.max - verticalAxisValues.min)
    }
    
    // MARK: Internal custom Initializer Methods
    
    internal func initDrawableView(verticalAxisValues: (min: Int, max: Int), horizontalAxisValues: (min: Int, max: Int), shapesHelper: ShapesHelper, animationHelper: CABasicAnimationHelper) {
        
        self.verticalAxisValues = verticalAxisValues
        self.horizontalAxisValues = horizontalAxisValues
        self.shapesHelper = shapesHelper
        self.animationHelper = animationHelper
    }
    
    // MARK: Internal Methods
    
    internal func drawBars(data: [BarGraphData], color: UIColor, barWidth: CGFloat, animated: Bool, duration: CFTimeInterval, animationType: BarGraphAnimationType) {
        
        //var timeOffset: Double = animationType == .sequence ? 0.2 : 0

        for (index, dataPoint) in data.enumerated() {

            let xCoord = (CGFloat(index + 1)) * xDistance
            let yCoord = frame.height - ((CGFloat(dataPoint.y) - CGFloat(verticalAxisValues.min)) * yDistance)

            let rect = CGRect(x: xCoord - (barWidth / 2), y: yCoord, width: barWidth, height: frame.height - yCoord)

            let shapeLayer = shapesHelper.getRectShape(from: rect, withRoundedCorners: [.topLeft, .topRight], radius: 2, color: color)

            layer.addSublayer(shapeLayer)

            // animate it

//            if animated {
//
//                let translateAnimation = CABasicAnimation(keyPath: "transform.translation.y")
//                translateAnimation.fromValue = frame.height
//                translateAnimation.toValue = -(frame.height - yCoord)
//                //translateAnimation.isRemovedOnCompletion = false
//                translateAnimation.fillMode = .forwards
//                translateAnimation.duration = 3
//                translateAnimation.beginTime = CACurrentMediaTime() + timeOffset
//                shapeLayer.add(translateAnimation, forKey: nil)
//
//                if animationType == .sequence {
//                    timeOffset += 0.05
//                }
//            }
        }
    }
    
    internal func drawLine(data: [LineGraphData], color: UIColor, lineWidth: CGFloat, animated: Bool, duration: CFTimeInterval) {
        
        // make sure that the data is sorted by the x data points in ascending order
        // to match dependent x axis requirements
        let sortData = data.sorted(by: { $1.x > $0.x })
        
        // create cgPoints from x and y coodinates
        let coordinates = sortData.map { dataPoint -> CGPoint in
            let xCoord = (CGFloat(dataPoint.x) - CGFloat(horizontalAxisValues.min)) * xDistance
            let yCoord = frame.height - ((CGFloat(dataPoint.y) - CGFloat(verticalAxisValues.min)) * yDistance)
            
            return CGPoint(x: xCoord, y: yCoord)
        }
    
        // create shape
        let shape = shapesHelper.getLineShape(from: coordinates, color: color, lineWidth: lineWidth)
                
        layer.addSublayer(shape)
        
        // animate if neccesary
        if animated {
            animationHelper.addStrokeEndAnimation(to: shape, duration: duration)
        }
    }
    
    internal func addDataLimit(dataLimit: LineGraphData, color: UIColor, axis: AxisType) {
        
        guard let xValues = horizontalAxisValues, let yValues = verticalAxisValues else {
            fatalError("x or y min or max values are missing and dataLimit can't be created")
        }
        
        var rect: CGRect {
            if axis == .vertical {
                let xCoord = (CGFloat(dataLimit.x) - CGFloat(xValues.min)) * xDistance
                return CGRect(x: xCoord, y: 0, width: 1.5, height: bounds.height)
            } else {
                let yCoord = (CGFloat(dataLimit.y) - CGFloat(yValues.min)) * yDistance
                return CGRect(x: 0, y: yCoord, width: bounds.width, height: 1.5)
            }
        }
        
        let shape = shapesHelper.getRectShape(from: rect, color: color)
        
        layer.addSublayer(shape)
    }
    
    internal func clearDrawableView() {
        if let sublayers = layer.sublayers {
            for sublayer in sublayers {
                sublayer.removeAllAnimations()
                sublayer.removeFromSuperlayer()
            }
        }
    }
}
