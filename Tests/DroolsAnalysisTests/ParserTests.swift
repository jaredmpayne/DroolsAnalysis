import Foundation
import XCTest
@testable import DroolsAnalysis

final class ParserTests: XCTestCase {
    
    private let tokens: [Token] = [
        Token(kind: .punctuator, value: "("),
        Token(kind: .identifier, value: "y"),
        Token(kind: .operator, value: "="),
        Token(kind: .intLiteral, value: "2"),
        Token(kind: .operator, value: "*"),
        Token(kind: .identifier, value: "x"),
        Token(kind: .operator, value: "+"),
        Token(kind: .intLiteral, value: "3"),
        Token(kind: .punctuator, value: ")")
    ]
    
    private let identifierTokens: [Token] = [
        Token(kind: .identifier, value: "foo"),
        Token(kind: .identifier, value: "bar"),
        Token(kind: .identifier, value: "baz")
    ]
    
    private let commaSeparatedIdentifierTokens: [Token] = [
        Token(kind: .identifier, value: "foo"),
        Token(kind: .punctuator, value: ","),
        Token(kind: .identifier, value: "bar"),
        Token(kind: .punctuator, value: ","),
        Token(kind: .identifier, value: "baz")
    ]
    
    private var parser: Parser!
    
    private var identifierParser: Parser!
    
    private var commaSeparatedIdentifierParser: Parser!
    
    public override func setUp() {
        self.parser = Parser(tokens: self.tokens)
        self.identifierParser = Parser(tokens: self.identifierTokens)
        self.commaSeparatedIdentifierParser = Parser(tokens: self.commaSeparatedIdentifierTokens)
    }
    
    public func testExpectReturnsExpectedTokenIfEncountered() {
        XCTAssertEqual(self.tokens.first!, try! self.parser.expect(token: self.tokens.first!))
    }
    
    public func testExpectConsumesToken() {
        XCTAssertEqual(tokens[0], try! self.parser.expect(token: tokens[0]))
        XCTAssertEqual(tokens[1], try! self.parser.expect(token: tokens[1]))
    }
    
    public func testExpectThrowsErrorIfExpectedTokenNotEncountered() {
        XCTAssertThrowsError(try self.parser.expect(token: self.tokens.last!))
    }
    
    public func testExpectDoesNotConsumeTokenWhenThrowing() {
        XCTAssertThrowsError(try self.parser.expect(kind: self.tokens.last!.kind, value: self.tokens.last!.value))
        XCTAssertEqual(self.tokens.first!, try! self.parser.expect(token: self.tokens.first!))
    }
    
    public func testExpectConvenienceFunction() {
        XCTAssertEqual(tokens[0], try! self.parser.expect(kind: tokens[0].kind, value: tokens[0].value))
        XCTAssertEqual(tokens[1], try! self.parser.expect(kind: tokens[1].kind, value: tokens[1].value))
        XCTAssertThrowsError(try self.parser.expect(kind: self.tokens.last!.kind, value: self.tokens.last!.value))
    }
    
    public func testMaybeReturnsExpectedTokenIfEncountered() {
        XCTAssertEqual(self.tokens.first!, self.parser.maybe(token: self.tokens.first!))
    }
    
    public func testMaybeConsumesToken() {
        XCTAssertEqual(tokens[0], self.parser.maybe(token: tokens[0]))
        XCTAssertEqual(tokens[1], self.parser.maybe(token: tokens[1]))
    }
    
    public func testMaybeReturnsNilIfExpectedTokenNotEncountered() {
        XCTAssertNil(self.parser.maybe(token: self.tokens.last!))
    }
    
    public func testMaybeDoesNotConsumeTokenWhenNilIsReturned() {
        XCTAssertNil(self.parser.maybe(kind: self.tokens.last!.kind, value: self.tokens.last!.value))
        XCTAssertEqual(self.tokens.first!, self.parser.maybe(token: self.tokens.first!))
    }
    
