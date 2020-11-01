import Foundation
import XCTest
@testable import DroolsAnalysis

final class LexerTests: XCTestCase {
    
    public func testLexerLexesSingleLineComments() {
        let value = "// This is a single-line comment."
        let expected = [
            Token(kind: .comment, value: value)
        ]
        XCTAssertEqual(expected, try! Lexer(string: value).lex())
    }
    
    public func testLexerLexesMultiLineComments() {
        let value = "/* This is a \n multi-line \n comment. */"
        let expected = [
            Token(kind: .comment, value: value)
        ]
        XCTAssertEqual(expected, try! Lexer(string: value).lex())
    }
    
    public func testLexerLexesKeywords() {
        Reserved.keywords.forEach { value in
            let expected = [
                Token(
                    kind: value == "null"
                        ? .nullLiteral
                        : ["true", "false"].contains(value)
                            ? .booleanLiteral
                            : .keyword,
                    value: value
                )
            ]
            XCTAssertEqual(expected, try! Lexer(string: value).lex())
        }
    }
    
    public func testLexerLexesOperators() {
        Reserved.operators.forEach { value in
            let expected = [
                Token(kind: .operator, value: value)
            ]
            XCTAssertEqual(expected, try! Lexer(string: value).lex())
        }
    }
    
    public func testLexerLexesPunctuators() {
        Reserved.punctuators.forEach { value in
            let expected = [
                Token(kind: .punctuator, value: value)
            ]
            XCTAssertEqual(expected, try! Lexer(string: value).lex())
        }
    }
    
    public func testLexerLexesIntLiterals() {
        let value = "123"
        let expected = [
            Token(kind: .intLiteral, value: value)
        ]
        XCTAssertEqual(expected, try! Lexer(string: value).lex())
    }
    
    public func testLexerLexesStringLiterals() {
        let value = "\"This is a string literal.\""
        let expected = [
            Token(kind: .stringLiteral, value: value)
        ]
        XCTAssertEqual(expected, try! Lexer(string: value).lex())
    }
    
    public func testsLexerLexesDroolOne() {
        let expected = [
            Token(kind: .keyword, value: "rule"),
            Token(kind: .stringLiteral, value: "\"firewall\""),
            Token(kind: .keyword, value: "when"),
            Token(kind: .identifier, value: "$n"),
            Token(kind: .punctuator, value: ":"),
            Token(kind: .identifier, value: "NetDevice"),
            Token(kind: .punctuator, value: "("),
            Token(kind: .identifier, value: "$labels"),
            Token(kind: .punctuator, value: ":"),
            Token(kind: .identifier, value: "labels"),
            Token(kind: .keyword, value: "contains"),
            Token(kind: .stringLiteral, value: "\"FIREWALL\""),
            Token(kind: .punctuator, value: ")"),
            Token(kind: .punctuator, value: ";"),
            Token(kind: .keyword, value: "then"),
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
            Token(kind: .punctuator, value: ";"),
            Token(kind: .identifier, value: "pusher"),
            Token(kind: .punctuator, value: "."),
            Token(kind: .identifier, value: "installRules"),
            Token(kind: .punctuator, value: "("),
            Token(kind: .identifier, value: "cfg"),
            Token(kind: .punctuator, value: ")"),
            Token(kind: .punctuator, value: ";"),
            Token(kind: .keyword, value: "end")
        ]
        let actual = try! Lexer(string: Drools.rules[0]).lex()
        XCTAssertEqual(expected, actual)
    }
    
    public static var allTests = [
        ("testLexerLexesSingleLineComments", testLexerLexesSingleLineComments),
        ("testLexerLexesMultiLineComments", testLexerLexesMultiLineComments),
        ("testLexerLexesKeywords", testLexerLexesKeywords),
        ("testLexerLexesOperators", testLexerLexesOperators),
        ("testLexerLexesPunctuators", testLexerLexesPunctuators),
        ("testLexerLexesStringLiterals", testLexerLexesStringLiterals),
        ("testLexerLexesNumericLiterals", testLexerLexesIntLiterals)
    ]
}
