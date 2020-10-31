import Foundation
import XCTest
@testable import DroolsAnalysis

final class ReaderTests: XCTestCase {
    
    private let string: String = "Hello, World!"
    
    private var reader: Reader<String.UnicodeScalarView>!
    
    public override func setUp() {
        self.reader = Reader(collection: self.string.unicodeScalars)
    }
    
    public func testReaderPeekReturnsNextElement() {
        XCTAssertEqual(UnicodeScalar("H"), self.reader.peek())
    }
    
    public func testReaderPeekDoesNotAdvanceIndex() {
        XCTAssertEqual(UnicodeScalar("H"), self.reader.peek())
        XCTAssertEqual(UnicodeScalar("H"), self.reader.peek())
    }
    
    public func testReaderPeekReturnsNilWhenCollectionHasBeenExhausted() {
        (1...self.string.unicodeScalars.count).forEach { _ in let _ = self.reader.next() }
        XCTAssertNil(self.reader.peek())
    }
    
    public func testReaderNextReturnsNextElement() {
        XCTAssertEqual(UnicodeScalar("H"), self.reader.next())
    }
    
    public func testReaderNextAdvancesIndex() {
        XCTAssertEqual(UnicodeScalar("H"), self.reader.next())
        XCTAssertEqual(UnicodeScalar("e"), self.reader.next())
    }
    
    public func testReaderNextReturnsNilWhenCollectionHasBeenExhausted() {
        (1...self.string.unicodeScalars.count).forEach { _ in let _ = self.reader.next() }
        XCTAssertNil(self.reader.next())
    }

    public static var allTests = [
        ("testReaderPeekReturnsNextElement", testReaderPeekReturnsNextElement),
        ("testReaderPeekDoesNotAdvanceIndex", testReaderPeekDoesNotAdvanceIndex),
        ("testReaderPeekReturnsNilWhenCollectionHasBeenExhausted", testReaderPeekReturnsNilWhenCollectionHasBeenExhausted),
        ("testReaderNextReturnsNextElement", testReaderNextReturnsNextElement),
        ("testReaderNextAdvancesIndex", testReaderNextAdvancesIndex),
        ("testReaderNextReturnsNilWhenCollectionHasBeenExhausted", testReaderNextReturnsNilWhenCollectionHasBeenExhausted)
    ]
}
