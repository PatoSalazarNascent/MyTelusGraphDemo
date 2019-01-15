import Foundation
import UIKit
import Toolkit

public class GraphMetaDataView: BaseView {
    
    // MARK: Properties
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var icon: UIView!
    @IBOutlet private weak var label: UILabel!
    
    // MARK: Internal Methods
    
    public func bindMetaData(iconColor: UIColor, text: String) {
        
        icon.backgroundColor = iconColor
        label.text = text
    }
    
    public func bindMetaData(iconImage: String, text: String) {
        
        let image = UIImageView(image: UIImage(named: iconImage))
        
        icon.addSubview(image)
        image.anchorToParent(icon)
        label.text = text
    }
}
