import UIKit

public class StringHelper {
    
    public static func formatStringWithNoDecimal(_ input: Double) -> String? {
        return formatString(withDecimalPlaces: 0, input: input)
    }
    
    public static func formatStringWithOneDecimal(_ input: Double) -> String? {
        return formatString(withDecimalPlaces: 1, input: input)
    }
    
    public static func formatString(withDecimalPlaces places: Int, input: Double, roundUp: Bool = true) -> String {
        
        var newInput = Float(input)
        // to make sure values are rounded up
        if places == 0 {
            newInput = roundUp ? Float(ceil(input)) : Float(floor(input))
        }
        return String(format: "%.\(places)f", newInput)
    }
    
    public static func formatNumber(withDecimalPlaces places: Int, input: Double) -> String {
        
        let formatter = NumberFormatter()
        
        formatter.numberStyle = NumberFormatter.Style.decimal
        // set the minimum fraction digits to 0
        formatter.minimumFractionDigits = 0
        // set the maximum fraction digits
        formatter.maximumFractionDigits = places
        
        return formatter.string(from: NSNumber(value: input)) ?? ""
    }
    
    public static func formatDoubleAsNumber(_ input: Double) -> String? {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        
        formatter.locale = Locale(identifier: "en_CA")
        
        return formatter.string(from: NSNumber(value: input))
    }
    
    // This could be extracted into separate 'phoneFormatter' class
    // ex. input parameter: PhoneNumber object, output parameter: String
    public static func formatPhoneNumber(_ input: String?) -> String? {
        
        guard var number = input else {
            return nil
        }
        
        if number.count != 10 {
            return input
        }
        
        number.insert("-", at: number.index(number.startIndex, offsetBy: 3))
        number.insert("-", at: number.index(number.startIndex, offsetBy: 7))
        
        return number
    }
    
    public static func formatPhoneNumberAlt(_ input: String?) -> String? {
        
        guard var number = input else {
            return nil
        }
        
        if number.count != 10 {
            return input
        }
        
        number.insert("(", at: number.index(number.startIndex, offsetBy: 0))
        number.insert(")", at: number.index(number.startIndex, offsetBy: 4))
        number.insert("-", at: number.index(number.startIndex, offsetBy: 5))
        number.insert("-", at: number.index(number.startIndex, offsetBy: 9))
        
        return number
    }
    
    public static func toTitleCase(_ input: String) -> String {
        return input.lowercased().capitalized
        
    }
    
    public static func servicesAddress(unit: String?, streetNumber: String?, street: String?) -> String {
        return "\(unit ?? "")\((unit != nil) ? "-" : "")\(streetNumber ?? "") \(street?.capitalized ?? "" )"
    }
}
