
import Foundation
import UIKit

internal class DrawableView: UIView {
    
    // MARK: Properties
    
    private var xValuesCount: CGFloat?
    private var yValuesCount: CGFloat?
    let path = UIBezierPath()
    
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
    
    internal func initDrawable(xCount: CGFloat, yCount: CGFloat) {
        self.xValuesCount = xCount
        self.yValuesCount = yCount
    }
    
    internal func drawLineChart(data: [(x: CGFloat, y: CGFloat)]) {
        
        guard let xCount = xValuesCount, let yCount = yValuesCount else {
            fatalError("x or y value count is missing and grid can't be created")
        }
        
        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()

        path.move(to: CGPoint(x: 0, y: bounds.height / 2))
        path.addLine(to: CGPoint(x: bounds.width / 2, y: bounds.height / 2))
        //path.addLine(to: CGPoint(x: bounds.width , y: bounds.height / 2))
        UIColor.purple.setStroke()
        path.lineWidth = 2
        path.stroke()
        

        
    }
    
    internal func test() {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0, y: bounds.height))
        path.addLine(to: CGPoint(x: 50, y: bounds.height / 1.4))
        path.addLine(to: CGPoint(x: 60, y: bounds.height / 1.8))
        path.addLine(to: CGPoint(x: 70, y: bounds.height / 2))
        path.addLine(to: CGPoint(x: 75, y: bounds.height / 2.5))
        path.addLine(to: CGPoint(x: 80, y: bounds.height / 3))
        path.addLine(to: CGPoint(x: 90, y: bounds.height / 4))
        path.addLine(to: CGPoint(x: 100, y: bounds.height / 5))
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.height / 5.5))
        UIColor.purple.setStroke()
        path.lineWidth = 2
        path.stroke()
    }
    
    // MARK: Private Methods
    
    internal override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        //test()
    }
}
