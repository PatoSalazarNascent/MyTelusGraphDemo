import UIKit

internal class ShapesHelper {
    
    // MARK: Internal Methods
    
    internal func getLineShape(from coords: [CGPoint], color: UIColor, lineWidth: CGFloat) -> CAShapeLayer {
        
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
}
