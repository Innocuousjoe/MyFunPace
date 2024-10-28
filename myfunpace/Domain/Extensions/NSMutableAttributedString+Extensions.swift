import Foundation

extension NSMutableAttributedString {
    @discardableResult
    public func apply(attribute: NSAttributedString.Key, value: Any, to substring: String)  -> NSMutableAttributedString{
        let foundRange = self.mutableString.range(of: substring)
        if foundRange.location != NSNotFound {
            self.addAttribute(attribute, value: value, range: foundRange)
        }
        return self
    }
    
    @discardableResult
    public func apply(attributes: [NSAttributedString.Key], values: [Any], to substring: String)  -> NSMutableAttributedString{
        for (index, attr) in attributes.enumerated() {
            if let value = values[safe: index] {
                apply(attribute: attr, value: value, to: substring)
            } else {
                continue
            }
        }
        return self
    }
}
