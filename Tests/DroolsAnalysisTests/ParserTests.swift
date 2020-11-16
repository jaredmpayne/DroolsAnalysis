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
    
    public func testParseRuleOne() {
        let expected = SyntaxTree(
            compilationUnit: CompilationUnit(
                packageDeclaration: nil,
                fullDefinitions: [
                    FullDefinition(
                        definition: AnyDefinition(
                            definition: RuleDefinition(
                                ruleKeyword: Token(kind: .keyword, value: "rule"),
                                stringID: AnyStringID(
                                    stringID: StringLiteral(
                                        token: Token(
                                            kind: .stringLiteral,
                                            value: "\"firewall\""
                                        )
                                    )
                                ),
                                ruleOptions: RuleOptions(
                                    extendsClause: nil,
                                    annotations: [],
                                    ruleAttributes: RuleAttributes(
                                        ruleAttributesPrefix: nil,
                                        ruleAttributesSuffix: RuleAttributesSuffix(
                                            ruleAttributesSuffixSegments: []
                                        )
                                    )
                                ),
                                whenPart: WhenPart(
                                    whenKeyword: Token(
                                        kind: .keyword,
                                        value: "when"
                                    ),
                                    colon: nil,
                                    conditionalOrs: [
                                        ConditionalOr(
                                            conditionalAnds: [
                                                ConditionalAnd(
                                                    conditionalElements: [
                                                        ConditionalElement(
                                                            conditionalElementBody: AnyConditionalElementBody(
                                                                conditionalElementBody: BindingPattern(
                                                                    bindingPatternIdentifier: BindingPatternIdentifier(
                                                                        identifier: Identifier(
                                                                            token: Token(
                                                                                kind: .identifier,
                                                                                value: "$n"
                                                                            )
                                                                        ),
                                                                        colon: Token(
                                                                            kind: .punctuator,
                                                                            value: ":"
                                                                        )
                                                                    ),
                                                                    bindingPatternBody: AnyBindingPatternBody(
                                                                        bindingPatternBody: SourcePattern(
                                                                            pattern: Pattern(
                                                                                patternType: PatternType(
                                                                                    identifier: Identifier(
                                                                                        token: Token(
                                                                                            kind: .identifier,
                                                                                            value: "NetDevice"
                                                                                        )
                                                                                    )
                                                                                ),
                                                                                leftParenthesis: Token(
                                                                                    kind: .punctuator,
                                                                                    value: "("
                                                                                ),
                                                                                constraints: Constraints(
                                                                                    tokens: [
                                                                                        Token(kind: .identifier, value: "$labels"),
                                                                                        Token(kind: .punctuator, value: ":"),
                                                                                        Token(kind: .identifier, value: "labels"),
                                                                                        Token(kind: .keyword, value: "contains"),
                                                                                        Token(kind: .stringLiteral, value: "\"FIREWALL\"")
                                                                                    ]
                                                                                ),
                                                                                rightParenthesis: Token(
                                                                                    kind: .punctuator,
                                                                                    value: ")"
                                                                                )
                                                                            ),
                                                                            overClause: nil,
                                                                            sourcePatternFromPart: nil
                                                                        )
                                                                    )
                                                                )
                                                            ),
                                                            semicolon: Token(kind: .punctuator, value: ";")
                                                        )
                                                    ]
                                                )
                                            ]
                                        )
                                    ]
                                ),
                                thenPart: ThenPart(
                                    thenKeyword: Token(
                                        kind: .keyword,
                                        value: "then"
                                    ),
                                    rhsStatements: [
                                        AnyRHSStatement(
                                            rhsStatement: Statement(
                                                tokens: [
                                                    Token(kind: .identifier, value: "String"),
                                                    Token(kind: .identifier, value: "cfg"),
                                                    Token(kind: .operator, value: "="),
                                                    Token(kind: .identifier, value: "ConfigGenerator"),
                                                    Token(kind: .punctuator, value: "."),
                                                    Token(kind: .identifier, value: "fromNode"),
                                                    Token(kind: .punctuator, value: "("),
                                                    Token(kind: .identifier, value: "$n"),
                                                    Token(kind: .punctuator, value: ","),
                                                    Token(kind: .identifier, value: "PolicyAction"),
                                                    Token(kind: .punctuator, value: "."),
                                                    Token(kind: .identifier, value: "BLOCK"),
                                                    Token(kind: .punctuator, value: ","),
                                                    Token(kind: .punctuator, value: "("),
                                                    Token(kind: .identifier, value: "NetId"),
                                                    Token(kind: .punctuator, value: ")"),
                                                    Token(kind: .identifier, value: "netlabels"),
                                                    Token(kind: .punctuator, value: "."),
                                                    Token(kind: .identifier, value: "get"),
                                                    Token(kind: .punctuator, value: "("),
                                                    Token(kind: .stringLiteral, value: "\"outside\""),
                                                    Token(kind: .punctuator, value: ")"),
                                                    Token(kind: .punctuator, value: ","),
                                                    Token(kind: .punctuator, value: "("),
                                                    Token(kind: .identifier, value: "NetId"),
                                                    Token(kind: .punctuator, value: ")"),
                                                    Token(kind: .identifier, value: "netlabels"),
                                                    Token(kind: .punctuator, value: "."),
                                                    Token(kind: .identifier, value: "get"),
                                                    Token(kind: .punctuator, value: "("),
                                                    Token(kind: .stringLiteral, value: "\"campus network\""),
                                                    Token(kind: .punctuator, value: ")"),
                                                    Token(kind: .punctuator, value: ")"),
                                                    Token(kind: .punctuator, value: ";")
                                                ]
                                            )
                                        ),
                                        AnyRHSStatement(
                                            rhsStatement: Statement(
                                                tokens: [
                                                    Token(kind: .identifier, value: "pusher"),
                                                    Token(kind: .punctuator, value: "."),
                                                    Token(kind: .identifier, value: "installRules"),
                                                    Token(kind: .punctuator, value: "("),
                                                    Token(kind: .identifier, value: "cfg"),
                                                    Token(kind: .punctuator, value: ")"),
                                                    Token(kind: .punctuator, value: ";")
                                                ]
                                            )
                                        )
                                    ],
                                    endKeyword: Token(
                                        kind: .keyword,
                                        value: "end"
                                    )
                                )
                            )
                        ),
                        semicolon: nil
                    )
                ]
            )
        )
        let tokens = try! Lexer(string: Drools.rules[0]).lex()
        let actual = try! Parser(tokens: tokens).parse()
        XCTAssertEqual(expected, actual)
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
        ("testZeroOrManyReturnsEmptyArrayWhenCallbackImmediatelyFails", testZeroOrManyReturnsEmptyArrayWhenCallbackImmediatelyFails),
        ("testParseRuleOne", testParseRuleOne)
    ]
}
