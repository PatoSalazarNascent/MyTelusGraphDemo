import Foundation
import UIKit

internal class CategoryGraphAxisConfig {
    
    // MARK: Properies
    
    internal let categoryValues: [String]
    internal let title: String?
    
    internal init(categoryValues: [String], title: String?) {
        self.categoryValues = categoryValues
        self.title = title
    }
}
