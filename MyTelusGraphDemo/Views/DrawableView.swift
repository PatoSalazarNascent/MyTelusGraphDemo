
import Foundation
import UIKit

internal class DrawableView: UIView {
    
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
    
    // MARK: Internal custom Initializer Methods
    
    internal func initDrawableView(verticalAxis: NumericGraphAxisConfig, horizontalAxis: NumericGraphAxisConfig) {
        self.verticalAxisMinValue = verticalAxis.minValue
        self.verticalAxisMaxValue = verticalAxis.maxValue
        self.horizontalAxisMinValue = horizontalAxis.minValue
        self.horizontalAxisMaxValue = horizontalAxis.maxValue
    }
    
    internal func initDrawableView(verticalAxis: NumericGraphAxisConfig, horizontalAxis: CategoryGraphAxisConfig) {
        self.verticalAxisMinValue = verticalAxis.minValue
        self.verticalAxisMaxValue = verticalAxis.maxValue
        self.horizontalAxisMinValue = 0
        self.horizontalAxisMaxValue = horizontalAxis.categoryValues.count
    }
    
    // MARK: Internal Methods
    
    internal func drawBars(data: [BarGraphData], color: UIColor, barWidth: CGFloat, animated: Bool, duration: CFTimeInterval) {
        
        guard let xMinValue = horizontalAxisMinValue, let xMaxValue = horizontalAxisMaxValue, let yMinValue = verticalAxisMinValue, let yMaxValue = verticalAxisMaxValue else {
            fatalError("x or y min or max value are missing and line can't be created")
        }
        
        let xDistance = frame.width / CGFloat(xMaxValue + 1)
        let yDistance = frame.height / CGFloat(yMaxValue - yMinValue)
        
        for (index, dataPoint) in data.enumerated() {
            
            let xCoord = (CGFloat(index + 1)) * xDistance
            let yCoord = frame.height - ((dataPoint.y - CGFloat(yMinValue)) * yDistance)
            
            let path = UIBezierPath(roundedRect: CGRect(x: xCoord - (barWidth / 2), y: yCoord, width: barWidth, height: frame.height - yCoord), byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 2, height: 2))
        
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.fillColor = color.cgColor
            shapeLayer.path = path.cgPath
            
            layer.addSublayer(shapeLayer)
            
        }
    
        // animate it
        
//        if animated {
//            let animation = CABasicAnimation(keyPath: "strokeEnd")
//            animation.fromValue = 0
//            animation.duration = duration
//            shapeLayer.add(animation, forKey: "lineGraphAnimation")
//        }
        
    }
    
    internal func drawLine(data: [LineGraphData], color: UIColor, lineWidth: CGFloat, animated: Bool, duration: CFTimeInterval) {
        
        guard let xMinValue = horizontalAxisMinValue, let xMaxValue = horizontalAxisMaxValue, let yMinValue = verticalAxisMinValue, let yMaxValue = verticalAxisMaxValue else {
            fatalError("x or y min or max value are missing and line can't be created")
        }
    
        let sortData = data.sorted(by: { $1.x > $0.x })
        
        let xDistance = frame.width / CGFloat(xMaxValue - xMinValue)
        let yDistance = frame.height / CGFloat(yMaxValue - yMinValue)
        
        let path = UIBezierPath()
        
        for (index, dataPoint) in sortData.enumerated() {
            
            let xCoord = (dataPoint.x - CGFloat(xMinValue)) * xDistance
            let yCoord = frame.height - ((dataPoint.y - CGFloat(yMinValue)) * yDistance)
            
            if index == 0 {
                path.move(to: CGPoint(x: xCoord, y: yCoord))
            }
            else {
                path.addLine(to: CGPoint(x: xCoord, y: yCoord))
            }
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.path = path.cgPath
        
        layer.addSublayer(shapeLayer)
        
        // animate it
        
        if animated {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.duration = duration
            shapeLayer.add(animation, forKey: "lineGraphAnimation")
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
        
        guard let xMinValue = horizontalAxisMinValue, let xMaxValue = horizontalAxisMaxValue, let yMinValue = verticalAxisMinValue, let yMaxValue = verticalAxisMaxValue else {
            fatalError("x or y min or max value are missing and line can't be created")
        }
        
        let xDistance = frame.width / CGFloat(xMaxValue - xMinValue)
        let yDistance = frame.height / CGFloat(yMaxValue - yMinValue)
        
        let dataLimitView = UIView()
        dataLimitView.backgroundColor = color
        
        addSubview(dataLimitView)
        
        if dataLimitType == .vertical {
            let xCoord = (dataLimit.x - CGFloat(xMinValue)) * xDistance
            dataLimitView.frame = CGRect(x: xCoord, y: 0, width: 1, height: bounds.height)
        }
        else {
            let yCoord = (dataLimit.y - CGFloat(yMinValue)) * yDistance
             dataLimitView.frame = CGRect(x: 0, y: yCoord, width: bounds.width, height: 1)
        }
    }
}