    public func testMaybeConvenienceFunction() {
        XCTAssertEqual(tokens[0], self.parser.maybe(kind: tokens[0].kind, value: tokens[0].value))
        XCTAssertEqual(tokens[1], self.parser.maybe(kind: tokens[1].kind, value: tokens[1].value))
        XCTAssertNil(self.parser.maybe(kind: self.tokens.last!.kind, value: self.tokens.last!.value))
    }
    
    public func testMaybeReturnsNilIfCallbackThrows() {
        XCTAssertNil(self.parser.maybe(Parser.parseIdentifier))
    }
    
    public func testZeroOrMany() {
        let callback = Parser.parseIdentifier
        let expected = self.identifierTokens.map { Identifier(token: $0) }
        XCTAssertEqual(expected, self.identifierParser.zeroOrMany(callback) as [Identifier])
    }
    
    public func testZeroOrManyWithSeparator() {
        let callback = Parser.parseIdentifier
        let separator = self.commaSeparatedIdentifierTokens[1]
        let expected = self.commaSeparatedIdentifierTokens.filter { $0.kind == .identifier } .map { Identifier(token: $0) }
        XCTAssertEqual(expected, try! self.commaSeparatedIdentifierParser.zeroOrMany(callback, separator: separator))
    }
    
    public func testZeroOrManyReturnsEmptyArrayWhenCallbackImmediatelyFails() {
        let callback = Parser.parseIdentifier
        XCTAssertEqual([], self.parser.zeroOrMany(callback))
    }
    
    public func testOneOrMany() {
        let callback = Parser.parseIdentifier
        let expected = self.identifierTokens.map { Identifier(token: $0) }
        XCTAssertEqual(expected, try! self.identifierParser.oneOrMany(callback) as [Identifier])
    }
    
    public func testOneOrManyWithSeparator() {
        let callback = Parser.parseIdentifier
        let separator = self.commaSeparatedIdentifierTokens[1]
        let expected = self.commaSeparatedIdentifierTokens.filter { $0.kind == .identifier } .map { Identifier(token: $0) }
        XCTAssertEqual(expected, try! self.commaSeparatedIdentifierParser.oneOrMany(callback, separator: separator))
    }
    
    public func testOneOrManyThrowsIfZeroArePresent() {
        let parser = Parser(tokens: [Token(kind: .operator, value: "+")])
        XCTAssertThrowsError(try parser.oneOrMany(Parser.parseIdentifier))
    }

    public static var allTests = [
        ("testExpectReturnsExpectedTokenIfEncountered", testExpectReturnsExpectedTokenIfEncountered),
        ("testExpectConsumesToken", testExpectConsumesToken),
        ("testExpectThrowsErrorIfExpectedTokenNotEncountered", testExpectThrowsErrorIfExpectedTokenNotEncountered),
        ("testExpectDoesNotConsumeTokenWhenThrowing", testExpectDoesNotConsumeTokenWhenThrowing),
        ("testExpectConvenienceFunction", testExpectConvenienceFunction),
        ("testMaybeReturnsExpectedTokenIfEncountered", testMaybeReturnsExpectedTokenIfEncountered),
        ("testMaybeConsumesToken", testMaybeConsumesToken),
        ("testMaybeReturnsNilIfExpectedTokenNotEncountered", testMaybeReturnsNilIfExpectedTokenNotEncountered),
        ("testMaybeDoesNotConsumeTokenWhenNilIsReturned", testMaybeDoesNotConsumeTokenWhenNilIsReturned),
        ("testMaybeConvenienceFunction", testMaybeConvenienceFunction),
        ("testMaybeReturnsNilIfCallbackThrows", testMaybeReturnsNilIfCallbackThrows),
        ("testZeroOrMany", testZeroOrMany),
        ("testZeroOrManyWithSeparator", testZeroOrManyWithSeparator),
        ("testZeroOrManyReturnsEmptyArrayWhenCallbackImmediatelyFails", testZeroOrManyReturnsEmptyArrayWhenCallbackImmediatelyFails)
    ]
}
