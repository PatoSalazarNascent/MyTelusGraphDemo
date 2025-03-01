import UIKit

public class ShapesHelper {
    
    // MARK: Internal Methods
    
    public func getLineShape(from coords: [CGPoint], color: UIColor, lineWidth: CGFloat) -> CAShapeLayer {
        
        let path = UIBezierPath()
        
        coords.enumerated().forEach { index, coord in
            if index == 0 {
                path.move(to: coord)
            } else {
                path.addLine(to: coord)
            }
        }

        // Create Shape layer that will use path to display it in view
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.path = path.cgPath
        
        return shapeLayer
    }
    
    public func getRectShape(from rect: CGRect, color: UIColor) -> CAShapeLayer {
        
        let path = UIBezierPath(rect: rect)
                
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = color.cgColor
        shapeLayer.path = path.cgPath
        
        return shapeLayer
    }
    
    public func getRectShape(from rect: CGRect, withRoundedCorners corners: UIRectCorner, radius: CGFloat, color: UIColor) -> CAShapeLayer {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = color.cgColor
        
        shapeLayer.path = path.cgPath
        
        return shapeLayer
    }
}
