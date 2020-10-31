
extension String {
    
    public mutating func append(_ unicodeScalar: UnicodeScalar) {
        self.unicodeScalars.append(unicodeScalar)
    }
}
