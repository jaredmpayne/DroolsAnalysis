import Foundation

extension CharacterSet {
    
    public static var identifierFirstCharacters: CharacterSet {
        CharacterSet.letters.union(CharacterSet.identifierSpecialCharacters)
    }
    
    public static var identifierTailCharacters: CharacterSet {
        CharacterSet.alphanumerics.union(CharacterSet.identifierSpecialCharacters)
    }
    
    public static var identifierSpecialCharacters: CharacterSet {
        CharacterSet(charactersIn: "-_$")
    }
    
    public static var numbers: CharacterSet {
        CharacterSet(charactersIn: "0"..."9")
    }
    
    public static var operatorCharacters: CharacterSet {
        CharacterSet(charactersIn: Reserved.operators.reduce("") { $0 + $1 })
    }
    
    public static var punctuatorCharacters: CharacterSet {
        CharacterSet(charactersIn: Reserved.punctuators.reduce("") { $0 + $1 })
    }
    
    public func contains(_ member: Unicode.Scalar?) -> Bool {
        guard let unicodeScalar = member else { return false }
        return self.contains(unicodeScalar)
    }
}
