import Foundation
import UIKit

public class CategoryGraphAxisConfig {
    
    // MARK: Properies
    
    public let categoryValues: [String]
    public let title: String?
    
    public init(categoryValues: [String], title: String?) {
        self.categoryValues = categoryValues
        self.title = title
    }
}
