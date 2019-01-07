
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
    
    // MARK: Internal Methods
    
    internal func initDrawableView(horizontalAxisMinValue: Int, horizontalAxisMaxValue: Int, verticalAxisMinValue: Int, verticalAxisMaxValue: Int) {
        self.horizontalAxisMinValue = horizontalAxisMinValue
        self.horizontalAxisMaxValue = horizontalAxisMaxValue
        self.verticalAxisMinValue = verticalAxisMinValue
        self.verticalAxisMaxValue = verticalAxisMaxValue
    }
    
    internal func drawLineChart(data: [LineGraphData]) {
        
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
        shapeLayer.strokeColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1).cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.path = path.cgPath
        
        layer.addSublayer(shapeLayer)
        
        // animate it
        
        layer.addSublayer(shapeLayer)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 1
        shapeLayer.add(animation, forKey: "lineChartAnimation")
    }
}
