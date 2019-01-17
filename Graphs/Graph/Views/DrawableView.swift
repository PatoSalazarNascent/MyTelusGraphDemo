import Foundation
import UIKit

internal class DrawableView: UIView {
    
    // MARK: Properties
    
    private var verticalAxisValues: (min: Int, max: Int)?
    private var horizontalAxisValues: (min: Int, max: Int)?
    
    // MARK: Internal custom Initializer Methods
    
    internal func initDrawableView(verticalAxisValues: (min: Int, max: Int), horizontalAxisValues: (min: Int, max: Int)) {
        
        self.verticalAxisValues = verticalAxisValues
        self.horizontalAxisValues = horizontalAxisValues
    }
    
    // MARK: Internal Methods
    
    internal func drawBars(data: [BarGraphData], color: UIColor, barWidth: CGFloat, animated: Bool, duration: CFTimeInterval, animationType: BarGraphAnimationType) {
        
//        guard let xValues = horizontalAxisMaxValue, let yMinValue = verticalAxisMinValue, let yMaxValue = verticalAxisMaxValue else {
//            fatalError("x or y min or max value are missing and line can't be created")
//        }
//
//        let xDistance = frame.width / CGFloat(xMaxValue + 1)
//        let yDistance = frame.height / CGFloat(yMaxValue - yMinValue)
//
//        var timeOffset: Double = animationType == .sequence ? 0.2 : 0
//
//        for (index, dataPoint) in data.enumerated() {
//
//            let xCoord = (CGFloat(index + 1)) * xDistance
//            let yCoord = frame.height - ((CGFloat(dataPoint.y) - CGFloat(yMinValue)) * yDistance)
//
//            let roundRect = CGRect(x: xCoord - (barWidth / 2), y: yCoord, width: barWidth, height: frame.height - yCoord)
//
//            let path = UIBezierPath(roundedRect: roundRect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 2, height: 2))
//
//            let shapeLayer = CAShapeLayer()
//            shapeLayer.fillColor = color.cgColor
//
//            if animationType == .sequence {
//                shapeLayer.opacity = 0
//            } else {
//                shapeLayer.opacity = 1
//            }
//
//            shapeLayer.path = path.cgPath
//
//            layer.addSublayer(shapeLayer)
//
//            // animate it
//
//            if animated {
//
//                let translateAnimation = CABasicAnimation(keyPath: "transform.translation.y")
//                translateAnimation.fromValue = frame.height - yCoord
//                translateAnimation.toValue = 0
//                translateAnimation.duration = duration
//                translateAnimation.beginTime = CACurrentMediaTime() + timeOffset
//                shapeLayer.add(translateAnimation, forKey: nil)
//
//                let fadingAnimation = CABasicAnimation(keyPath: "opacity")
//                fadingAnimation.fromValue = 0
//                fadingAnimation.toValue = 1
//                fadingAnimation.duration = duration
//                fadingAnimation.beginTime = CACurrentMediaTime() + timeOffset
//                fadingAnimation.fillMode = .forwards
//                fadingAnimation.isRemovedOnCompletion = false
//                shapeLayer.add(fadingAnimation, forKey: nil)
//
//                if animationType == .sequence {
//                    timeOffset += 0.05
//                }
//            }
//        }
    }
    
    internal func drawLine(data: [LineGraphData], color: UIColor, lineWidth: CGFloat, animated: Bool, duration: CFTimeInterval) {
        
        guard let xValues = horizontalAxisValues, let yValues = verticalAxisValues else {
            fatalError("x or y min or max values are missing and line can't be created")
        }
        
        // make sure that the data is sorted by the x data points in ascending order
        // to match dependent x axis requirements
        let sortData = data.sorted(by: { $1.x > $0.x })
        
        // divide available space into segments in relation with axis values
        let xDistance = frame.width / CGFloat(xValues.max - xValues.min)
        let yDistance = frame.height / CGFloat(yValues.max - yValues.min)
        
        // create path
        let path = UIBezierPath()

        for (index, dataPoint) in sortData.enumerated() {
            
            // data points needs to be adjusted against min values for correspondent axes
            // to address case when axes don't start at zero
            let xCoord = (CGFloat(dataPoint.x) - CGFloat(xValues.min)) * xDistance
            let yCoord = frame.height - ((CGFloat(dataPoint.y) - CGFloat(yValues.min)) * yDistance)
            
            if index == 0 {
                path.move(to: CGPoint(x: xCoord, y: yCoord))
            } else {
                path.addLine(to: CGPoint(x: xCoord, y: yCoord))
            }
        }
        
        // Create Shape layer that will use path to display it in view
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.path = path.cgPath
        
        layer.addSublayer(shapeLayer)
        
        // animate if neccesary
        
        if animated {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.duration = duration
            shapeLayer.add(animation, forKey: nil)
        }
    }
    
    internal func addDataLimit(dataLimit: LineGraphData, color: UIColor, dataLimitType: AxisType) {
        createDataLimitView(dataLimit: dataLimit, color: color, dataLimitType: dataLimitType)
    }
    
    internal func clearDrawableView() {
        if let sublayers = layer.sublayers {
            for sublayer in sublayers {
                sublayer.removeAllAnimations()
                sublayer.removeFromSuperlayer()
            }
        }
    }
    
    // MARK: Private Methods
    
    private func createDataLimitView(dataLimit: LineGraphData, color: UIColor, dataLimitType: AxisType) {
        
//        guard let xMinValue = horizontalAxisMinValue, let xMaxValue = horizontalAxisMaxValue, let yMinValue = verticalAxisMinValue, let yMaxValue = verticalAxisMaxValue else {
//            fatalError("x or y min or max value are missing and line can't be created")
//        }
//
//        let xDistance = frame.width / CGFloat(xMaxValue - xMinValue)
//        let yDistance = frame.height / CGFloat(yMaxValue - yMinValue)
//
//        let dataLimitView = UIView()
//        dataLimitView.backgroundColor = color
//
//        addSubview(dataLimitView)
//
//        if dataLimitType == .vertical {
//            let xCoord = (CGFloat(dataLimit.x) - CGFloat(xMinValue)) * xDistance
//            dataLimitView.frame = CGRect(x: xCoord, y: 0, width: 2, height: bounds.height)
//        } else {
//            let yCoord = (CGFloat(dataLimit.y) - CGFloat(yMinValue)) * yDistance
//             dataLimitView.frame = CGRect(x: 0, y: yCoord, width: bounds.width, height: 2)
//        }
    }
}
