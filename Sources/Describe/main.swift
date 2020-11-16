import DroolsAnalysis
import Foundation

let rules = Drools.rules
let tokenSets = rules.map { try! Lexer(string: $0).lex() }
let syntaxTrees = tokenSets.map { try! Parser(tokens: $0).parse() }
let definitions = syntaxTrees.compactMap { $0.compilationUnit.fullDefinitions.first?.definition }
let ruleDefinitions = definitions.compactMap { $0.definition as? RuleDefinition }
ruleDefinitions.enumerated().forEach { print("\(describe(ruleDefinition: $1))") }

func describe(ruleDefinition: RuleDefinition) -> String {
    let whenPart = ruleDefinition.whenPart
    let thenPart = ruleDefinition.thenPart
    return "\(describe(whenPart: whenPart!)), \(describe(thenPart: thenPart))."
}

func describe(whenPart: WhenPart) -> String {
    let patternDescriptions = whenPart.conditionalOrs
        .flatMap { $0.conditionalAnds }
        .flatMap { $0.conditionalElements }
        .compactMap { $0.conditionalElementBody.conditionalElementBody as? BindingPattern }
        .compactMap { $0.bindingPatternBody.bindingPatternBody as? SourcePattern }
        .map { $0.pattern }
        .map { describe(pattern: $0) }
    return "when " + patternDescriptions.dropFirst()
        .reduce(patternDescriptions.first!) { $0 + " and " + $1 }
}

func describe(pattern: DroolsAnalysis.Pattern) -> String {
    let identifier = pattern.patternType.identifier.token.value
    let tokens = pattern.constraints.tokens
    let relevantTokens = tokens.contains(Token(kind: .punctuator, value: ":"))
        ? [Token](tokens.dropFirst(2))
        : tokens
    return relevantTokens.reduce(identifier) { $0 + " " + $1.value }
}

func describe(thenPart: ThenPart) -> String {
    let validStatementDescriptions = thenPart.rhsStatements
        .compactMap { $0.rhsStatement as? Statement }
        .filter { $0.tokens.starts(with: [Token(kind: .identifier, value: "String")]) }
        .map { describe(statement: $0) }
    return "then " + validStatementDescriptions.dropFirst()
        .reduce(validStatementDescriptions.first ?? "") { $0 + " and " + $1 }
}

func describe(statement: Statement) -> String {
    let command = statement.tokens
        .first { $0.kind == .identifier && $0.value.uppercased() == $0.value }!.value
    let stringLiterals = statement.tokens.filter { $0.kind == .stringLiteral } .map { $0.value }
    return stringLiterals.reduce(command.lowercased()) { lhs, rhs in
        lhs + " " + rhs.trimmingCharacters(in: CharacterSet(charactersIn: "\""))
    }
}
