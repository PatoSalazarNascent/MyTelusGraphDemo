
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
    
    // MARK: Internal Methods
    
    internal func drawLineChart(data: [LineGraphData], color: UIColor, lineWidth: CGFloat, animated: Bool, duration: CFTimeInterval) {
        
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
            shapeLayer.add(animation, forKey: "lineChartAnimation")
        }
    }
    
    internal func addDataLimit(dataLimit: LineGraphData, dataLimitType: AxisType) {
        createDataLimitView(dataLimit: dataLimit, dataLimitType: dataLimitType)
    }
    
    // MARK: Private Methods
    
    private func createDataLimitView(dataLimit: LineGraphData?, dataLimitType: AxisType?) {
        
        guard let limit = dataLimit, let type = dataLimitType else { return }
        
        guard let xMinValue = horizontalAxisMinValue, let xMaxValue = horizontalAxisMaxValue, let yMinValue = verticalAxisMinValue, let yMaxValue = verticalAxisMaxValue else {
            fatalError("x or y min or max value are missing and line can't be created")
        }
        
        let xDistance = frame.width / CGFloat(xMaxValue - xMinValue)
        let yDistance = frame.height / CGFloat(yMaxValue - yMinValue)
        
        let dataLimitView = UIView()
        dataLimitView.backgroundColor = .magenta
        
        addSubview(dataLimitView)
        
        if type == .vertical {
            let xCoord = (limit.x - CGFloat(xMinValue)) * xDistance
            dataLimitView.frame = CGRect(x: xCoord, y: 0, width: 1, height: bounds.height)
        }
        else {
            let yCoord = (limit.y - CGFloat(yMinValue)) * yDistance
             dataLimitView.frame = CGRect(x: 0, y: yCoord, width: bounds.width, height: 1)
        }
    }
}
