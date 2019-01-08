import Foundation
import UIKit

internal enum GridType {
    case horizontal
    case vertical
    case fullGrid
}

internal class GridView: UIView {
    
    // MARK: Properties
    
    private var horizontalSegmentsCount: Int?
    private var verticalSegmentsCount: Int?
    
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
    
    
    internal func initGrid(horizontalSegmentsCount: Int, verticalSegmentsCount: Int) {
        self.horizontalSegmentsCount = horizontalSegmentsCount
        self.verticalSegmentsCount = verticalSegmentsCount
    }
    
    internal func addGrid(_ type: GridType) {
        
        guard let horizontalCount = horizontalSegmentsCount, let verticalCount = verticalSegmentsCount else {
            fatalError("x or y value count is missing and grid can't be created")
        }
        
        switch type {
        case .horizontal:
            createGrid(lineCount: verticalCount, type: .horizontal)
        case .vertical:
            createGrid(lineCount: horizontalCount, type: .vertical)
        case .fullGrid:
            createGrid(lineCount: verticalCount, type: .horizontal)
            createGrid(lineCount: horizontalCount, type: .vertical)
        }
    }
    
    internal func setGridColor(color: UIColor?) {
        for gridLinesViews in self.subviews {
            gridLinesViews.backgroundColor = color
        }
    }
    
    // MARK: Private Methods
    
    private func createGrid(lineCount: Int, type: GridType) {
        
        for value in 0...lineCount {
            let view = UIView()
            addSubview(view)
            
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = UIColor.lightGray
            
            let multiplier = value == 0 ? 0.001 : CGFloat(value) * 2.0 / CGFloat(lineCount)
            
            switch type {
            case .horizontal:
                createHorizontalGridLineConstraint(view: view, multiplier: multiplier)
            case .vertical:
                createVerticalGridLineConstraint(view: view, multiplier: multiplier)
            default: break
            }
        }
    }
    
    private func createHorizontalGridLineConstraint(view: UIView, multiplier: CGFloat) {
        NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: multiplier, constant: 0).isActive = true
        NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 1).isActive = true
        NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
    }
    
    private func createVerticalGridLineConstraint(view: UIView, multiplier: CGFloat) {
        NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: multiplier, constant: 0).isActive = true
        
        NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 1).isActive = true
        
        NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
    }
}
