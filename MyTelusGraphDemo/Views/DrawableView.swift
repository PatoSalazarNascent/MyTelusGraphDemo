
import Foundation
import UIKit

internal class DrawableView: UIView {
    
    // MARK: Properties
    private var horizontalMaxValue: Int?
    private var verticalMaxValue: Int?
    
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
    
    internal func initDrawableView(horizontalMaxValue: Int, verticalMaxValue: Int) {
        self.horizontalMaxValue = horizontalMaxValue
        self.verticalMaxValue = verticalMaxValue
    }
    
    internal func drawLineChart(data: [LineChartData]) {
        
        guard let xMaxValue = horizontalMaxValue, let yMaxValue = verticalMaxValue else {
            fatalError("x or y value count is missing and line can't be created")
        }
        
        let sortData = data.sorted(by: { $1.x > $0.x })
        
        let xDistance = frame.width / CGFloat(xMaxValue)
        let yDistance = frame.height / CGFloat(yMaxValue)
        
        let path = UIBezierPath()
        
        for (index, dataPoint) in sortData.enumerated() {
            
            let xCoord = dataPoint.x * xDistance
            let yCoord = frame.height - (dataPoint.y * yDistance)
            
            if index == 0 {
                path.move(to: CGPoint(x: xCoord, y: yCoord))
            }
            else {
                path.addLine(to: CGPoint(x: xCoord, y: yCoord))
            }
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1).cgColor
        shapeLayer.lineWidth = 4
        shapeLayer.path = path.cgPath
        
        layer.addSublayer(shapeLayer)
        
        // animate it
//        
//        layer.addSublayer(shapeLayer)
//        let animation = CABasicAnimation(keyPath: "strokeEnd")
//        animation.fromValue = 0
//        animation.duration = 0.8
//        shapeLayer.add(animation, forKey: "MyAnimation")
    }
}
