
public struct Token: Equatable {
    
    public enum Kind {
        case comment
        case keyword
        case `operator`
        case punctuator
        case identifier
        case intLiteral
        case realLiteral
        case nullLiteral
        case stringLiteral
        case booleanLiteral
    }
    
    public let kind: Kind
    
    public let value: String
}
