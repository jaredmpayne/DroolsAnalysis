
import DroolsAnalysis

var lines: [String] = []
while let line = readLine() { lines.append(line) }

do {
    let tokens = try Lexer(string: lines.reduce("", +)).lex()
    let syntaxTree = try Parser(tokens: tokens).parse()
    print(syntaxTree)
}
catch Lexer.Error.unexpectedEndOfString(let expected) {
    print(#"Error: Unexpected end-of-string. Expected "\#(expected)"."#)
}
catch Parser.Error.unexpected(let actual, let expected) {
    if let a = actual, let e = expected {
        print(#"Error: Expected "\#(e)" but found "\#(a)"."#)
    }
    else {
        print(#"Error: Unexpected token "\#(String(describing: actual?.value))"."#)
    }
}
