import Foundation

public class Lexer {
    
    public enum Error: Swift.Error {
        case unexpectedEndOfString(expected: String)
    }
    
    private let reader: Reader<String.UnicodeScalarView>
    
    private var value: String = ""
    
    public init(string: String) {
        self.reader = Reader(collection: string.unicodeScalars)
    }
    
    public func lex() throws -> [Token] {
        var tokens: [Token] = []
        while let token = try self.lexToken() {
            tokens.append(token)
        }
        return tokens
    }
    
    private func lexToken() throws -> Token? {
        self.value = ""
        self.skipWhitespacesAndNewlines()
        return try self.lexComment()
            ?? self.lexOperator()
            ?? self.lexPunctuator()
            ?? self.lexIntLiteral()
            ?? self.lexStringLiteral()
            ?? self.lexKeywordOrIdentifier()
    }
    
    private func lexComment() throws -> Token? {
        return try self.lexSingleLineComment() ?? self.lexDelimitedComment()
    }
    
    private func lexSingleLineComment() -> Token? {
        guard self.reader.starts(with: "//".unicodeScalars) else { return nil }
        self.value.append(self.reader.next()!)
        self.value.append(self.reader.next()!)
        self.value.append(self.takeWhile { $0 != "\n" })
        return Token(kind: .comment, value: self.value)
    }
    
    private func lexDelimitedComment() throws -> Token? {
        return try self.lexDelimited(kind: .comment, start: "/*", end: "*/")
    }
    
    private func lexOperator() -> Token? {
        guard CharacterSet.operatorCharacters.contains(self.reader.peek()) else { return nil }
        self.value.append(self.takeWhile { CharacterSet.operatorCharacters.contains($0) })
        return Token(kind: .operator, value: self.value)
    }
    
    private func lexPunctuator() -> Token? {
        guard CharacterSet.punctuatorCharacters.contains(self.reader.peek()) else { return nil }
        self.value.append(self.reader.next()!)
        return Token(kind: .punctuator, value: self.value)
    }
    
    private func lexIntLiteral() -> Token? {
        guard CharacterSet.numbers.contains(self.reader.peek()) else { return nil }
        self.value.append(self.takeWhile { CharacterSet.numbers.contains($0) })
        return Token(kind: .intLiteral, value: self.value)
    }
    
    private func lexStringLiteral() throws -> Token? {
        return try self.lexDelimited(kind: .stringLiteral, start: "\"", end: "\"")
    }
    
    private func lexKeywordOrIdentifier() -> Token? {
        guard CharacterSet.identifierFirstCharacters.contains(self.reader.peek()) else { return nil }
        self.value.append(self.reader.next()!)
        self.value.append(self.takeWhile { CharacterSet.identifierTailCharacters.contains($0) })
        if self.value == "null" {
            return Token(kind: .nullLiteral, value: self.value)
        }
        if ["true", "false"].contains(self.value) {
            return Token(kind: .booleanLiteral, value: self.value)
        }
        if Reserved.keywords.contains(self.value) {
            return Token(kind: .keyword, value: self.value)
        }
        return Token(kind: .identifier, value: self.value)
    }
    
    private func skipWhitespacesAndNewlines() {
        let _ = self.takeWhile { CharacterSet.whitespacesAndNewlines.contains($0) }
    }
    
    private func lexDelimited(kind: Token.Kind, start: String, end: String) throws -> Token? {
        guard self.reader.starts(with: start.unicodeScalars) else { return nil }
        start.unicodeScalars.forEach { _ in self.value.append(self.reader.next()!) }
        while let _ = self.reader.peek(), !self.reader.starts(with: end.unicodeScalars) {
            self.value.append(self.reader.next()!)
        }
        guard self.reader.starts(with: end.unicodeScalars) else {
            throw Error.unexpectedEndOfString(expected: end)
        }
        end.unicodeScalars.forEach { _ in self.value.append(self.reader.next()!) }
        return Token(kind: kind, value: self.value)
    }
    
    private func takeWhile(predicate: (UnicodeScalar) -> Bool) -> String {
        var string = ""
        while let peek = self.reader.peek(), predicate(peek) {
            string.append(self.reader.next()!)
        }
        return string
    }
}
