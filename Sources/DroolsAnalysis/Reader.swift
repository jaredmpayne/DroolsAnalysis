
public class Reader<TCollection>
    where TCollection: BidirectionalCollection,
          TCollection.Element: Equatable {
    
    public enum Error: Swift.Error {
        case unexpected(expected: TCollection, actual: TCollection.Element)
    }
    
    private let collection: TCollection
    
    private var currentIndex: TCollection.Index
    
    public init(collection: TCollection) {
        self.collection = collection
        self.currentIndex = collection.startIndex
    }
    
    public var remainder: TCollection.SubSequence {
        self.collection[self.currentIndex..<self.collection.endIndex]
    }
    
    public func peek() -> TCollection.Element? {
        guard self.currentIndex < self.collection.endIndex else { return nil }
        return self.collection[self.currentIndex]
    }
    
    public func next() -> TCollection.Element? {
        guard let peek = self.peek() else { return nil }
        self.currentIndex = self.collection.index(after: self.currentIndex)
        return peek
    }
    
    public func expect(_ prefix: TCollection) throws -> TCollection.SubSequence {
        guard self.starts(with: prefix) else {
            throw Error.unexpected(expected: prefix, actual: remainder.first!)
        }
        let endIndex = self.collection.index(self.currentIndex, offsetBy: prefix.count)
        return self.collection[self.currentIndex..<endIndex]
    }
    
    public func starts(with prefix: TCollection) -> Bool {
        return self.remainder.starts(with: prefix)
    }
}
