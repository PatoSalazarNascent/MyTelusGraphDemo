import Foundation
import UIKit

public class GridView: UIView {
    
    // MARK: Properties
    
    let minMultiplier: CGFloat = 0.001 // multiplier can't be zero.
    let maxMultiplier: CGFloat = 2.0
    
    // MARK: Public Methods
    
    public func setGridColor(color: UIColor?) {
        for gridLinesViews in subviews {
            gridLinesViews.backgroundColor = color
        }
    }
    
    // MARK: Internal Methods
    
    internal func initGridView(verticalSegmentsCount: Int, horizontalSegmentsCount: Int, type: GridType) {
        
        switch type {
        case .horizontal:
            addLinesToGrid(lineCount: verticalSegmentsCount, type: .horizontal)
        case .vertical:
            addLinesToGrid(lineCount: horizontalSegmentsCount, type: .vertical)
        case .fullGrid:
            addLinesToGrid(lineCount: verticalSegmentsCount, type: .horizontal)
            addLinesToGrid(lineCount: horizontalSegmentsCount, type: .vertical)
        case .none:
            createEmptyGrid()
        }
    }
    
    // MARK: Private Methods
    
    private func createEmptyGrid() {
        
        let horizontalLine = createGridLine()
        let verticalLine = createGridLine()
        
        addConstraintsToLine(view: horizontalLine, type: .horizontal, multiplier: maxMultiplier)
        addConstraintsToLine(view: verticalLine, type: .vertical, multiplier: minMultiplier)
    }
    
    private func addLinesToGrid(lineCount: Int, type: GridType) {
        
        for value in 0...lineCount {
            let line = createGridLine()
            
            // this logic positions the line on the graph taking advantages of autolayouts.
            // if horizontal minMultiplier means all the way to the left
            // if vertial minMultiplier means top
            
            let multiplier = value == 0 ? minMultiplier : CGFloat(value) * maxMultiplier / CGFloat(lineCount)
            
            switch type {
            case .horizontal:
                addConstraintsToLine(view: line, type: .horizontal, multiplier: multiplier)
            case .vertical:
                addConstraintsToLine(view: line, type: .vertical, multiplier: multiplier)
            default: break
            }
        }
    }
    
    private func createGridLine() -> UIView {
        let view = UIView()
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        
        return view
    }
    
    private func addConstraintsToLine(view: UIView, type: GridType, multiplier: CGFloat) {
        
        let centerAttribute: NSLayoutConstraint.Attribute =  type == .horizontal ? .centerY : .centerX
        let thickness: NSLayoutConstraint.Attribute = type == .horizontal ? .height : .width
        let startingPoint: NSLayoutConstraint.Attribute = type == .horizontal ? .leading : .top
        let endingPoint: NSLayoutConstraint.Attribute = type == .horizontal ? .trailing : .bottom
        
        NSLayoutConstraint(item: view, attribute: centerAttribute, relatedBy: .equal, toItem: self, attribute: centerAttribute, multiplier: multiplier, constant: 0).isActive = true
        NSLayoutConstraint(item: view, attribute: thickness, relatedBy: .equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 1).isActive = true
        NSLayoutConstraint(item: view, attribute: startingPoint, relatedBy: .equal, toItem: self, attribute: startingPoint, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: view, attribute: endingPoint, relatedBy: .equal, toItem: self, attribute: endingPoint, multiplier: 1, constant: 0).isActive = true
    }
}
