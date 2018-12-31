import Foundation
import UIKit

internal enum GridType {
    case horizontal
    case vertical
    case fullGrid
}

internal class GridView: UIView {
    
    // MARK: Properties
    
    private var xSegmentsCount: Int?
    private var ySegmentsCount: Int?
    
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
    
    
    internal func initGrid(xSegmentsCount: Int, ySegmentsCount: Int) {
        self.xSegmentsCount = xSegmentsCount
        self.ySegmentsCount = ySegmentsCount
    }
    
    internal func addGrid(_ type: GridType) {
        
        guard let xCount = xSegmentsCount, let yCount = ySegmentsCount else {
            fatalError("x or y value count is missing and grid can't be created")
        }
        
        switch type {
        case .horizontal:
            createHorizontalGrid(yCount: yCount)
        default: break
        }
        
    }
    
    // MARK: Private Methods
    
    private func createHorizontalGrid(yCount: Int) {
    
        for index in 0...yCount {
            let view = UIView()
            addSubview(view)

            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = UIColor.lightGray
            
            let yAsDouble = Double(yCount)

            let multiplier = index == 0 ? 0.01 : CGFloat(Double(index) * Double(2.0 / yAsDouble))
            
            NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: multiplier, constant: 0).isActive = true
            NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 1).isActive = true
            NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        }
    }
}
