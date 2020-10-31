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
                Token(kind: .keyword, value: value)
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
