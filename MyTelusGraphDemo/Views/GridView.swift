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
            
            view.heightAnchor.constraint(equalToConstant: 1).isActive = true
            view.topAnchor.constraint(equalTo: topAnchor, constant: (frame.height / CGFloat(yCount)) * CGFloat(index)).isActive = true
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        }
    }
}
