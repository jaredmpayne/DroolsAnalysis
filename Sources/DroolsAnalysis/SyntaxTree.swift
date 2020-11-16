
public class SyntaxTree: Equatable {

    public let compilationUnit: CompilationUnit

    public init(compilationUnit: CompilationUnit) {
        self.compilationUnit = compilationUnit
    }
    
    public static func ==(lhs: SyntaxTree, rhs: SyntaxTree) -> Bool {
        return lhs.compilationUnit == rhs.compilationUnit
    }
}

public class AccumulateAction: Equatable {

    public let actionKeyword: Token

    public let leftParenthesis: Token

    public let statements: [Statement]

    public let rightParenthesis: Token

    public let comma: Token?

    public init(actionKeyword: Token, leftParenthesis: Token, statements: [Statement], rightParenthesis: Token, comma: Token?) {
        self.actionKeyword = actionKeyword
        self.leftParenthesis = leftParenthesis
        self.statements = statements
        self.rightParenthesis = rightParenthesis
        self.comma = comma
    }
    
    public static func ==(lhs: AccumulateAction, rhs: AccumulateAction) -> Bool {
        return lhs.actionKeyword == rhs.actionKeyword &&
            lhs.leftParenthesis == rhs.leftParenthesis &&
            lhs.statements == rhs.statements &&
            lhs.rightParenthesis == rhs.rightParenthesis &&
            lhs.comma == rhs.comma
    }
}

public class AccumulateClause: SourcePatternFromPartSuffix, Equatable {

    public let accumulateKeyword: Token

    public let leftParenthesis: Token

    public let conditionalAnd: ConditionalAnd

    public let comma: Token?

    public let accumulateClauseBody: AnyAccumulateClauseBody

    public let rightParenthesis: Token

    public init(accumulateKeyword: Token, leftParenthesis: Token, conditionalAnd: ConditionalAnd, comma: Token?, accumulateClauseBody: AnyAccumulateClauseBody, rightParenthesis: Token) {
        self.accumulateKeyword = accumulateKeyword
        self.leftParenthesis = leftParenthesis
        self.conditionalAnd = conditionalAnd
        self.comma = comma
        self.accumulateClauseBody = accumulateClauseBody
        self.rightParenthesis = rightParenthesis
    }
    
    public static func ==(lhs: AccumulateClause, rhs: AccumulateClause) -> Bool {
        return lhs.accumulateKeyword == rhs.accumulateKeyword &&
            lhs.leftParenthesis == rhs.leftParenthesis &&
            lhs.conditionalAnd == rhs.conditionalAnd &&
            lhs.comma == rhs.comma &&
            lhs.accumulateClauseBody == rhs.accumulateClauseBody &&
            lhs.rightParenthesis == rhs.rightParenthesis
    }
}

public protocol AccumulateClauseBody {
    
    func isEqualTo(other: AccumulateClauseBody) -> Bool
}

extension AccumulateClauseBody where Self: Equatable {
    
    public func isEqualTo(other: AccumulateClauseBody) -> Bool {
        guard let accumulateClauseBody = other as? Self else { return false }
        return self == accumulateClauseBody
    }
}

public class AnyAccumulateClauseBody: Equatable {
    
    public let accumulateClauseBody: AccumulateClauseBody
    
    public init(accumulateClauseBody: AccumulateClauseBody) {
        self.accumulateClauseBody = accumulateClauseBody
    }
    
    public static func ==(lhs: AnyAccumulateClauseBody, rhs: AnyAccumulateClauseBody) -> Bool {
        return lhs.accumulateClauseBody.isEqualTo(other: rhs.accumulateClauseBody)
    }
}

public class AccumulateFunction: AccumulateClauseBody, Equatable {

    public let identifier: Identifier

    public let leftParenthesis: Token

    public let conditionalExpressions: [ConditionalExpression]

    public let rightParenthesis: Token

    public init(identifier: Identifier, leftParenthesis: Token, conditionalExpressions: [ConditionalExpression], rightParenthesis: Token) {
        self.identifier = identifier
        self.leftParenthesis = leftParenthesis
        self.conditionalExpressions = conditionalExpressions
        self.rightParenthesis = rightParenthesis
    }
    
    public static func ==(lhs: AccumulateFunction, rhs: AccumulateFunction) -> Bool {
        return lhs.identifier == rhs.identifier &&
            lhs.leftParenthesis == rhs.leftParenthesis &&
            lhs.conditionalExpressions == rhs.conditionalExpressions &&
            lhs.rightParenthesis == rhs.rightParenthesis
    }
}

public class AccumulateInit: Equatable {

    public let initKeyword: Token

    public let leftParenthesis: Token

    public let statements: [Statement]

    public let rightParenthesis: Token

    public let comma: Token?

    public init(initKeyword: Token, leftParenthesis: Token, statements: [Statement], rightParenthesis: Token, comma: Token?) {
        self.initKeyword = initKeyword
        self.leftParenthesis = leftParenthesis
        self.statements = statements
        self.rightParenthesis = rightParenthesis
        self.comma = comma
    }
    
    public static func ==(lhs: AccumulateInit, rhs: AccumulateInit) -> Bool {
        return lhs.initKeyword == rhs.initKeyword &&
            lhs.leftParenthesis == rhs.leftParenthesis &&
            lhs.statements == rhs.statements &&
            lhs.rightParenthesis == rhs.rightParenthesis &&
            lhs.comma == rhs.comma
    }
}

public class AccumulateResult: Equatable {

    public let resultKeyword: Token

    public let leftParenthesis: Token

    public let conditionalExpression: ConditionalExpression

    public let rightParenthesis: Token

    public init(resultKeyword: Token, leftParenthesis: Token, conditionalExpression: ConditionalExpression, rightParenthesis: Token) {
        self.resultKeyword = resultKeyword
        self.leftParenthesis = leftParenthesis
        self.conditionalExpression = conditionalExpression
        self.rightParenthesis = rightParenthesis
    }
    
    public static func ==(lhs: AccumulateResult, rhs: AccumulateResult) -> Bool {
        return lhs.resultKeyword == rhs.resultKeyword &&
            lhs.leftParenthesis == rhs.leftParenthesis &&
            lhs.conditionalExpression == rhs.conditionalExpression &&
            lhs.rightParenthesis == rhs.rightParenthesis
    }
}

public class AccumulateReverse: Equatable {

    public let reverseKeyword: Token

    public let leftParenthesis: Token

    public let statements: [Statement]

    public let rightParenthesis: Token

    public let comma: Token?

    public init(reverseKeyword: Token, leftParenthesis: Token, statements: [Statement], rightParenthesis: Token, comma: Token?) {
        self.reverseKeyword = reverseKeyword
        self.leftParenthesis = leftParenthesis
        self.statements = statements
        self.rightParenthesis = rightParenthesis
        self.comma = comma
    }
    
    public static func ==(lhs: AccumulateReverse, rhs: AccumulateReverse) -> Bool {
        return lhs.reverseKeyword == rhs.reverseKeyword &&
            lhs.leftParenthesis == rhs.leftParenthesis &&
            lhs.statements == rhs.statements &&
            lhs.rightParenthesis == rhs.rightParenthesis &&
            lhs.comma == rhs.comma
    }
}

public class AccumulateSteps: AccumulateClauseBody, Equatable {

    public let accumulateInit: AccumulateInit

    public let accumulateAction: AccumulateAction

    public let accumulateReverse: AccumulateReverse?

    public let accumulateResult: AccumulateResult

    public init(accumulateInit: AccumulateInit, accumulateAction: AccumulateAction, accumulateReverse: AccumulateReverse?, accumulateResult: AccumulateResult) {
        self.accumulateInit = accumulateInit
        self.accumulateAction = accumulateAction
        self.accumulateReverse = accumulateReverse
        self.accumulateResult = accumulateResult
    }
    
    public static func ==(lhs: AccumulateSteps, rhs: AccumulateSteps) -> Bool {
        return lhs.accumulateInit == rhs.accumulateInit &&
            lhs.accumulateAction == rhs.accumulateAction &&
            lhs.accumulateReverse == rhs.accumulateReverse &&
            lhs.accumulateResult == rhs.accumulateResult
    }
}

public class Accumulations: Equatable {

    public let accumulationsMappings: [AccumulationsMapping]

    public init(accumulationsMappings: [AccumulationsMapping]) {
        self.accumulationsMappings = accumulationsMappings
    }
    
    public static func ==(lhs: Accumulations, rhs: Accumulations) -> Bool {
        return lhs.accumulationsMappings == rhs.accumulationsMappings
    }
}

public class AccumulationsMapping: Equatable {

    public let identifier: Identifier

    public let colon: Token

    public let accumulateFunction: AccumulateFunction

    public init(identifier: Identifier, colon: Token, accumulateFunction: AccumulateFunction) {
        self.identifier = identifier
        self.colon = colon
        self.accumulateFunction = accumulateFunction
    }
    
    public static func ==(lhs: AccumulationsMapping, rhs: AccumulationsMapping) -> Bool {
        return lhs.identifier == rhs.identifier &&
            lhs.colon == rhs.colon &&
            lhs.accumulateFunction == rhs.accumulateFunction
    }
}

public class AdditiveExpression: Equatable {

    public let unaryExpression: AnyUnaryExpression

    public let additiveExpressionRHS: AdditiveExpressionRHS?

    public init(unaryExpression: AnyUnaryExpression, additiveExpressionRHS: AdditiveExpressionRHS?) {
        self.unaryExpression = unaryExpression
        self.additiveExpressionRHS = additiveExpressionRHS
    }
    
    public static func ==(lhs: AdditiveExpression, rhs: AdditiveExpression) -> Bool {
        return lhs.unaryExpression == rhs.unaryExpression &&
            lhs.additiveExpressionRHS == rhs.additiveExpressionRHS
    }
}

public class AdditiveExpressionRHS: Equatable {

    public let `operator`: Token

    public let unaryExpression: AnyUnaryExpression

    public let additiveExpressionRHS: AdditiveExpressionRHS?

    public init(operator: Token, unaryExpression: AnyUnaryExpression, additiveExpressionRHS: AdditiveExpressionRHS?) {
        self.operator = `operator`
        self.unaryExpression = unaryExpression
        self.additiveExpressionRHS = additiveExpressionRHS
    }
    
    public static func ==(lhs: AdditiveExpressionRHS, rhs: AdditiveExpressionRHS) -> Bool {
        return lhs.operator == rhs.operator &&
            lhs.unaryExpression == rhs.unaryExpression &&
            lhs.additiveExpressionRHS == rhs.additiveExpressionRHS
    }
}

public class Annotation: Equatable {

    public let atSign: Token

    public let identifier: Identifier

    public let annotationBody: AnnotationBody?

    public init(atSign: Token, identifier: Identifier, annotationBody: AnnotationBody?) {
        self.atSign = atSign
        self.identifier = identifier
        self.annotationBody = annotationBody
    }
    
    public static func ==(lhs: Annotation, rhs: Annotation) -> Bool {
        return lhs.atSign == rhs.atSign &&
            lhs.identifier == rhs.identifier &&
            lhs.annotationBody == rhs.annotationBody
    }
}

public class AnnotationBody: Equatable {

    public let leftParenthesis: Token

    public let annotationInnerBody: AnyAnnotationInnerBody

    public let rightParenthesis: Token

    public init(leftParenthesis: Token, annotationInnerBody: AnyAnnotationInnerBody, rightParenthesis: Token) {
        self.leftParenthesis = leftParenthesis
        self.annotationInnerBody = annotationInnerBody
        self.rightParenthesis = rightParenthesis
    }
    
    public static func ==(lhs: AnnotationBody, rhs: AnnotationBody) -> Bool {
        return lhs.leftParenthesis == rhs.leftParenthesis &&
            lhs.annotationInnerBody == rhs.annotationInnerBody &&
            lhs.rightParenthesis == rhs.rightParenthesis
    }
}

public protocol AnnotationInnerBody {
    
    func isEqualTo(other: AnnotationInnerBody) -> Bool
}

extension AnnotationInnerBody where Self: Equatable {
    
    public func isEqualTo(other: AnnotationInnerBody) -> Bool {
        guard let annotationInnerBody = other as? Self else { return false }
        return self == annotationInnerBody
    }
}

public class AnyAnnotationInnerBody: Equatable {
    
    public let annotationInnerBody: AnnotationInnerBody
    
    public init(annotationInnerBody: AnnotationInnerBody) {
        self.annotationInnerBody = annotationInnerBody
    }
    
    public static func ==(lhs: AnyAnnotationInnerBody, rhs: AnyAnnotationInnerBody) -> Bool {
        return lhs.annotationInnerBody.isEqualTo(other: rhs.annotationInnerBody)
    }
}

public class AnnotationInnerBodyAssignment: Equatable {

    public let identifier: Identifier

    public let assignment: Token

    public let value: AnyValue

    public init(identifier: Identifier, assignment: Token, value: AnyValue) {
        self.identifier = identifier
        self.assignment = assignment
        self.value = value
    }
    
    public static func ==(lhs: AnnotationInnerBodyAssignment, rhs: AnnotationInnerBodyAssignment) -> Bool {
        return lhs.identifier == rhs.identifier &&
            lhs.assignment == rhs.assignment &&
            lhs.value == rhs.value
    }
}

public class AnnotationInnerBodyAssignments: AnnotationInnerBody, Equatable {

    public let annotationInnerBodyAssignments: [AnnotationInnerBodyAssignment]

    public init(annotationInnerBodyAssignments: [AnnotationInnerBodyAssignment]) {
        self.annotationInnerBodyAssignments = annotationInnerBodyAssignments
    }
    
    public static func ==(lhs: AnnotationInnerBodyAssignments, rhs: AnnotationInnerBodyAssignments) -> Bool {
        return lhs.annotationInnerBodyAssignments == rhs.annotationInnerBodyAssignments
    }
}

public class Arguments: CreatorBody, IdentifierSuffix, SuperSuffix, Equatable {

    public let leftParenthesis: Token

    public let expressions: [Expression]

    public let rightParenthesis: Token

    public init(leftParenthesis: Token, expressions: [Expression], rightParenthesis: Token) {
        self.leftParenthesis = leftParenthesis
        self.expressions = expressions
        self.rightParenthesis = rightParenthesis
    }
    
    public static func ==(lhs: Arguments, rhs: Arguments) -> Bool {
        return lhs.leftParenthesis == rhs.leftParenthesis &&
            lhs.expressions == rhs.expressions &&
            lhs.rightParenthesis == rhs.rightParenthesis
    }
}

public class ArrayCreatorRest: CreatorBody, Equatable {

    public let arrayCreatorRestBody: AnyArrayCreatorRestBody

    public init(arrayCreatorRestBody: AnyArrayCreatorRestBody) {
        self.arrayCreatorRestBody = arrayCreatorRestBody
    }
    
    public static func ==(lhs: ArrayCreatorRest, rhs: ArrayCreatorRest) -> Bool {
        return lhs.arrayCreatorRestBody == rhs.arrayCreatorRestBody
    }
}

public protocol ArrayCreatorRestBody {
    
    func isEqualTo(other: ArrayCreatorRestBody) -> Bool
}

extension ArrayCreatorRestBody where Self: Equatable {
    
    public func isEqualTo(other: ArrayCreatorRestBody) -> Bool {
        guard let arrayCreatorRestBody = other as? Self else { return false }
        return self == arrayCreatorRestBody
    }
}

public class AnyArrayCreatorRestBody: Equatable {
    
    public let arrayCreatorRestBody: ArrayCreatorRestBody
    
    public init(arrayCreatorRestBody: ArrayCreatorRestBody) {
        self.arrayCreatorRestBody = arrayCreatorRestBody
    }
    
    public static func ==(lhs: AnyArrayCreatorRestBody, rhs: AnyArrayCreatorRestBody) -> Bool {
        return lhs.arrayCreatorRestBody.isEqualTo(other: rhs.arrayCreatorRestBody)
    }
}

public class ArrayCreatorRestExpressionBody: ArrayCreatorRestBody, Equatable {

    public let bracketedExpressions: [BracketedExpression]

    public let bracketPairs: [BracketPair]

    public init(bracketedExpressions: [BracketedExpression], bracketPairs: [BracketPair]) {
        self.bracketedExpressions = bracketedExpressions
        self.bracketPairs = bracketPairs
    }
    
    public static func ==(lhs: ArrayCreatorRestExpressionBody, rhs: ArrayCreatorRestExpressionBody) -> Bool {
        return lhs.bracketedExpressions == rhs.bracketedExpressions &&
            lhs.bracketPairs == rhs.bracketPairs
    }
}

public class ArrayCreatorRestInitializerBody: ArrayCreatorRestBody, Equatable {

    public let bracketPairs: [BracketPair]

    public let arrayInitializer: ArrayInitializer

    public init(bracketPairs: [BracketPair], arrayInitializer: ArrayInitializer) {
        self.bracketPairs = bracketPairs
        self.arrayInitializer = arrayInitializer
    }
    
    public static func ==(lhs: ArrayCreatorRestInitializerBody, rhs: ArrayCreatorRestInitializerBody) -> Bool {
        return lhs.bracketPairs == rhs.bracketPairs &&
            lhs.arrayInitializer == rhs.arrayInitializer
    }
}

public class ArrayInitializer: VariableInitializer, Equatable {

    public let leftBrace: Token

    public let arrayVariableInitializers: ArrayVariableInitializers

    public let rightBrace: Token

    public init(leftBrace: Token, arrayVariableInitializers: ArrayVariableInitializers, rightBrace: Token) {
        self.leftBrace = leftBrace
        self.arrayVariableInitializers = arrayVariableInitializers
        self.rightBrace = rightBrace
    }
    
    public static func ==(lhs: ArrayInitializer, rhs: ArrayInitializer) -> Bool {
        return lhs.leftBrace == rhs.leftBrace &&
            lhs.arrayVariableInitializers == rhs.arrayVariableInitializers &&
            lhs.rightBrace == rhs.rightBrace
    }
}

public class ArrayVariableInitializers: Equatable {

    public let variableInitializers: [AnyVariableInitializer]

    public let comma: Token?

    public init(variableInitializers: [AnyVariableInitializer], comma: Token?) {
        self.variableInitializers = variableInitializers
        self.comma = comma
    }
    
    public static func ==(lhs: ArrayVariableInitializers, rhs: ArrayVariableInitializers) -> Bool {
        return lhs.variableInitializers == rhs.variableInitializers &&
            lhs.comma == rhs.comma
    }
}

public class AssignmentOperator: Equatable {

    public let `operator`: Token

    public init(operator: Token) {
        self.operator = `operator`
    }
    
    public static func ==(lhs: AssignmentOperator, rhs: AssignmentOperator) -> Bool {
        return lhs.operator == rhs.operator
    }
}

public class BindingPattern: ConditionalElementBody, ConditionalElementExistsBody, ConditionalElementNotBody, Equatable {

    public let bindingPatternIdentifier: BindingPatternIdentifier?

    public let bindingPatternBody: AnyBindingPatternBody

    public init(bindingPatternIdentifier: BindingPatternIdentifier?, bindingPatternBody: AnyBindingPatternBody) {
        self.bindingPatternIdentifier = bindingPatternIdentifier
        self.bindingPatternBody = bindingPatternBody
    }
    
    public static func ==(lhs: BindingPattern, rhs: BindingPattern) -> Bool {
        return lhs.bindingPatternIdentifier == rhs.bindingPatternIdentifier &&
            lhs.bindingPatternBody == rhs.bindingPatternBody
    }
}

public protocol BindingPatternBody {
    
    func isEqualTo(other: BindingPatternBody) -> Bool
}

extension BindingPatternBody where Self: Equatable {
    
    public func isEqualTo(other: BindingPatternBody) -> Bool {
        guard let bindingPatternBody = other as? Self else { return false }
        return self == bindingPatternBody
    }
}

public class AnyBindingPatternBody: Equatable {
    
    public let bindingPatternBody: BindingPatternBody
    
    public init(bindingPatternBody: BindingPatternBody) {
        self.bindingPatternBody = bindingPatternBody
    }
    
    public static func ==(lhs: AnyBindingPatternBody, rhs: AnyBindingPatternBody) -> Bool {
        return lhs.bindingPatternBody.isEqualTo(other: rhs.bindingPatternBody)
    }
}

public class BindingPatternIdentifier: Equatable {

    public let identifier: Identifier

    public let colon: Token

    public init(identifier: Identifier, colon: Token) {
        self.identifier = identifier
        self.colon = colon
    }
    
    public static func ==(lhs: BindingPatternIdentifier, rhs: BindingPatternIdentifier) -> Bool {
        return lhs.identifier == rhs.identifier &&
            lhs.colon == rhs.colon
    }
}

public class BindingPatternMultipleSourcePattern: BindingPatternBody, Equatable {

    public let leftParenthesis: Token

    public let sourcePatterns: [SourcePattern]

    public let rightParenthesis: Token

    public init(leftParenthesis: Token, sourcePatterns: [SourcePattern], rightParenthesis: Token) {
        self.leftParenthesis = leftParenthesis
        self.sourcePatterns = sourcePatterns
        self.rightParenthesis = rightParenthesis
    }
    
    public static func ==(lhs: BindingPatternMultipleSourcePattern, rhs: BindingPatternMultipleSourcePattern) -> Bool {
        return lhs.leftParenthesis == rhs.leftParenthesis &&
            lhs.sourcePatterns == rhs.sourcePatterns &&
            lhs.rightParenthesis == rhs.rightParenthesis
    }
}

public class Block: Equatable {

    public let leftBrace: Token

    public let statements: [Statement]

    public let rightBrace: Token

    public init(leftBrace: Token, statements: [Statement], rightBrace: Token) {
        self.leftBrace = leftBrace
        self.statements = statements
        self.rightBrace = rightBrace
    }
    
    public static func ==(lhs: Block, rhs: Block) -> Bool {
        return lhs.leftBrace == rhs.leftBrace &&
            lhs.statements == rhs.statements &&
            lhs.rightBrace == rhs.rightBrace
    }
}

public class BooleanLiteral: Literal, Equatable {

    public let token: Token

    public init(token: Token) {
        self.token = token
    }
    
    public static func ==(lhs: BooleanLiteral, rhs: BooleanLiteral) -> Bool {
        return lhs.token == rhs.token
    }
}

public class BooleanLiteralRuleAttribute: RuleAttribute, Equatable {

    public let keyword: Token

    public let booleanLiteral: BooleanLiteral?

    public init(keyword: Token, booleanLiteral: BooleanLiteral?) {
        self.keyword = keyword
        self.booleanLiteral = booleanLiteral
    }
    
    public static func ==(lhs: BooleanLiteralRuleAttribute, rhs: BooleanLiteralRuleAttribute) -> Bool {
        return lhs.keyword == rhs.keyword &&
            lhs.booleanLiteral == rhs.booleanLiteral
    }
}

public class BracketedExpression: Selector, Equatable {

    public let leftBracket: Token

    public let expression: Expression

    public let rightBracket: Token

    public init(leftBracket: Token, expression: Expression, rightBracket: Token) {
        self.leftBracket = leftBracket
        self.expression = expression
        self.rightBracket = rightBracket
    }
    
    public static func ==(lhs: BracketedExpression, rhs: BracketedExpression) -> Bool {
        return lhs.leftBracket == rhs.leftBracket &&
            lhs.expression == rhs.expression &&
            lhs.rightBracket == rhs.rightBracket
    }
}

public class BracketedExpressions: IdentifierSuffix, Equatable {

    public let bracketedExpressions: [BracketedExpression]

    public init(bracketedExpressions: [BracketedExpression]) {
        self.bracketedExpressions = bracketedExpressions
    }
    
    public static func ==(lhs: BracketedExpressions, rhs: BracketedExpressions) -> Bool {
        return lhs.bracketedExpressions == rhs.bracketedExpressions
    }
}

public class BracketPair: Equatable {

    public let leftBracket: Token

    public let rightBracket: Token

    public init(leftBracket: Token, rightBracket: Token) {
        self.leftBracket = leftBracket
        self.rightBracket = rightBracket
    }
    
    public static func ==(lhs: BracketPair, rhs: BracketPair) -> Bool {
        return lhs.leftBracket == rhs.leftBracket &&
            lhs.rightBracket == rhs.rightBracket
    }
}

public class CalendarsRuleAttribute: RuleAttribute, Equatable {

    public let calendarsKeyword: Token

    public let stringLiterals: [StringLiteral]

    public init(calendarsKeyword: Token, stringLiterals: [StringLiteral]) {
        self.calendarsKeyword = calendarsKeyword
        self.stringLiterals = stringLiterals
    }
    
    public static func ==(lhs: CalendarsRuleAttribute, rhs: CalendarsRuleAttribute) -> Bool {
        return lhs.calendarsKeyword == rhs.calendarsKeyword &&
            lhs.stringLiterals == rhs.stringLiterals
    }
}

public class CollectBindingClause: SourcePatternFromPartSuffix, Equatable {

    public let collectKeyword: Token

    public let leftParenthesis: Token

    public let bindingPattern: BindingPattern

    public let rightParenthesis: Token

    public init(collectKeyword: Token, leftParenthesis: Token, bindingPattern: BindingPattern, rightParenthesis: Token) {
        self.collectKeyword = collectKeyword
        self.leftParenthesis = leftParenthesis
        self.bindingPattern = bindingPattern
        self.rightParenthesis = rightParenthesis
    }
    
    public static func ==(lhs: CollectBindingClause, rhs: CollectBindingClause) -> Bool {
        return lhs.collectKeyword == rhs.collectKeyword &&
            lhs.leftParenthesis == rhs.leftParenthesis &&
            lhs.bindingPattern == rhs.bindingPattern &&
            lhs.rightParenthesis == rhs.rightParenthesis
    }
}

public class CompilationUnit: Equatable {

    public let packageDeclaration: PackageDeclaration?

    public let fullDefinitions: [FullDefinition]

    public init(packageDeclaration: PackageDeclaration?, fullDefinitions: [FullDefinition]) {
        self.packageDeclaration = packageDeclaration
        self.fullDefinitions = fullDefinitions
    }
    
    public static func ==(lhs: CompilationUnit, rhs: CompilationUnit) -> Bool {
        return lhs.packageDeclaration == rhs.packageDeclaration &&
            lhs.fullDefinitions == rhs.fullDefinitions
    }
}

public class ComplexCreatedName: CreatedName, Equatable {

    public let complexCreatedNameParts: [ComplexCreatedNamePart]

    public init(complexCreatedNameParts: [ComplexCreatedNamePart]) {
        self.complexCreatedNameParts = complexCreatedNameParts
    }
    
    public static func ==(lhs: ComplexCreatedName, rhs: ComplexCreatedName) -> Bool {
        return lhs.complexCreatedNameParts == rhs.complexCreatedNameParts
    }
}

public class ComplexCreatedNamePart: Equatable {

    public let identifier: Identifier

    public let typeArguments: TypeArguments?

    public init(identifier: Identifier, typeArguments: TypeArguments?) {
        self.identifier = identifier
        self.typeArguments = typeArguments
    }
    
    public static func ==(lhs: ComplexCreatedNamePart, rhs: ComplexCreatedNamePart) -> Bool {
        return lhs.identifier == rhs.identifier &&
            lhs.typeArguments == rhs.typeArguments
    }
}

public class ComplexType: Type, Equatable {

    public let complexTypeSegments: [ComplexTypeSegment]

    public let bracketPairs: [BracketPair]

    public init(complexTypeSegments: [ComplexTypeSegment], bracketPairs: [BracketPair]) {
        self.complexTypeSegments = complexTypeSegments
        self.bracketPairs = bracketPairs
    }
    
    public static func ==(lhs: ComplexType, rhs: ComplexType) -> Bool {
        return lhs.complexTypeSegments == rhs.complexTypeSegments &&
            lhs.bracketPairs == rhs.bracketPairs
    }
}

public class ComplexTypeSegment: Equatable {

    public let identifier: Identifier

    public let typeArguments: TypeArguments?

    public init(identifier: Identifier, typeArguments: TypeArguments?) {
        self.identifier = identifier
        self.typeArguments = typeArguments
    }
    
    public static func ==(lhs: ComplexTypeSegment, rhs: ComplexTypeSegment) -> Bool {
        return lhs.identifier == rhs.identifier &&
            lhs.typeArguments == rhs.typeArguments
    }
}

public class ConditionalAnd: Equatable {

    public let conditionalElements: [ConditionalElement]

    public init(conditionalElements: [ConditionalElement]) {
        self.conditionalElements = conditionalElements
    }
    
    public static func ==(lhs: ConditionalAnd, rhs: ConditionalAnd) -> Bool {
        return lhs.conditionalElements == rhs.conditionalElements
    }
}

public class ConditionalElement: Equatable {

    public let conditionalElementBody: AnyConditionalElementBody

    public let semicolon: Token?

    public init(conditionalElementBody: AnyConditionalElementBody, semicolon: Token?) {
        self.conditionalElementBody = conditionalElementBody
        self.semicolon = semicolon
    }
    
    public static func ==(lhs: ConditionalElement, rhs: ConditionalElement) -> Bool {
        return lhs.conditionalElementBody == rhs.conditionalElementBody &&
            lhs.semicolon == rhs.semicolon
    }
}

public class ConditionalElementAccumulate: ConditionalElementBody, Equatable {

    public let accumulateKeyword: Token

    public let leftParenthesis: Token

    public let conditionalAnd: ConditionalAnd
    
    public let comma: Token?

    public let accumulations: Accumulations

    public let rightParenthesis: Token

    public init(accumulateKeyword: Token, leftParenthesis: Token, conditionalAnd: ConditionalAnd, comma: Token?, accumulations: Accumulations, rightParenthesis: Token) {
        self.accumulateKeyword = accumulateKeyword
        self.leftParenthesis = leftParenthesis
        self.conditionalAnd = conditionalAnd
        self.comma = comma
        self.accumulations = accumulations
        self.rightParenthesis = rightParenthesis
    }
    
    public static func ==(lhs: ConditionalElementAccumulate, rhs: ConditionalElementAccumulate) -> Bool {
        return lhs.accumulateKeyword == rhs.accumulateKeyword &&
            lhs.leftParenthesis == rhs.leftParenthesis &&
            lhs.conditionalAnd == rhs.conditionalAnd &&
            lhs.comma == rhs.comma &&
            lhs.accumulations == rhs.accumulations &&
            lhs.rightParenthesis == rhs.rightParenthesis
    }
}

public protocol ConditionalElementBody {
    
    func isEqualTo(other: ConditionalElementBody) -> Bool
}

extension ConditionalElementBody where Self: Equatable {
    
    public func isEqualTo(other: ConditionalElementBody) -> Bool {
        guard let conditionalElementBody = other as? Self else { return false }
        return self == conditionalElementBody
    }
}

public class AnyConditionalElementBody: Equatable {
    
    public let conditionalElementBody: ConditionalElementBody
    
    public init(conditionalElementBody: ConditionalElementBody) {
        self.conditionalElementBody = conditionalElementBody
    }
    
    public static func ==(lhs: AnyConditionalElementBody, rhs: AnyConditionalElementBody) -> Bool {
        return lhs.conditionalElementBody.isEqualTo(other: rhs.conditionalElementBody)
    }
}

public class ConditionalElementEval: ConditionalElementBody, Equatable {

    public let evalKeyword: Token

    public let leftParenthesis: Token

    public let conditionalExpression: ConditionalExpression

    public let rightParenthesis: Token

    public init(evalKeyword: Token, leftParenthesis: Token, conditionalExpression: ConditionalExpression, rightParenthesis: Token) {
        self.evalKeyword = evalKeyword
        self.leftParenthesis = leftParenthesis
        self.conditionalExpression = conditionalExpression
        self.rightParenthesis = rightParenthesis
    }
    
    public static func ==(lhs: ConditionalElementEval, rhs: ConditionalElementEval) -> Bool {
        return lhs.evalKeyword == rhs.evalKeyword &&
            lhs.leftParenthesis == rhs.leftParenthesis &&
            lhs.conditionalExpression == rhs.conditionalExpression &&
            lhs.rightParenthesis == rhs.rightParenthesis
    }
}

public class ConditionalElementExists: ConditionalElementBody, Equatable {

    public let existsKeyword: Token

    public let conditionalElementExistsBody: AnyConditionalElementExistsBody

    public init(existsKeyword: Token, conditionalElementExistsBody: AnyConditionalElementExistsBody) {
        self.existsKeyword = existsKeyword
        self.conditionalElementExistsBody = conditionalElementExistsBody
    }
    
    public static func ==(lhs: ConditionalElementExists, rhs: ConditionalElementExists) -> Bool {
        return lhs.existsKeyword == rhs.existsKeyword &&
            lhs.conditionalElementExistsBody == rhs.conditionalElementExistsBody
    }
}

public protocol ConditionalElementExistsBody {
    
    func isEqualTo(other: ConditionalElementExistsBody) -> Bool
}

extension ConditionalElementExistsBody where Self: Equatable {
    
    public func isEqualTo(other: ConditionalElementExistsBody) -> Bool {
        guard let conditionalElementExistsBody = other as? Self else { return false }
        return self == conditionalElementExistsBody
    }
}

public class AnyConditionalElementExistsBody: Equatable {
    
    public let conditionalElementExistsBody: ConditionalElementExistsBody
    
    public init(conditionalElementExistsBody: ConditionalElementExistsBody) {
        self.conditionalElementExistsBody = conditionalElementExistsBody
    }
    
    public static func ==(lhs: AnyConditionalElementExistsBody, rhs: AnyConditionalElementExistsBody) -> Bool {
        return lhs.conditionalElementExistsBody.isEqualTo(other: rhs.conditionalElementExistsBody)
    }
}

public class ConditionalElementForall: ConditionalElementBody, Equatable {

    public let forallKeyword: Token

    public let leftParenthesis: Token

    public let bindingPatterns: [BindingPattern]

    public let rightParenthesis: Token

    public init(forallKeyword: Token, leftParenthesis: Token, bindingPatterns: [BindingPattern], rightParenthesis: Token) {
        self.forallKeyword = forallKeyword
        self.leftParenthesis = leftParenthesis
        self.bindingPatterns = bindingPatterns
        self.rightParenthesis = rightParenthesis
    }
    
    public static func ==(lhs: ConditionalElementForall, rhs: ConditionalElementForall) -> Bool {
        return lhs.forallKeyword == rhs.forallKeyword &&
            lhs.leftParenthesis == rhs.leftParenthesis &&
            lhs.bindingPatterns == rhs.bindingPatterns &&
            lhs.rightParenthesis == rhs.rightParenthesis
    }
}

public class ConditionalElementNot: ConditionalElementBody, Equatable {

    public let notKeyword: Token

    public let conditionalElementNotBody: AnyConditionalElementNotBody

    public init(notKeyword: Token, conditionalElementNotBody: AnyConditionalElementNotBody) {
        self.notKeyword = notKeyword
        self.conditionalElementNotBody = conditionalElementNotBody
    }
    
    public static func ==(lhs: ConditionalElementNot, rhs: ConditionalElementNot) -> Bool {
        return lhs.notKeyword == rhs.notKeyword &&
            lhs.conditionalElementNotBody == rhs.conditionalElementNotBody
    }
}

public protocol ConditionalElementNotBody {
    
    func isEqualTo(other: ConditionalElementNotBody) -> Bool
}

extension ConditionalElementNotBody where Self: Equatable {
    
    public func isEqualTo(other: ConditionalElementNotBody) -> Bool {
        guard let conditionalElementNotBody = other as? Self else { return false }
        return self == conditionalElementNotBody
    }
}

public class AnyConditionalElementNotBody: Equatable {
    
    public let conditionalElementNotBody: ConditionalElementNotBody
    
    public init(conditionalElementNotBody: ConditionalElementNotBody) {
        self.conditionalElementNotBody = conditionalElementNotBody
    }
    
    public static func ==(lhs: AnyConditionalElementNotBody, rhs: AnyConditionalElementNotBody) -> Bool {
        return lhs.conditionalElementNotBody.isEqualTo(other: rhs.conditionalElementNotBody)
    }
}

public class ConditionalExpression: Value, Equatable {

    public let conditionalOrExpression: ConditionalOrExpression

    public let conditionalExpressionBody: ConditionalExpressionBody?

    public init(conditionalOrExpression: ConditionalOrExpression, conditionalExpressionBody: ConditionalExpressionBody?) {
        self.conditionalOrExpression = conditionalOrExpression
        self.conditionalExpressionBody = conditionalExpressionBody
    }
    
    public static func ==(lhs: ConditionalExpression, rhs: ConditionalExpression) -> Bool {
        return lhs.conditionalOrExpression == rhs.conditionalOrExpression &&
            lhs.conditionalExpressionBody == rhs.conditionalExpressionBody
    }
}

public class ConditionalExpressionBody: Equatable {

    public let questionMark: Token

    public let trueExpression: Expression

    public let colon: Token

    public let falseExpression: Expression

    public init(questionMark: Token, trueExpression: Expression, colon: Token, falseExpression: Expression) {
        self.questionMark = questionMark
        self.trueExpression = trueExpression
        self.colon = colon
        self.falseExpression = falseExpression
    }
    
    public static func ==(lhs: ConditionalExpressionBody, rhs: ConditionalExpressionBody) -> Bool {
        return lhs.questionMark == rhs.questionMark &&
            lhs.trueExpression == rhs.trueExpression &&
            lhs.colon == rhs.colon &&
            lhs.falseExpression == rhs.falseExpression
    }
}

public class ConditionalExpressionRuleAttribute: RuleAttribute, Equatable {

    public let keyword: Token

    public let conditionalExpression: ConditionalExpression

    public init(keyword: Token, conditionalExpression: ConditionalExpression) {
        self.keyword = keyword
        self.conditionalExpression = conditionalExpression
    }
    
    public static func ==(lhs: ConditionalExpressionRuleAttribute, rhs: ConditionalExpressionRuleAttribute) -> Bool {
        return lhs.keyword == rhs.keyword &&
            lhs.conditionalExpression == rhs.conditionalExpression
    }
}

public class ConditionalOr: Equatable {

    public let conditionalAnds: [ConditionalAnd]

    public init(conditionalAnds: [ConditionalAnd]) {
        self.conditionalAnds = conditionalAnds
    }
    
    public static func ==(lhs: ConditionalOr, rhs: ConditionalOr) -> Bool {
        return lhs.conditionalAnds == rhs.conditionalAnds
    }
}

public class ConditionalOrExpression: SourcePatternFromPartSuffix, Equatable {

    public let instanceOfExpression: InstanceOfExpression

    public let conditionalOrExpressionRHS: ConditionalOrExpressionRHS?

    public init(instanceOfExpression: InstanceOfExpression, conditionalOrExpressionRHS: ConditionalOrExpressionRHS?) {
        self.instanceOfExpression = instanceOfExpression
        self.conditionalOrExpressionRHS = conditionalOrExpressionRHS
    }
    
    public static func ==(lhs: ConditionalOrExpression, rhs: ConditionalOrExpression) -> Bool {
        return lhs.instanceOfExpression == rhs.instanceOfExpression &&
            lhs.conditionalOrExpressionRHS == rhs.conditionalOrExpressionRHS
    }
}

public class ConditionalOrExpressionRHS: Equatable {

    public let `operator`: Token

    public let instanceOfExpression: InstanceOfExpression

    public let conditionalOrExpressionRHS: ConditionalOrExpressionRHS?

    public init(operator: Token, instanceOfExpression: InstanceOfExpression, conditionalOrExpressionRHS: ConditionalOrExpressionRHS?) {
        self.operator = `operator`
        self.instanceOfExpression = instanceOfExpression
        self.conditionalOrExpressionRHS = conditionalOrExpressionRHS
    }
    
    public static func ==(lhs: ConditionalOrExpressionRHS, rhs: ConditionalOrExpressionRHS) -> Bool {
        return lhs.operator == rhs.operator &&
            lhs.instanceOfExpression == rhs.instanceOfExpression &&
            lhs.conditionalOrExpressionRHS == rhs.conditionalOrExpressionRHS
    }
}

//public class Constraints: Equatable {
//
//    public let constraintsLeadingExpressions: ConstraintsLeadingExpressions?
//
//    public let constraintsTrailingExpressions: ConstraintsTrailingExpressions?
//
//    public init(constraintsLeadingExpressions: ConstraintsLeadingExpressions?, constraintsTrailingExpressions: ConstraintsTrailingExpressions?) {
//        self.constraintsLeadingExpressions = constraintsLeadingExpressions
//        self.constraintsTrailingExpressions = constraintsTrailingExpressions
//    }
//
//    public static func ==(lhs: Constraints, rhs: Constraints) -> Bool {
//        return lhs.constraintsLeadingExpressions == rhs.constraintsLeadingExpressions &&
//            lhs.constraintsTrailingExpressions == rhs.constraintsTrailingExpressions
//    }
//}

public class Constraints: Equatable {
    
    public let tokens: [Token]
    
    public init(tokens: [Token]) {
        self.tokens = tokens
    }
    
    public static func ==(lhs: Constraints, rhs: Constraints) -> Bool {
        return lhs.tokens == rhs.tokens
    }
}

public class ConstraintsLeadingExpressions: Equatable {

    public let conditionalOrExpressions: [ConditionalOrExpression]

    public let semicolon: Token

    public init(conditionalOrExpressions: [ConditionalOrExpression], semicolon: Token) {
        self.conditionalOrExpressions = conditionalOrExpressions
        self.semicolon = semicolon
    }
    
    public static func ==(lhs: ConstraintsLeadingExpressions, rhs: ConstraintsLeadingExpressions) -> Bool {
        return lhs.conditionalOrExpressions == rhs.conditionalOrExpressions &&
            lhs.semicolon == rhs.semicolon
    }
}

public class ConstraintsTrailingExpressions: Equatable {

    public let conditionalOrExpressions: [ConditionalOrExpression]

    public init(conditionalOrExpressions: [ConditionalOrExpression]) {
        self.conditionalOrExpressions = conditionalOrExpressions
    }
    
    public static func ==(lhs: ConstraintsTrailingExpressions, rhs: ConstraintsTrailingExpressions) -> Bool {
        return lhs.conditionalOrExpressions == rhs.conditionalOrExpressions
    }
}

public protocol CreatedName {
    
    func isEqualTo(other: CreatedName) -> Bool
}

extension CreatedName where Self: Equatable {
    
    public func isEqualTo(other: CreatedName) -> Bool {
        guard let createdName = other as? Self else { return false }
        return self == createdName
    }
}

public class AnyCreatedName: Equatable {
    
    public let createdName: CreatedName
    
    public init(createdName: CreatedName) {
        self.createdName = createdName
    }
    
    public static func ==(lhs: AnyCreatedName, rhs: AnyCreatedName) -> Bool {
        return lhs.createdName.isEqualTo(other: rhs.createdName)
    }
}

public class Creator: Equatable {

    public let nonWildcardTypeArguments: NonWildcardTypeArguments?

    public let createdName: AnyCreatedName

    public let creatorBody: AnyCreatorBody

    public init(nonWildcardTypeArguments: NonWildcardTypeArguments?, createdName: AnyCreatedName, creatorBody: AnyCreatorBody) {
        self.nonWildcardTypeArguments = nonWildcardTypeArguments
        self.createdName = createdName
        self.creatorBody = creatorBody
    }
    
    public static func ==(lhs: Creator, rhs: Creator) -> Bool {
        return lhs.nonWildcardTypeArguments == rhs.nonWildcardTypeArguments &&
            lhs.createdName == rhs.createdName &&
            lhs.creatorBody == rhs.creatorBody
    }
}

public protocol CreatorBody {
    
    func isEqualTo(other: CreatorBody) -> Bool
}

extension CreatorBody where Self: Equatable {
    
    public func isEqualTo(other: CreatorBody) -> Bool {
        guard let creatorBody = other as? Self else { return false }
        return self == creatorBody
    }
}

public class AnyCreatorBody: Equatable {
    
    public let creatorBody: CreatorBody
    
    public init(creatorBody: CreatorBody) {
        self.creatorBody = creatorBody
    }
    
    public static func ==(lhs: AnyCreatorBody, rhs: AnyCreatorBody) -> Bool {
        return lhs.creatorBody.isEqualTo(other: rhs.creatorBody)
    }
}

public protocol Definition {
    
    func isEqualTo(other: Definition) -> Bool
}

extension Definition where Self: Equatable {
    
    public func isEqualTo(other: Definition) -> Bool {
        guard let definition = other as? Self else { return false }
        return self == definition
    }
}

public class AnyDefinition: Equatable {
    
    public let definition: Definition
    
    public init(definition: Definition) {
        self.definition = definition
    }
    
    public static func ==(lhs: AnyDefinition, rhs: AnyDefinition) -> Bool {
        return lhs.definition.isEqualTo(other: rhs.definition)
    }
}

public class EntryPointClause: SourcePatternFromPartSuffix, Equatable {

    public let entryPointKeyword: Token

    public let stringID: AnyStringID

    public init(entryPointKeyword: Token, stringID: AnyStringID) {
        self.entryPointKeyword = entryPointKeyword
        self.stringID = stringID
    }
    
    public static func ==(lhs: EntryPointClause, rhs: EntryPointClause) -> Bool {
        return lhs.entryPointKeyword == rhs.entryPointKeyword &&
            lhs.stringID == rhs.stringID
    }
}

public class ExplicitGenericInvocation: Equatable {

    public let nonWildcardTypeArguments: NonWildcardTypeArguments

    public let arguments: Arguments

    public init(nonWildcardTypeArguments: NonWildcardTypeArguments, arguments: Arguments) {
        self.nonWildcardTypeArguments = nonWildcardTypeArguments
        self.arguments = arguments
    }
    
    public static func ==(lhs: ExplicitGenericInvocation, rhs: ExplicitGenericInvocation) -> Bool {
        return lhs.nonWildcardTypeArguments == rhs.nonWildcardTypeArguments &&
            lhs.arguments == rhs.arguments
    }
}

public class ExplicitGenericInvocationArgumentsSuffix: ExplicitGenericInvocationSuffix, Equatable {

    public let identifier: Identifier

    public let arguments: Arguments

    public init(identifier: Identifier, arguments: Arguments) {
        self.identifier = identifier
        self.arguments = arguments
    }
    
    public static func ==(lhs: ExplicitGenericInvocationArgumentsSuffix, rhs: ExplicitGenericInvocationArgumentsSuffix) -> Bool {
        return lhs.identifier == rhs.identifier &&
            lhs.arguments == rhs.arguments
    }
}

public protocol ExplicitGenericInvocationSuffix: PrimaryNonWildcardTypeArgumentsSuffix { }

public class ExplicitGenericInvocationSuperSuffix: ExplicitGenericInvocationSuffix, Equatable {

    public let superKeyword: Token

    public let superSuffix: AnySuperSuffix

    public init(superKeyword: Token, superSuffix: AnySuperSuffix) {
        self.superKeyword = superKeyword
        self.superSuffix = superSuffix
    }
    
    public static func ==(lhs: ExplicitGenericInvocationSuperSuffix, rhs: ExplicitGenericInvocationSuperSuffix) -> Bool {
        return lhs.superKeyword == rhs.superKeyword &&
            lhs.superSuffix == rhs.superSuffix
    }
}

public class Expression: VariableInitializer, Equatable {

    public let conditionalExpression: ConditionalExpression

    public let expressionRHS: ExpressionRHS?

    public init(conditionalExpression: ConditionalExpression, expressionRHS: ExpressionRHS?) {
        self.conditionalExpression = conditionalExpression
        self.expressionRHS = expressionRHS
    }
    
    public static func ==(lhs: Expression, rhs: Expression) -> Bool {
        return lhs.conditionalExpression == rhs.conditionalExpression &&
            lhs.expressionRHS == rhs.expressionRHS
    }
}

public class ExpressionRHS: Equatable {

    public let assignmentOperator: AssignmentOperator

    public let expression: Expression

    public init(assignmentOperator: AssignmentOperator, expression: Expression) {
        self.assignmentOperator = assignmentOperator
        self.expression = expression
    }
    
    public static func ==(lhs: ExpressionRHS, rhs: ExpressionRHS) -> Bool {
        return lhs.assignmentOperator == rhs.assignmentOperator &&
            lhs.expression == rhs.expression
    }
}

public class ExtendsClause: Equatable {

    public let extendsKeyword: Token

    public let stringID: AnyStringID

    public init(extendsKeyword: Token, stringID: AnyStringID) {
        self.extendsKeyword = extendsKeyword
        self.stringID = stringID
    }
    
    public static func ==(lhs: ExtendsClause, rhs: ExtendsClause) -> Bool {
        return lhs.extendsKeyword == rhs.extendsKeyword &&
            lhs.stringID == rhs.stringID
    }
}

public class Field: Equatable {

    public let identifier: Identifier

    public let colon: Token

    public let qualifiedName: QualifiedName

    public let fieldAssignment: FieldAssignment?

    public let annotations: [Annotation]

    public let semicolon: Token?

    public init(identifier: Identifier, colon: Token, qualifiedName: QualifiedName, fieldAssignment: FieldAssignment?, annotations: [Annotation], semicolon: Token?) {
        self.identifier = identifier
        self.colon = colon
        self.qualifiedName = qualifiedName
        self.fieldAssignment = fieldAssignment
        self.annotations = annotations
        self.semicolon = semicolon
    }
    
    public static func ==(lhs: Field, rhs: Field) -> Bool {
        return lhs.identifier == rhs.identifier &&
            lhs.colon == rhs.colon &&
            lhs.qualifiedName == rhs.qualifiedName &&
            lhs.fieldAssignment == rhs.fieldAssignment &&
            lhs.annotations == rhs.annotations &&
            lhs.semicolon == rhs.semicolon
    }
}

public class FieldAssignment: Equatable {

    public let assignment: Token

    public let conditionalExpression: ConditionalExpression

    public init(assignment: Token, conditionalExpression: ConditionalExpression) {
        self.assignment = assignment
        self.conditionalExpression = conditionalExpression
    }
    
    public static func ==(lhs: FieldAssignment, rhs: FieldAssignment) -> Bool {
        return lhs.assignment == rhs.assignment &&
            lhs.conditionalExpression == rhs.conditionalExpression
    }
}

public class FromAccumulateClause: Equatable {
    
    public let fromKeyword: Token

    public let accumulateClause: AccumulateClause
    
    public init(fromKeyword: Token, accumulateClause: AccumulateClause) {
        self.fromKeyword = fromKeyword
        self.accumulateClause = accumulateClause
    }
    
    public static func ==(lhs: FromAccumulateClause, rhs: FromAccumulateClause) -> Bool {
        return lhs.fromKeyword == rhs.fromKeyword &&
            lhs.accumulateClause == rhs.accumulateClause
    }
}

public class FromClause: Equatable {
    
    public let fromKeyword: Token

    public let conditionalOrExpression: ConditionalOrExpression
    
    public init(fromKeyword: Token, conditionalOrExpression: ConditionalOrExpression) {
        self.fromKeyword = fromKeyword
        self.conditionalOrExpression = conditionalOrExpression
    }
    
    public static func ==(lhs: FromClause, rhs: FromClause) -> Bool {
        return lhs.fromKeyword == rhs.fromKeyword &&
            lhs.conditionalOrExpression == rhs.conditionalOrExpression
    }
}

public class FromCollectClause: Equatable {
    
    public let fromKeyword: Token

    public let collectKeyword: Token

    public let leftParenthesis: Token

    public let sourcePattern: SourcePattern

    public let rightParenthesis: Token
    
    public init(fromKeyword: Token, collectKeyword: Token, leftParenthesis: Token, sourcePattern: SourcePattern, rightParenthesis: Token) {
        self.fromKeyword = fromKeyword
        self.collectKeyword = collectKeyword
        self.leftParenthesis = leftParenthesis
        self.sourcePattern = sourcePattern
        self.rightParenthesis = rightParenthesis
    }
    
    public static func ==(lhs: FromCollectClause, rhs: FromCollectClause) -> Bool {
        return lhs.fromKeyword == rhs.fromKeyword &&
            lhs.collectKeyword == rhs.collectKeyword &&
            lhs.leftParenthesis == rhs.leftParenthesis &&
            lhs.sourcePattern == rhs.sourcePattern &&
            lhs.rightParenthesis == rhs.rightParenthesis
    }
}

public class FullDefinition: Equatable {

    public let definition: AnyDefinition

    public let semicolon: Token?

    public init(definition: AnyDefinition, semicolon: Token?) {
        self.definition = definition
        self.semicolon = semicolon
    }
    
    public static func ==(lhs: FullDefinition, rhs: FullDefinition) -> Bool {
        return lhs.definition == rhs.definition &&
            lhs.semicolon == rhs.semicolon
    }
}

public class FunctionDefinition: Definition, Equatable {

    public let functionKeyword: Token

    public let type: AnyType?

    public let identifier: Identifier

    public let parameters: Parameters

    public let block: Block

    public init(functionKeyword: Token, type: AnyType?, identifier: Identifier, parameters: Parameters, block: Block) {
        self.functionKeyword = functionKeyword
        self.type = type
        self.identifier = identifier
        self.parameters = parameters
        self.block = block
    }
    
    public static func ==(lhs: FunctionDefinition, rhs: FunctionDefinition) -> Bool {
        return lhs.functionKeyword == rhs.functionKeyword &&
            lhs.type == rhs.type &&
            lhs.identifier == rhs.identifier &&
            lhs.parameters == rhs.parameters &&
            lhs.block == rhs.block
    }
}

public class GlobalDefinition: Definition, Equatable {

    public let globalKeyword: Token

    public let type: AnyType

    public let identifier: Identifier

    public init(globalKeyword: Token, type: AnyType, identifier: Identifier) {
        self.globalKeyword = globalKeyword
        self.type = type
        self.identifier = identifier
    }
    
    public static func ==(lhs: GlobalDefinition, rhs: GlobalDefinition) -> Bool {
        return lhs.globalKeyword == rhs.globalKeyword &&
            lhs.type == rhs.type &&
            lhs.identifier == rhs.identifier
    }
}

public class Identifier: StringID, Equatable {

    public let token: Token

    public init(token: Token) {
        self.token = token
    }
    
    public static func ==(lhs: Identifier, rhs: Identifier) -> Bool {
        return lhs.token == rhs.token
    }
}

public class IdentifierSelector: Selector, Equatable {

    public let period: Token

    public let identifier: Identifier

    public let arguments: Arguments?

    public init(period: Token, identifier: Identifier, arguments: Arguments?) {
        self.period = period
        self.identifier = identifier
        self.arguments = arguments
    }
    
    public static func ==(lhs: IdentifierSelector, rhs: IdentifierSelector) -> Bool {
        return lhs.period == rhs.period &&
            lhs.identifier == rhs.identifier &&
            lhs.arguments == rhs.arguments
    }
}

public protocol IdentifierSuffix {
    
    func isEqualTo(other: IdentifierSuffix) -> Bool
}

extension IdentifierSuffix where Self: Equatable {
    
    public func isEqualTo(other: IdentifierSuffix) -> Bool {
        guard let identifierSuffix = other as? Self else { return false }
        return self == identifierSuffix
    }
}

public class AnyIdentifierSuffix: Equatable {
    
    public let identifierSuffix: IdentifierSuffix
    
    public init(identifierSuffix: IdentifierSuffix) {
        self.identifierSuffix = identifierSuffix
    }
    
    public static func ==(lhs: AnyIdentifierSuffix, rhs: AnyIdentifierSuffix) -> Bool {
        return lhs.identifierSuffix.isEqualTo(other: rhs.identifierSuffix)
    }
}

public class IdentifierSuffixClass: IdentifierSuffix, Equatable {

    public let bracketPairs: [BracketPair]

    public let period: Token

    public let classKeyword: Token

    public init(bracketPairs: [BracketPair], period: Token, classKeyword: Token) {
        self.bracketPairs = bracketPairs
        self.period = period
        self.classKeyword = classKeyword
    }
    
    public static func ==(lhs: IdentifierSuffixClass, rhs: IdentifierSuffixClass) -> Bool {
        return lhs.bracketPairs == rhs.bracketPairs &&
            lhs.period == rhs.period &&
            lhs.classKeyword == rhs.classKeyword
    }
}

public class IdentifierSuperSuffix: SuperSuffix, Equatable {

    public let period: Token

    public let identifier: Identifier

    public let arguments: Arguments?

    public init(period: Token, identifier: Identifier, arguments: Arguments?) {
        self.period = period
        self.identifier = identifier
        self.arguments = arguments
    }
    
    public static func ==(lhs: IdentifierSuperSuffix, rhs: IdentifierSuperSuffix) -> Bool {
        return lhs.period == rhs.period &&
            lhs.identifier == rhs.identifier &&
            lhs.arguments == rhs.arguments
    }
}

public class ImportDefinition: Definition, Equatable {

    public let importKeyword: Token

    public let functionOrStaticKeyword: Token?

    public let qualifiedName: QualifiedName

    public let importDefinitionSuffix: ImportDefinitionSuffix?

    public init(importKeyword: Token, functionOrStaticKeyword: Token?, qualifiedName: QualifiedName, importDefinitionSuffix: ImportDefinitionSuffix?) {
        self.importKeyword = importKeyword
        self.functionOrStaticKeyword = functionOrStaticKeyword
        self.qualifiedName = qualifiedName
        self.importDefinitionSuffix = importDefinitionSuffix
    }
    
    public static func ==(lhs: ImportDefinition, rhs: ImportDefinition) -> Bool {
        return lhs.importKeyword == rhs.importKeyword &&
            lhs.functionOrStaticKeyword == rhs.functionOrStaticKeyword &&
            lhs.qualifiedName == rhs.qualifiedName &&
            lhs.importDefinitionSuffix == rhs.importDefinitionSuffix
    }
}

public class ImportDefinitionSuffix: Equatable {

    public let period: Token

    public let asterisk: Token

    public init(period: Token, asterisk: Token) {
        self.period = period
        self.asterisk = asterisk
    }
    
    public static func ==(lhs: ImportDefinitionSuffix, rhs: ImportDefinitionSuffix) -> Bool {
        return lhs.period == rhs.period &&
            lhs.asterisk == rhs.asterisk
    }
}

public class InExpression: Equatable {

    public let relationalExpression: RelationalExpression

    public let notKeyword: Token?

    public let keyword: Token

    public let leftParenthesis: Token

    public let expressions: [Expression]

    public let rightParenthesis: Token

    public init(relationalExpression: RelationalExpression, notKeyword: Token?, keyword: Token, leftParenthesis: Token, expressions: [Expression], rightParenthesis: Token) {
        self.relationalExpression = relationalExpression
        self.notKeyword = notKeyword
        self.keyword = keyword
        self.leftParenthesis = leftParenthesis
        self.expressions = expressions
        self.rightParenthesis = rightParenthesis
    }
    
    public static func ==(lhs: InExpression, rhs: InExpression) -> Bool {
        return lhs.relationalExpression == rhs.relationalExpression &&
            lhs.notKeyword == rhs.notKeyword &&
            lhs.keyword == rhs.keyword &&
            lhs.leftParenthesis == rhs.leftParenthesis &&
            lhs.expressions == rhs.expressions &&
            lhs.rightParenthesis == rhs.rightParenthesis
    }
}

public class InheritanceTypeArgument: TypeArgument, Equatable {

    public let questionMark: Token

    public let inheritanceTypeArgumentSuffix: InheritanceTypeArgumentSuffix?

    public init(questionMark: Token, inheritanceTypeArgumentSuffix: InheritanceTypeArgumentSuffix?) {
        self.questionMark = questionMark
        self.inheritanceTypeArgumentSuffix = inheritanceTypeArgumentSuffix
    }
    
    public static func ==(lhs: InheritanceTypeArgument, rhs: InheritanceTypeArgument) -> Bool {
        return lhs.questionMark == rhs.questionMark &&
            lhs.inheritanceTypeArgumentSuffix == rhs.inheritanceTypeArgumentSuffix
    }
}

public class InheritanceTypeArgumentSuffix: Equatable {

    public let extendsOrSuperKeyword: Token

    public let type: AnyType

    public init(extendsOrSuperKeyword: Token, type: AnyType) {
        self.extendsOrSuperKeyword = extendsOrSuperKeyword
        self.type = type
    }
    
    public static func ==(lhs: InheritanceTypeArgumentSuffix, rhs: InheritanceTypeArgumentSuffix) -> Bool {
        return lhs.extendsOrSuperKeyword == rhs.extendsOrSuperKeyword &&
            lhs.type == rhs.type
    }
}

public class InlineListExpression: Primary, Equatable {

    public let leftBracket: Token

    public let expressions: [Expression]

    public let rightBracket: Token

    public init(leftBracket: Token, expressions: [Expression], rightBracket: Token) {
        self.leftBracket = leftBracket
        self.expressions = expressions
        self.rightBracket = rightBracket
    }
    
    public static func ==(lhs: InlineListExpression, rhs: InlineListExpression) -> Bool {
        return lhs.leftBracket == rhs.leftBracket &&
            lhs.expressions == rhs.expressions &&
            lhs.rightBracket == rhs.rightBracket
    }
}

public class InlineMapExpression: Primary, Equatable {

    public let leftBracket: Token

    public let mappings: [Mapping]

    public let rightBracket: Token

    public init(leftBracket: Token, mappings: [Mapping], rightBracket: Token) {
        self.leftBracket = leftBracket
        self.mappings = mappings
        self.rightBracket = rightBracket
    }
    
    public static func ==(lhs: InlineMapExpression, rhs: InlineMapExpression) -> Bool {
        return lhs.leftBracket == rhs.leftBracket &&
            lhs.mappings == rhs.mappings &&
            lhs.rightBracket == rhs.rightBracket
    }
}

public class InnerCreator: Equatable {

    public let identifier: Identifier

    public let arguments: Arguments

    public init(identifier: Identifier, arguments: Arguments) {
        self.identifier = identifier
        self.arguments = arguments
    }
    
    public static func ==(lhs: InnerCreator, rhs: InnerCreator) -> Bool {
        return lhs.identifier == rhs.identifier &&
            lhs.arguments == rhs.arguments
    }
}

public class InstanceOfExpression: Equatable {

    public let inExpression: InExpression

    public let instanceOfSuffix: InstanceOfSuffix?

    public init(inExpression: InExpression, instanceOfSuffix: InstanceOfSuffix?) {
        self.inExpression = inExpression
        self.instanceOfSuffix = instanceOfSuffix
    }
    
    public static func ==(lhs: InstanceOfExpression, rhs: InstanceOfExpression) -> Bool {
        return lhs.inExpression == rhs.inExpression &&
            lhs.instanceOfSuffix == rhs.instanceOfSuffix
    }
}

public class InstanceOfSuffix: Equatable {

    public let instanceOfKeyword: Token

    public let type: AnyType

    public init(instanceOfKeyword: Token, type: AnyType) {
        self.instanceOfKeyword = instanceOfKeyword
        self.type = type
    }
    
    public static func ==(lhs: InstanceOfSuffix, rhs: InstanceOfSuffix) -> Bool {
        return lhs.instanceOfKeyword == rhs.instanceOfKeyword &&
            lhs.type == rhs.type
    }
}

public class IntLiteral: Literal, Equatable {

    public let token: Token

    public init(token: Token) {
        self.token = token
    }
    
    public static func ==(lhs: IntLiteral, rhs: IntLiteral) -> Bool {
        return lhs.token == rhs.token
    }
}

public protocol Literal: Primary {
    
    func isEqualTo(other: Literal) -> Bool
}

extension Literal where Self: Equatable {
    
    public func isEqualTo(other: Literal) -> Bool {
        guard let literal = other as? Self else { return false }
        return self == literal
    }
}

public class AnyLiteral: Equatable {
    
    public let literal: Literal
    
    public init(literal: Literal) {
        self.literal = literal
    }
    
    public static func ==(lhs: AnyLiteral, rhs: AnyLiteral) -> Bool {
        return lhs.literal.isEqualTo(other: rhs.literal)
    }
}

public class Mapping: Equatable {

    public let leftExpression: Expression

    public let colon: Token

    public let rightExpression: Expression

    public init(leftExpression: Expression, colon: Token, rightExpression: Expression) {
        self.leftExpression = leftExpression
        self.colon = colon
        self.rightExpression = rightExpression
    }
    
    public static func ==(lhs: Mapping, rhs: Mapping) -> Bool {
        return lhs.leftExpression == rhs.leftExpression &&
            lhs.colon == rhs.colon &&
            lhs.rightExpression == rhs.rightExpression
    }
}

public class ModifyStatement: RHSStatement, Equatable {

    public let modifyKeyword: Token

    public let leftParenthesis: Token

    public let conditionalExpression: ConditionalExpression

    public let rightParenthesis: Token

    public let leftBrace: Token

    public let conditionalExpressions: [ConditionalExpression]

    public let rightBrace: Token

    public init(modifyKeyword: Token, leftParenthesis: Token, conditionalExpression: ConditionalExpression, rightParenthesis: Token, leftBrace: Token, conditionalExpressions: [ConditionalExpression], rightBrace: Token) {
        self.modifyKeyword = modifyKeyword
        self.leftParenthesis = leftParenthesis
        self.conditionalExpression = conditionalExpression
        self.rightParenthesis = rightParenthesis
        self.leftBrace = leftBrace
        self.conditionalExpressions = conditionalExpressions
        self.rightBrace = rightBrace
    }
    
    public static func ==(lhs: ModifyStatement, rhs: ModifyStatement) -> Bool {
        return lhs.modifyKeyword == rhs.modifyKeyword &&
            lhs.leftParenthesis == rhs.leftParenthesis &&
            lhs.conditionalExpression == rhs.conditionalExpression &&
            lhs.rightParenthesis == rhs.rightParenthesis &&
            lhs.leftBrace == rhs.leftBrace &&
            lhs.conditionalExpressions == rhs.conditionalExpressions &&
            lhs.rightBrace == rhs.rightBrace
    }
}

public class NewSelector: Selector, Equatable {

    public let period: Token

    public let newKeyword: Token

    public let nonWildcardTypeArguments: NonWildcardTypeArguments?

    public let innerCreator: InnerCreator

    public init(period: Token, newKeyword: Token, nonWildcardTypeArguments: NonWildcardTypeArguments?, innerCreator: InnerCreator) {
        self.period = period
        self.newKeyword = newKeyword
        self.nonWildcardTypeArguments = nonWildcardTypeArguments
        self.innerCreator = innerCreator
    }
    
    public static func ==(lhs: NewSelector, rhs: NewSelector) -> Bool {
        return lhs.period == rhs.period &&
            lhs.newKeyword == rhs.newKeyword &&
            lhs.nonWildcardTypeArguments == rhs.nonWildcardTypeArguments &&
            lhs.innerCreator == rhs.innerCreator
    }
}

public class NonWildcardTypeArguments: Equatable {

    public let leftAngle: Token

    public let types: [AnyType]

    public let rightAngle: Token

    public init(leftAngle: Token, types: [AnyType], rightAngle: Token) {
        self.leftAngle = leftAngle
        self.types = types
        self.rightAngle = rightAngle
    }
    
    public static func ==(lhs: NonWildcardTypeArguments, rhs: NonWildcardTypeArguments) -> Bool {
        return lhs.leftAngle == rhs.leftAngle &&
            lhs.types == rhs.types &&
            lhs.rightAngle == rhs.rightAngle
    }
}

public class OrRestriction: Equatable {

    public let singleRestriction: AnySingleRestriction

    public let orRestrictionRHS: OrRestrictionRHS?

    public init(singleRestriction: AnySingleRestriction, orRestrictionRHS: OrRestrictionRHS?) {
        self.singleRestriction = singleRestriction
        self.orRestrictionRHS = orRestrictionRHS
    }
    
    public static func ==(lhs: OrRestriction, rhs: OrRestriction) -> Bool {
        return lhs.singleRestriction == rhs.singleRestriction &&
            lhs.orRestrictionRHS == rhs.orRestrictionRHS
    }
}

public class OrRestrictionRHS: Equatable {

    public let `operator`: Token

    public let singleRestriction: AnySingleRestriction

    public let orRestrictionRHS: OrRestrictionRHS?

    public init(operator: Token, singleRestriction: AnySingleRestriction, orRestrictionRHS: OrRestrictionRHS?) {
        self.operator = `operator`
        self.singleRestriction = singleRestriction
        self.orRestrictionRHS = orRestrictionRHS
    }
    
    public static func ==(lhs: OrRestrictionRHS, rhs: OrRestrictionRHS) -> Bool {
        return lhs.operator == rhs.operator &&
            lhs.singleRestriction == rhs.singleRestriction &&
            lhs.orRestrictionRHS == rhs.orRestrictionRHS
    }
}

public class OverClause: Equatable {

    public let overKeyword: Token

    public let leftIdentifier: Identifier

    public let colon: Token

    public let rightIdentifier: Identifier

    public let leftParenthesis: Token

    public let conditionalExpressions: [ConditionalExpression]

    public let rightParenthesis: Token

    public init(overKeyword: Token, leftIdentifier: Identifier, colon: Token, rightIdentifier: Identifier, leftParenthesis: Token, conditionalExpressions: [ConditionalExpression], rightParenthesis: Token) {
        self.overKeyword = overKeyword
        self.leftIdentifier = leftIdentifier
        self.colon = colon
        self.rightIdentifier = rightIdentifier
        self.leftParenthesis = leftParenthesis
        self.conditionalExpressions = conditionalExpressions
        self.rightParenthesis = rightParenthesis
    }
    
    public static func ==(lhs: OverClause, rhs: OverClause) -> Bool {
        return lhs.overKeyword == rhs.overKeyword &&
            lhs.leftIdentifier == rhs.leftIdentifier &&
            lhs.colon == rhs.colon &&
            lhs.rightIdentifier == rhs.rightIdentifier &&
            lhs.leftParenthesis == rhs.leftParenthesis &&
            lhs.conditionalExpressions == rhs.conditionalExpressions &&
            lhs.rightParenthesis == rhs.rightParenthesis
    }
}

public class PackageDeclaration: Equatable {

    public let packageKeyword: Token

    public let qualifiedName: QualifiedName

    public let semicolon: Token?

    public init(packageKeyword: Token, qualifiedName: QualifiedName, semicolon: Token?) {
        self.packageKeyword = packageKeyword
        self.qualifiedName = qualifiedName
        self.semicolon = semicolon
    }
    
    public static func ==(lhs: PackageDeclaration, rhs: PackageDeclaration) -> Bool {
        return lhs.packageKeyword == rhs.packageKeyword &&
            lhs.qualifiedName == rhs.qualifiedName &&
            lhs.semicolon == rhs.semicolon
    }
}

public class Parameter: Equatable {

    public let type: AnyType

    public let identifier: Identifier

    public let bracketPairs: [BracketPair]

    public init(type: AnyType, identifier: Identifier, bracketPairs: [BracketPair]) {
        self.type = type
        self.identifier = identifier
        self.bracketPairs = bracketPairs
    }
    
    public static func ==(lhs: Parameter, rhs: Parameter) -> Bool {
        return lhs.type == rhs.type &&
            lhs.identifier == rhs.identifier &&
            lhs.bracketPairs == rhs.bracketPairs
    }
}

public class Parameters: QueryOptionsPrefix, Equatable {

    public let leftParenthesis: Token

    public let parameters: [Parameter]

    public let rightParenthesis: Token

    public init(leftParenthesis: Token, parameters: [Parameter], rightParenthesis: Token) {
        self.leftParenthesis = leftParenthesis
        self.parameters = parameters
        self.rightParenthesis = rightParenthesis
    }
    
    public static func ==(lhs: Parameters, rhs: Parameters) -> Bool {
        return lhs.leftParenthesis == rhs.leftParenthesis &&
            lhs.parameters == rhs.parameters &&
            lhs.rightParenthesis == rhs.rightParenthesis
    }
}

public class ParenthesizedConditionalOr: ConditionalElementBody, ConditionalElementExistsBody, ConditionalElementNotBody, Equatable {

    public let leftParenthesis: Token

    public let conditionalOr: ConditionalOr

    public let rightParenthesis: Token

    public init(leftParenthesis: Token, conditionalOr: ConditionalOr, rightParenthesis: Token) {
        self.leftParenthesis = leftParenthesis
        self.conditionalOr = conditionalOr
        self.rightParenthesis = rightParenthesis
    }
    
    public static func ==(lhs: ParenthesizedConditionalOr, rhs: ParenthesizedConditionalOr) -> Bool {
        return lhs.leftParenthesis == rhs.leftParenthesis &&
            lhs.conditionalOr == rhs.conditionalOr &&
            lhs.rightParenthesis == rhs.rightParenthesis
    }
}

public class ParenthesizedOrRestriction: SingleRestriction, Equatable {

    public let leftParenthesis: Token

    public let orRestriction: OrRestriction

    public let rightParenthesis: Token

    public init(leftParenthesis: Token, orRestriction: OrRestriction, rightParenthesis: Token) {
        self.leftParenthesis = leftParenthesis
        self.orRestriction = orRestriction
        self.rightParenthesis = rightParenthesis
    }
    
    public static func ==(lhs: ParenthesizedOrRestriction, rhs: ParenthesizedOrRestriction) -> Bool {
        return lhs.leftParenthesis == rhs.leftParenthesis &&
            lhs.orRestriction == rhs.orRestriction &&
            lhs.rightParenthesis == rhs.rightParenthesis
    }
}

public class ParenthesizedExpression: Primary, Equatable {
    
    public let leftParenthesis: Token
    
    public let expression: Expression
    
    public let rightParenthesis: Token
    
    public init(leftParenthesis: Token, expression: Expression, rightParenthesis: Token) {
        self.leftParenthesis = leftParenthesis
        self.expression = expression
        self.rightParenthesis = rightParenthesis
    }
    
    public static func ==(lhs: ParenthesizedExpression, rhs: ParenthesizedExpression) -> Bool {
        return lhs.leftParenthesis == rhs.leftParenthesis &&
            lhs.expression == rhs.expression &&
            lhs.rightParenthesis == rhs.rightParenthesis
    }
}

// NOTE: This is the unnamed blue diagram in the parse diagrams.
public class Pattern: Equatable {
        
    // public let patternBindingPrefix: PatternBindingPrefix?
    
    public let patternType: PatternType
    
    public let leftParenthesis: Token
    
    public let constraints: Constraints
    
    public let rightParenthesis: Token
    
    public init(patternType: PatternType, leftParenthesis: Token, constraints: Constraints, rightParenthesis: Token) {
        // self.patternBindingPrefix = patternBindingPrefix
        self.patternType = patternType
        self.leftParenthesis = leftParenthesis
        self.constraints = constraints
        self.rightParenthesis = rightParenthesis
    }
    
    public static func ==(lhs: Pattern, rhs: Pattern) -> Bool {
        return lhs.patternType == rhs.patternType &&
            lhs.leftParenthesis == rhs.leftParenthesis &&
            lhs.constraints == rhs.constraints &&
            lhs.rightParenthesis == rhs.rightParenthesis
    }
}

public class PatternBinding: Equatable {
    
    public let identifier: Identifier
    
    public init(identifier: Identifier) {
        self.identifier = identifier
    }
    
    public static func ==(lhs: PatternBinding, rhs: PatternBinding) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

public class PatternBindingPrefix: Equatable {
    
    public let patternBinding: PatternBinding
    
    public let colon: Token
    
    public init(patternBinding: PatternBinding, colon: Token) {
        self.patternBinding = patternBinding
        self.colon = colon
    }
    
    public static func ==(lhs: PatternBindingPrefix, rhs: PatternBindingPrefix) -> Bool {
        return lhs.patternBinding == rhs.patternBinding &&
            lhs.colon == rhs.colon
    }
}

public class PatternType: Equatable {
    
    public let identifier: Identifier
    
    public init(identifier: Identifier) {
        self.identifier = identifier
    }
    
    public static func ==(lhs: PatternType, rhs: PatternType) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

public class Placeholders: QueryOptionsPrefix, Equatable {

    public let leftParenthesis: Token

    public let identifiers: [Identifier]

    public let rightParenthesis: Token

    public init(leftParenthesis: Token, identifiers: [Identifier], rightParenthesis: Token) {
        self.leftParenthesis = leftParenthesis
        self.identifiers = identifiers
        self.rightParenthesis = rightParenthesis
    }
    
    public static func ==(lhs: Placeholders, rhs: Placeholders) -> Bool {
        return lhs.leftParenthesis == rhs.leftParenthesis &&
            lhs.identifiers == rhs.identifiers &&
            lhs.rightParenthesis == rhs.rightParenthesis
    }
}

public protocol Primary {
    
    func isEqualTo(other: Primary) -> Bool
}

extension Primary where Self: Equatable {
    
    public func isEqualTo(other: Primary) -> Bool {
        guard let primary = other as? Self else { return false }
        return self == primary
    }
}

public class AnyPrimary: Equatable {
    
    public let primary: Primary
    
    public init(primary: Primary) {
        self.primary = primary
    }
    
    public static func ==(lhs: AnyPrimary, rhs: AnyPrimary) -> Bool {
        return lhs.primary.isEqualTo(other: rhs.primary)
    }
}

public class PrimaryIdentifier: Primary, Equatable {
        
    public let identifiers: [Identifier]
    
    public let identifierSuffix: AnyIdentifierSuffix?
    
    internal init(identifiers: [Identifier], identifierSuffix: AnyIdentifierSuffix?) {
        self.identifiers = identifiers
        self.identifierSuffix = identifierSuffix
    }
    
    public static func ==(lhs: PrimaryIdentifier, rhs: PrimaryIdentifier) -> Bool {
        return lhs.identifiers == rhs.identifiers &&
            lhs.identifierSuffix == rhs.identifierSuffix
    }
}

public class PrimaryNewCreator: Primary, Equatable {
    
    public let newKeyword: Token
    
    public let creator: Creator
    
    public init(newKeyword: Token, creator: Creator) {
        self.newKeyword = newKeyword
        self.creator = creator
    }
    
    public static func ==(lhs: PrimaryNewCreator, rhs: PrimaryNewCreator) -> Bool {
        return lhs.newKeyword == rhs.newKeyword &&
            lhs.creator == rhs.creator
    }
}

public class PrimaryNonWildcardTypeArguments: Primary, Equatable {
        
    public let nonWildcardTypeArguments: NonWildcardTypeArguments
    
    public let primaryNonWildcardTypeArgumentsSuffix: AnyPrimaryNonWildcardTypeArgumentsSuffix
    
    public init(nonWildcardTypeArguments: NonWildcardTypeArguments, primaryNonWildcardTypeArgumentsSuffix: AnyPrimaryNonWildcardTypeArgumentsSuffix) {
        self.nonWildcardTypeArguments = nonWildcardTypeArguments
        self.primaryNonWildcardTypeArgumentsSuffix = primaryNonWildcardTypeArgumentsSuffix
    }
    
    public static func ==(lhs: PrimaryNonWildcardTypeArguments, rhs: PrimaryNonWildcardTypeArguments) -> Bool {
        return lhs.nonWildcardTypeArguments == rhs.nonWildcardTypeArguments &&
            lhs.primaryNonWildcardTypeArgumentsSuffix == rhs.primaryNonWildcardTypeArgumentsSuffix
    }
}

public protocol PrimaryNonWildcardTypeArgumentsSuffix {
    
    func isEqualTo(other: PrimaryNonWildcardTypeArgumentsSuffix) -> Bool
}

extension PrimaryNonWildcardTypeArgumentsSuffix where Self: Equatable {
    
    public func isEqualTo(other: PrimaryNonWildcardTypeArgumentsSuffix) -> Bool {
        guard let primaryNonWildcardTypeArgumentsSuffix = other as? Self else { return false }
        return self == primaryNonWildcardTypeArgumentsSuffix
    }
}

public class AnyPrimaryNonWildcardTypeArgumentsSuffix: Equatable {
    
    public let primaryNonWildcardTypeArgumentsSuffix: PrimaryNonWildcardTypeArgumentsSuffix
    
    public init(primaryNonWildcardTypeArgumentsSuffix: PrimaryNonWildcardTypeArgumentsSuffix) {
        self.primaryNonWildcardTypeArgumentsSuffix = primaryNonWildcardTypeArgumentsSuffix
    }
    
    public static func ==(lhs: AnyPrimaryNonWildcardTypeArgumentsSuffix, rhs: AnyPrimaryNonWildcardTypeArgumentsSuffix) -> Bool {
        return lhs.primaryNonWildcardTypeArgumentsSuffix.isEqualTo(other: rhs.primaryNonWildcardTypeArgumentsSuffix)
    }
}

public class PrimaryNonWildcardTypeArgumentsThisSuffix: PrimaryNonWildcardTypeArgumentsSuffix, Equatable {
    
    public let thisKeyword: Token
    
    public let arguments: Arguments
    
    public init(thisKeyword: Token, arguments: Arguments) {
        self.thisKeyword = thisKeyword
        self.arguments = arguments
    }
    
    public static func ==(lhs: PrimaryNonWildcardTypeArgumentsThisSuffix, rhs: PrimaryNonWildcardTypeArgumentsThisSuffix) -> Bool {
        return lhs.thisKeyword == rhs.thisKeyword &&
            lhs.arguments == rhs.arguments
    }
}

public class PrimaryPrimitiveTypeClass: Primary, Equatable {
        
    public let primitiveType: PrimitiveType
    
    public let bracketPairs: [BracketPair]
    
    public let period: Token
    
    public let classKeyword: Token
    
    public init(primitiveType: PrimitiveType, bracketPairs: [BracketPair], period: Token, classKeyword: Token) {
        self.primitiveType = primitiveType
        self.bracketPairs = bracketPairs
        self.period = period
        self.classKeyword = classKeyword
    }
    
    public static func ==(lhs: PrimaryPrimitiveTypeClass, rhs: PrimaryPrimitiveTypeClass) -> Bool {
        return lhs.primitiveType == rhs.primitiveType &&
            lhs.bracketPairs == rhs.bracketPairs &&
            lhs.period == rhs.period &&
            lhs.classKeyword == rhs.classKeyword
    }
}

public class PrimaryThisKeyword: Primary, Equatable {
    
    public let thisKeyword: Token
    
    public init(thisKeyword: Token) {
        self.thisKeyword = thisKeyword
    }
    
    public static func ==(lhs: PrimaryThisKeyword, rhs: PrimaryThisKeyword) -> Bool {
        return lhs.thisKeyword == rhs.thisKeyword
    }
}

public class PrimaryVoidClass: Primary, Equatable {
        
    public let voidKeyword: Token
    
    public let period: Token
    
    public let classKeyword: Token
    
    public init(voidKeyword: Token, period: Token, classKeyword: Token) {
        self.voidKeyword = voidKeyword
        self.period = period
        self.classKeyword = classKeyword
    }
    
    public static func ==(lhs: PrimaryVoidClass, rhs: PrimaryVoidClass) -> Bool {
        return lhs.voidKeyword == rhs.voidKeyword &&
            lhs.period == rhs.period &&
            lhs.classKeyword == rhs.classKeyword
    }
}

public class PrimarySuperSuffix: Primary, Equatable {
        
    public let superKeyword: Token
    
    public let superSuffix: AnySuperSuffix
    
    public init(superKeyword: Token, superSuffix: AnySuperSuffix) {
        self.superKeyword = superKeyword
        self.superSuffix = superSuffix
    }
    
    public static func ==(lhs: PrimarySuperSuffix, rhs: PrimarySuperSuffix) -> Bool {
        return lhs.superKeyword == rhs.superKeyword &&
            lhs.superSuffix == rhs.superSuffix
    }
}

public class PrimitiveType: CreatedName, UnaryExpressionCastType, Equatable {

    public let token: Token

    public init(token: Token) {
        self.token = token
    }
    
    public static func ==(lhs: PrimitiveType, rhs: PrimitiveType) -> Bool {
        return lhs.token == rhs.token
    }
}

public class QualifiedName: Equatable {

    public let identifiers: [Identifier]

    public init(identifiers: [Identifier]) {
        self.identifiers = identifiers
    }
    
    public static func ==(lhs: QualifiedName, rhs: QualifiedName) -> Bool {
        return lhs.identifiers == rhs.identifiers
    }
}

public class QueryDefinition: Definition, Equatable {

    public let queryKeyword: Token

    public let stringID: AnyStringID

    public let queryOptions: QueryOptions

    public let conditionalOrs: [ConditionalOr]

    public let endKeyword: Token

    public init(queryKeyword: Token, stringID: AnyStringID, queryOptions: QueryOptions, conditionalOrs: [ConditionalOr], endKeyword: Token) {
        self.queryKeyword = queryKeyword
        self.stringID = stringID
        self.queryOptions = queryOptions
        self.conditionalOrs = conditionalOrs
        self.endKeyword = endKeyword
    }
    
    public static func ==(lhs: QueryDefinition, rhs: QueryDefinition) -> Bool {
        return lhs.queryKeyword == rhs.queryKeyword &&
            lhs.stringID == rhs.stringID &&
            lhs.queryOptions == rhs.queryOptions &&
            lhs.conditionalOrs == rhs.conditionalOrs &&
            lhs.endKeyword == rhs.endKeyword
    }
}

public class QueryOptions: Equatable {

    public let queryOptionsPrefix: AnyQueryOptionsPrefix?

    public let annotations: [Annotation]

    public init(queryOptionsPrefix: AnyQueryOptionsPrefix?, annotations: [Annotation]) {
        self.queryOptionsPrefix = queryOptionsPrefix
        self.annotations = annotations
    }
    
    public static func ==(lhs: QueryOptions, rhs: QueryOptions) -> Bool {
        return lhs.queryOptionsPrefix == rhs.queryOptionsPrefix &&
            lhs.annotations == rhs.annotations
    }
}

public protocol QueryOptionsPrefix {
    
    func isEqualTo(other: QueryOptionsPrefix) -> Bool
}

extension QueryOptionsPrefix where Self: Equatable {
    
    public func isEqualTo(other: QueryOptionsPrefix) -> Bool {
        guard let queryOptionsPrefix = other as? Self else { return false }
        return self == queryOptionsPrefix
    }
}

public class AnyQueryOptionsPrefix: Equatable {
    
    public let queryOptionsPrefix: QueryOptionsPrefix
    
    public init(queryOptionsPrefix: QueryOptionsPrefix) {
        self.queryOptionsPrefix = queryOptionsPrefix
    }
    
    public static func ==(lhs: AnyQueryOptionsPrefix, rhs: AnyQueryOptionsPrefix) -> Bool {
        lhs.queryOptionsPrefix.isEqualTo(other: rhs.queryOptionsPrefix)
    }
}

public class RealLiteral: Literal, Equatable {

    public let token: Token

    public init(token: Token) {
        self.token = token
    }
    
    public static func ==(lhs: RealLiteral, rhs: RealLiteral) -> Bool {
        return lhs.token == rhs.token
    }
}

public class RelationalExpression: Equatable {

    public let shiftExpression: ShiftExpression

    public let orRestrictions: [OrRestriction]

    public init(shiftExpression: ShiftExpression, orRestrictions: [OrRestriction]) {
        self.shiftExpression = shiftExpression
        self.orRestrictions = orRestrictions
    }
    
    public static func ==(lhs: RelationalExpression, rhs: RelationalExpression) -> Bool {
        return lhs.shiftExpression == rhs.shiftExpression &&
            lhs.orRestrictions == rhs.orRestrictions
    }
}

public protocol RelationalOperator {
    
    func isEqualTo(other: RelationalOperator) -> Bool
}

extension RelationalOperator where Self: Equatable {
    
    public func isEqualTo(other: RelationalOperator) -> Bool {
        guard let relationalOperator = other as? Self else { return false }
        return self == relationalOperator
    }
}

public class AnyRelationalOperator: Equatable {
    
    public let relationalOperator: RelationalOperator
    
    public init(relationalOperator: RelationalOperator) {
        self.relationalOperator = relationalOperator
    }
    
    public static func ==(lhs: AnyRelationalOperator, rhs: AnyRelationalOperator) -> Bool {
        return lhs.relationalOperator.isEqualTo(other: rhs.relationalOperator)
    }
}

public class RelationalOperatorExpression: RelationalOperator, Equatable {

    public let notKeyword: Token?

    public let identifier: Identifier

    public let bracketedExpressions: BracketedExpressions?

    public init(notKeyword: Token?, identifier: Identifier, bracketedExpressions: BracketedExpressions?) {
        self.notKeyword = notKeyword
        self.identifier = identifier
        self.bracketedExpressions = bracketedExpressions
    }
    
    public static func ==(lhs: RelationalOperatorExpression, rhs: RelationalOperatorExpression) -> Bool {
        return lhs.notKeyword == rhs.notKeyword &&
            lhs.identifier == rhs.identifier &&
            lhs.bracketedExpressions == rhs.bracketedExpressions
    }
}

public class RelationalOperatorToken: RelationalOperator, Equatable {

    public let token: Token

    public init(token: Token) {
        self.token = token
    }
    
    public static func ==(lhs: RelationalOperatorToken, rhs: RelationalOperatorToken) -> Bool {
        return lhs.token == rhs.token
    }
}

public protocol RHSStatement {
    
    func isEqualTo(other: RHSStatement) -> Bool
}

extension RHSStatement where Self: Equatable {
    
    public func isEqualTo(other: RHSStatement) -> Bool {
        guard let rhsStatement = other as? Self else { return false }
        return self == rhsStatement
    }
}

public class AnyRHSStatement: Equatable {
    
    public let rhsStatement: RHSStatement
    
    public init(rhsStatement: RHSStatement) {
        self.rhsStatement = rhsStatement
    }
    
    public static func ==(lhs: AnyRHSStatement, rhs: AnyRHSStatement) -> Bool {
        return lhs.rhsStatement.isEqualTo(other: rhs.rhsStatement)
    }
}

public protocol RuleAttribute: Definition {
    
    func isEqualTo(other: RuleAttribute) -> Bool
}

extension RuleAttribute where Self: Equatable {
    
    public func isEqualTo(other: RuleAttribute) -> Bool {
        guard let ruleAttribute = other as? Self else { return false }
        return self == ruleAttribute
    }
}

public class AnyRuleAttribute: Equatable {
    
    public let ruleAttribute: RuleAttribute
    
    public init(ruleAttribute: RuleAttribute) {
        self.ruleAttribute = ruleAttribute
    }
    
    public static func ==(lhs: AnyRuleAttribute, rhs: AnyRuleAttribute) -> Bool {
        return lhs.ruleAttribute.isEqualTo(other: rhs.ruleAttribute)
    }
}

public class RuleAttributes: Equatable {

    public let ruleAttributesPrefix: RuleAttributesPrefix?

    public let ruleAttributesSuffix: RuleAttributesSuffix?

    public init(ruleAttributesPrefix: RuleAttributesPrefix?, ruleAttributesSuffix: RuleAttributesSuffix?) {
        self.ruleAttributesPrefix = ruleAttributesPrefix
        self.ruleAttributesSuffix = ruleAttributesSuffix
    }
    
    public static func ==(lhs: RuleAttributes, rhs: RuleAttributes) -> Bool {
        return lhs.ruleAttributesPrefix == rhs.ruleAttributesPrefix &&
            lhs.ruleAttributesSuffix == rhs.ruleAttributesSuffix
    }
}

public class RuleAttributesPrefix: Equatable {

    public let attributesKeyword: Token

    public let colon: Token?

    public init(attributesKeyword: Token, colon: Token?) {
        self.attributesKeyword = attributesKeyword
        self.colon = colon
    }
    
    public static func ==(lhs: RuleAttributesPrefix, rhs: RuleAttributesPrefix) -> Bool {
        return lhs.attributesKeyword == rhs.attributesKeyword &&
            lhs.colon == rhs.colon
    }
}

public class RuleAttributesSuffix: Equatable {

    public let ruleAttributesSuffixSegments: [RuleAttributesSuffixSegment]

    public init(ruleAttributesSuffixSegments: [RuleAttributesSuffixSegment]) {
        self.ruleAttributesSuffixSegments = ruleAttributesSuffixSegments
    }
    
    public static func ==(lhs: RuleAttributesSuffix, rhs: RuleAttributesSuffix) -> Bool {
        return lhs.ruleAttributesSuffixSegments == rhs.ruleAttributesSuffixSegments
    }
}

public class RuleAttributesSuffixSegment: Equatable {

    public let ruleAttribute: AnyRuleAttribute

    public let comma: Token?

    public init(ruleAttribute: AnyRuleAttribute, comma: Token?) {
        self.ruleAttribute = ruleAttribute
        self.comma = comma
    }
    
    public static func ==(lhs: RuleAttributesSuffixSegment, rhs: RuleAttributesSuffixSegment) -> Bool {
        return lhs.ruleAttribute == rhs.ruleAttribute &&
            lhs.comma == rhs.comma
    }
}

public class RuleDefinition: Definition, Equatable {

    public let ruleKeyword: Token

    public let stringID: AnyStringID

    public let ruleOptions: RuleOptions

    public let whenPart: WhenPart?

    public let thenPart: ThenPart

    public init(ruleKeyword: Token, stringID: AnyStringID, ruleOptions: RuleOptions, whenPart: WhenPart?, thenPart: ThenPart) {
        self.ruleKeyword = ruleKeyword
        self.stringID = stringID
        self.ruleOptions = ruleOptions
        self.whenPart = whenPart
        self.thenPart = thenPart
    }
    
    public static func ==(lhs: RuleDefinition, rhs: RuleDefinition) -> Bool {
        return lhs.ruleKeyword == rhs.ruleKeyword &&
            lhs.stringID == rhs.stringID &&
            lhs.ruleOptions == rhs.ruleOptions &&
            lhs.whenPart == rhs.whenPart &&
            lhs.thenPart == rhs.thenPart
    }
}

public class RuleOptions: Equatable {

    public let extendsClause: ExtendsClause?

    public let annotations: [Annotation]

    public let ruleAttributes: RuleAttributes?

    public init(extendsClause: ExtendsClause?, annotations: [Annotation], ruleAttributes: RuleAttributes?) {
        self.extendsClause = extendsClause
        self.annotations = annotations
        self.ruleAttributes = ruleAttributes
    }
    
    public static func ==(lhs: RuleOptions, rhs: RuleOptions) -> Bool {
        return lhs.extendsClause == rhs.extendsClause &&
            lhs.annotations == rhs.annotations &&
            lhs.ruleAttributes == rhs.ruleAttributes
    }
}

public protocol Selector {
    
    func isEqualTo(other: Selector) -> Bool
}

extension Selector where Self: Equatable {
    
    public func isEqualTo(other: Selector) -> Bool {
        guard let selector = other as? Self else { return false }
        return self == selector
    }
}

public class AnySelector: Equatable {
    
    public let selector: Selector
    
    public init(selector: Selector) {
        self.selector = selector
    }
    
    public static func ==(lhs: AnySelector, rhs: AnySelector) -> Bool {
        return lhs.selector.isEqualTo(other: rhs.selector)
    }
}

public class ShiftExpression: Equatable {

    public let additiveExpression: AdditiveExpression

    public let shiftExpressionRHS: ShiftExpressionRHS?

    public init(additiveExpression: AdditiveExpression, shiftExpressionRHS: ShiftExpressionRHS?) {
        self.additiveExpression = additiveExpression
        self.shiftExpressionRHS = shiftExpressionRHS
    }
    
    public static func ==(lhs: ShiftExpression, rhs: ShiftExpression) -> Bool {
        return lhs.additiveExpression == rhs.additiveExpression &&
            lhs.shiftExpressionRHS == rhs.shiftExpressionRHS
    }
}

public class ShiftExpressionRHS: Equatable {

    public let `operator`: Token

    public let additiveExpression: AdditiveExpression

    public let shiftExpressionRHS: ShiftExpressionRHS?

    public init(operator: Token, additiveExpression: AdditiveExpression, shiftExpressionRHS: ShiftExpressionRHS?) {
        self.operator = `operator`
        self.additiveExpression = additiveExpression
        self.shiftExpressionRHS = shiftExpressionRHS
    }
    
    public static func ==(lhs: ShiftExpressionRHS, rhs: ShiftExpressionRHS) -> Bool {
        return lhs.operator == rhs.operator &&
            lhs.additiveExpression == rhs.additiveExpression &&
            lhs.shiftExpressionRHS == rhs.shiftExpressionRHS
    }
}

public class SimpleType: Type, Equatable {
    
    public let primitiveType: PrimitiveType

    public let bracketPairs: [BracketPair]
    
    public init(primitiveType: PrimitiveType, bracketPairs: [BracketPair]) {
        self.primitiveType = primitiveType
        self.bracketPairs = bracketPairs
    }
    
    public static func ==(lhs: SimpleType, rhs: SimpleType) -> Bool {
        return lhs.primitiveType == rhs.primitiveType &&
            lhs.bracketPairs == rhs.bracketPairs
    }
}

public class SingleRelationalRestriction: SingleRestriction, Equatable {
    
    public let relationalOperator: AnyRelationalOperator

    public let shiftExpression: ShiftExpression
    
    public init(relationalOperator: AnyRelationalOperator, shiftExpression: ShiftExpression) {
        self.relationalOperator = relationalOperator
        self.shiftExpression = shiftExpression
    }
    
    public static func ==(lhs: SingleRelationalRestriction, rhs: SingleRelationalRestriction) -> Bool {
        return lhs.relationalOperator == rhs.relationalOperator &&
            lhs.shiftExpression == rhs.shiftExpression
    }
}

public protocol SingleRestriction {
    
    func isEqualTo(other: SingleRestriction) -> Bool
}

extension SingleRestriction where Self: Equatable {
    
    public func isEqualTo(other: SingleRestriction) -> Bool {
        guard let singleRestriction = other as? Self else { return false }
        return self == singleRestriction
    }
}

public class AnySingleRestriction: Equatable {
    
    public let singleRestriction: SingleRestriction
    
    public init(singleRestriction: SingleRestriction) {
        self.singleRestriction = singleRestriction
    }
    
    public static func ==(lhs: AnySingleRestriction, rhs: AnySingleRestriction) -> Bool {
        return lhs.singleRestriction.isEqualTo(other: rhs.singleRestriction)
    }
}

public class SourcePattern: BindingPatternBody, Equatable {
    
    public let pattern: Pattern

    public let overClause: OverClause?

    public let sourcePatternFromPart: SourcePatternFromPart?
    
    public init(pattern: Pattern, overClause: OverClause?, sourcePatternFromPart: SourcePatternFromPart?) {
        self.pattern = pattern
        self.overClause = overClause
        self.sourcePatternFromPart = sourcePatternFromPart
    }
    
    public static func ==(lhs: SourcePattern, rhs: SourcePattern) -> Bool {
        return lhs.pattern == rhs.pattern &&
            lhs.overClause == rhs.overClause &&
            lhs.sourcePatternFromPart == rhs.sourcePatternFromPart
    }
}

public class SourcePatternFromPart: Equatable {

    public let fromKeyword: Token

    public let sourcePatternFromPartSuffix: AnySourcePatternFromPartSuffix
    
    public init(fromKeyword: Token, sourcePatternFromPartSuffix: AnySourcePatternFromPartSuffix) {
        self.fromKeyword = fromKeyword
        self.sourcePatternFromPartSuffix = sourcePatternFromPartSuffix
    }
    
    public static func ==(lhs: SourcePatternFromPart, rhs: SourcePatternFromPart) -> Bool {
        return lhs.fromKeyword == rhs.fromKeyword &&
            lhs.sourcePatternFromPartSuffix == rhs.sourcePatternFromPartSuffix
    }
}

public protocol SourcePatternFromPartSuffix {
    
    func isEqualTo(other: SourcePatternFromPartSuffix) -> Bool
}

extension SourcePatternFromPartSuffix where Self: Equatable {
    
    public func isEqualTo(other: SourcePatternFromPartSuffix) -> Bool {
        guard let sourcePatternFromPartSuffix = other as? Self else { return false }
        return self == sourcePatternFromPartSuffix
    }
}

public class AnySourcePatternFromPartSuffix: Equatable {
    
    public let sourcePatternFromPartSuffix: SourcePatternFromPartSuffix
    
    public init(sourcePatternFromPartSuffix: SourcePatternFromPartSuffix) {
        self.sourcePatternFromPartSuffix = sourcePatternFromPartSuffix
    }
    
    public static func ==(lhs: AnySourcePatternFromPartSuffix, rhs: AnySourcePatternFromPartSuffix) -> Bool {
        return lhs.sourcePatternFromPartSuffix.isEqualTo(other: rhs.sourcePatternFromPartSuffix)
    }
}

public protocol StringID {
    
    func isEqualTo(other: StringID) -> Bool
}

extension StringID where Self: Equatable {
    
    public func isEqualTo(other: StringID) -> Bool {
        guard let stringID = other as? Self else { return false }
        return self == stringID
    }
}

public class AnyStringID: Equatable {
    
    public let stringID: StringID
    
    public init(stringID: StringID) {
        self.stringID = stringID
    }
    
    public static func ==(lhs: AnyStringID, rhs: AnyStringID) -> Bool {
        return lhs.stringID.isEqualTo(other: rhs.stringID)
    }
}

public class Statement: RHSStatement, Equatable {
    
    public let tokens: [Token]
    
    public init(tokens: [Token]) {
        self.tokens = tokens
    }
    
    public static func ==(lhs: Statement, rhs: Statement) -> Bool {
        return lhs.tokens == rhs.tokens
    }
}

public class StringLiteral: Literal, StringID, Equatable {
    
    public let token: Token
    
    public init(token: Token) {
        self.token = token
    }
    
    public static func ==(lhs: StringLiteral, rhs: StringLiteral) -> Bool {
        return lhs.token == rhs.token
    }
}

public class StringLiteralRuleAttribute: RuleAttribute, Equatable {
    
    public let keyword: Token

    public let stringLiteral: StringLiteral
    
    public init(keyword: Token, stringLiteral: StringLiteral) {
        self.keyword = keyword
        self.stringLiteral = stringLiteral
    }
    
    public static func ==(lhs: StringLiteralRuleAttribute, rhs: StringLiteralRuleAttribute) -> Bool {
        return lhs.keyword == rhs.keyword &&
            lhs.stringLiteral == rhs.stringLiteral
    }
}

public class SuperSelector: Selector, Equatable {
    
    public let period: Token

    public let superKeyword: Token

    public let superSuffix: AnySuperSuffix
    
    public init(period: Token, superKeyword: Token, superSuffix: AnySuperSuffix) {
        self.period = period
        self.superKeyword = superKeyword
        self.superSuffix = superSuffix
    }
    
    public static func ==(lhs: SuperSelector, rhs: SuperSelector) -> Bool {
        return lhs.period == rhs.period &&
            lhs.superKeyword == rhs.superKeyword &&
            lhs.superSuffix == rhs.superSuffix
    }
}

public protocol SuperSuffix {
    
    func isEqualTo(other: SuperSuffix) -> Bool
}

extension SuperSuffix where Self: Equatable {
    
    public func isEqualTo(other: SuperSuffix) -> Bool {
        guard let superSuffix = other as? Self else { return false }
        return self == superSuffix
    }
}

public class AnySuperSuffix: Equatable {
    
    public let superSuffix: SuperSuffix
    
    public init(superSuffix: SuperSuffix) {
        self.superSuffix = superSuffix
    }
    
    public static func ==(lhs: AnySuperSuffix, rhs: AnySuperSuffix) -> Bool {
        return lhs.superSuffix.isEqualTo(other: rhs.superSuffix)
    }
}

public class ThenPart: Equatable {
    
    public let thenKeyword: Token

    public let rhsStatements: [AnyRHSStatement]

    public let endKeyword: Token
    
    public init(thenKeyword: Token, rhsStatements: [AnyRHSStatement], endKeyword: Token) {
        self.thenKeyword = thenKeyword
        self.rhsStatements = rhsStatements
        self.endKeyword = endKeyword
    }
    
    public static func ==(lhs: ThenPart, rhs: ThenPart) -> Bool {
        return lhs.thenKeyword == rhs.thenKeyword &&
            lhs.rhsStatements == rhs.rhsStatements &&
            lhs.endKeyword == rhs.endKeyword
    }
}

public class TimerRuleAttribute: RuleAttribute, Equatable {
    
    public let timerKeyword: Token

    public let leftParenthesis: Token

    public let tokens: Tokens

    public let rightParenthesis: Token
    
    public init(timerKeyword: Token, leftParenthesis: Token, tokens: Tokens, rightParenthesis: Token) {
        self.timerKeyword = timerKeyword
        self.leftParenthesis = leftParenthesis
        self.tokens = tokens
        self.rightParenthesis = rightParenthesis
    }
    
    public static func ==(lhs: TimerRuleAttribute, rhs: TimerRuleAttribute) -> Bool {
        return lhs.timerKeyword == rhs.timerKeyword &&
            lhs.leftParenthesis == rhs.leftParenthesis &&
            lhs.tokens == rhs.tokens &&
            lhs.rightParenthesis == rhs.rightParenthesis
    }
}

public class Tokens: AnnotationInnerBody, Equatable {
    
    public init() { }
    
    public static func ==(lhs: Tokens, rhs: Tokens) -> Bool {
        return true
    }
}

public protocol Type: TypeArgument, UnaryExpressionCastType {
    
    func isEqualTo(other: Type) -> Bool
}

extension Type where Self: Equatable {
    
    public func isEqualTo(other: Type) -> Bool {
        guard let type = other as? Self else { return false }
        return self == type
    }
}

public class AnyType: Equatable {
    
    public let type: Type
    
    public init(type: Type) {
        self.type = type
    }
    
    public static func ==(lhs: AnyType, rhs: AnyType) -> Bool {
        return lhs.type.isEqualTo(other: rhs.type)
    }
}

public protocol TypeArgument {
    
    func isEqualTo(other: TypeArgument) -> Bool
}

extension TypeArgument where Self: Equatable {
    
    public func isEqualTo(other: TypeArgument) -> Bool {
        guard let typeArgument = other as? Self else { return false }
        return self == typeArgument
    }
}

public class AnyTypeArgument: Equatable {
    
    public let typeArgument: TypeArgument
    
    public init(typeArgument: TypeArgument) {
        self.typeArgument = typeArgument
    }
    
    public static func ==(lhs: AnyTypeArgument, rhs: AnyTypeArgument) -> Bool {
        return lhs.typeArgument.isEqualTo(other: rhs.typeArgument)
    }
}

public class TypeArguments: Equatable {
    
    public let leftAngle: Token

    public let typeArguments: [AnyTypeArgument]

    public let rightAngle: Token
    
    public init(leftAngle: Token, typeArguments: [AnyTypeArgument], rightAngle: Token) {
        self.leftAngle = leftAngle
        self.typeArguments = typeArguments
        self.rightAngle = rightAngle
    }
    
    public static func ==(lhs: TypeArguments, rhs: TypeArguments) -> Bool {
        return lhs.leftAngle == rhs.leftAngle &&
            lhs.typeArguments == rhs.typeArguments &&
            lhs.rightAngle == rhs.rightAngle
    }
}

public class TypeDefinition: Definition, Equatable {
    
    public let declareKeyword: Token

    public let qualifiedName: QualifiedName

    public let typeOptions: TypeOptions

    public let fields: [Field]

    public let endKeyword: Token
    
    public init(declareKeyword: Token, qualifiedName: QualifiedName, typeOptions: TypeOptions, fields: [Field], endKeyword: Token) {
        self.declareKeyword = declareKeyword
        self.qualifiedName = qualifiedName
        self.typeOptions = typeOptions
        self.fields = fields
        self.endKeyword = endKeyword
    }
    
    public static func ==(lhs: TypeDefinition, rhs: TypeDefinition) -> Bool {
        return lhs.declareKeyword == rhs.declareKeyword &&
            lhs.qualifiedName == rhs.qualifiedName &&
            lhs.typeOptions == rhs.typeOptions &&
            lhs.fields == rhs.fields &&
            lhs.endKeyword == rhs.endKeyword
    }
}

public class TypeOptions: Equatable {
    
    public let typeOptionsExtension: TypeOptionsExtension?

    public let annotations: [Annotation]
    
    public init(typeOptionsExtension: TypeOptionsExtension?, annotations: [Annotation]) {
        self.typeOptionsExtension = typeOptionsExtension
        self.annotations = annotations
    }
    
    public static func ==(lhs: TypeOptions, rhs: TypeOptions) -> Bool {
        return lhs.typeOptionsExtension == rhs.typeOptionsExtension &&
            lhs.annotations == rhs.annotations
    }
}

public class TypeOptionsExtension: Equatable {
    
    public let extendsKeyword: Token

    public let qualifiedName: QualifiedName
    
    public init(extendsKeyword: Token, qualifiedName: QualifiedName) {
        self.extendsKeyword = extendsKeyword
        self.qualifiedName = qualifiedName
    }
    
    public static func ==(lhs: TypeOptionsExtension, rhs: TypeOptionsExtension) -> Bool {
        return lhs.extendsKeyword == rhs.extendsKeyword &&
            lhs.qualifiedName == rhs.qualifiedName
    }
}

public protocol UnaryExpression {
    
    func isEqualTo(other: UnaryExpression) -> Bool
}

extension UnaryExpression where Self: Equatable {
    
    public func isEqualTo(other: UnaryExpression) -> Bool {
        guard let unaryExpression = other as? Self else { return false }
        return self == unaryExpression
    }
}

public class AnyUnaryExpression: Equatable {
    
    public let unaryExpression: UnaryExpression
    
    public init(unaryExpression: UnaryExpression) {
        self.unaryExpression = unaryExpression
    }
    
    public static func ==(lhs: AnyUnaryExpression, rhs: AnyUnaryExpression) -> Bool {
        return lhs.unaryExpression.isEqualTo(other: rhs.unaryExpression)
    }
}

public class UnaryExpressionCast: UnaryExpression, Equatable {
    
    public let leftParenthesis: Token

    public let unaryExpressionCastType: AnyUnaryExpressionCastType

    public let rightParenthesis: Token

    public let unaryExpression: AnyUnaryExpression
    
    public init(leftParenthesis: Token, unaryExpressionCastType: AnyUnaryExpressionCastType, rightParenthesis: Token, unaryExpression: AnyUnaryExpression) {
        self.leftParenthesis = leftParenthesis
        self.unaryExpressionCastType = unaryExpressionCastType
        self.rightParenthesis = rightParenthesis
        self.unaryExpression = unaryExpression
    }
    
    public static func ==(lhs: UnaryExpressionCast, rhs: UnaryExpressionCast) -> Bool {
        return lhs.leftParenthesis == rhs.leftParenthesis &&
            lhs.unaryExpressionCastType == rhs.unaryExpressionCastType &&
            lhs.rightParenthesis == rhs.rightParenthesis &&
            lhs.unaryExpression == rhs.unaryExpression
    }
}

public protocol UnaryExpressionCastType {
    
    func isEqualTo(other: UnaryExpressionCastType) -> Bool
}

extension UnaryExpressionCastType where Self: Equatable {
    
    public func isEqualTo(other: UnaryExpressionCastType) -> Bool {
        guard let unaryExpressionCastType = other as? Self else { return false }
        return self == unaryExpressionCastType
    }
}

public class AnyUnaryExpressionCastType: Equatable {
    
    public let unaryExpressionCastType: UnaryExpressionCastType
    
    public init(unaryExpressionCastType: UnaryExpressionCastType) {
        self.unaryExpressionCastType = unaryExpressionCastType
    }
    
    public static func ==(lhs: AnyUnaryExpressionCastType, rhs: AnyUnaryExpressionCastType) -> Bool {
        return lhs.unaryExpressionCastType.isEqualTo(other: rhs.unaryExpressionCastType)
    }
}

public class UnaryExpressionIncrementDecrement: UnaryExpression, Equatable {
    
    public let `operator`: Token

    public let primary: AnyPrimary
    
    public init(operator: Token, primary: AnyPrimary) {
        self.operator = `operator`
        self.primary = primary
    }
    
    public static func ==(lhs: UnaryExpressionIncrementDecrement, rhs: UnaryExpressionIncrementDecrement) -> Bool {
        return lhs.operator == rhs.operator &&
            lhs.primary == rhs.primary
    }
}

public class UnaryExpressionNegation: UnaryExpression, Equatable {
    
    public let `operator`: Token

    public let unaryExpression: AnyUnaryExpression
    
    public init(operator: Token, unaryExpression: AnyUnaryExpression) {
        self.operator = `operator`
        self.unaryExpression = unaryExpression
    }
    
    public static func ==(lhs: UnaryExpressionNegation, rhs: UnaryExpressionNegation) -> Bool {
        return lhs.operator == rhs.operator &&
            lhs.unaryExpression == rhs.unaryExpression
    }
}

public class UnaryExpressionPlusMinus: UnaryExpression, Equatable {
    
    public let `operator`: Token

    public let unaryExpression: AnyUnaryExpression
    
    public init(operator: Token, unaryExpression: AnyUnaryExpression) {
        self.operator = `operator`
        self.unaryExpression = unaryExpression
    }
    
    public static func ==(lhs: UnaryExpressionPlusMinus, rhs: UnaryExpressionPlusMinus) -> Bool {
        return lhs.operator == rhs.operator &&
            lhs.unaryExpression == rhs.unaryExpression
    }
}

public class UnaryExpressionPrimary: UnaryExpression, Equatable {
    
    public let unaryExpressionPrimaryAssignment: UnaryExpressionPrimaryAssignment?

    public let primary: AnyPrimary

    public let incrementOrDecrementOperator: Token?
    
    public init(unaryExpressionPrimaryAssignment: UnaryExpressionPrimaryAssignment?, primary: AnyPrimary, incrementOrDecrementOperator: Token?) {
        self.unaryExpressionPrimaryAssignment = unaryExpressionPrimaryAssignment
        self.primary = primary
        self.incrementOrDecrementOperator = incrementOrDecrementOperator
    }
    
    public static func ==(lhs: UnaryExpressionPrimary, rhs: UnaryExpressionPrimary) -> Bool {
        return lhs.unaryExpressionPrimaryAssignment == rhs.unaryExpressionPrimaryAssignment &&
            lhs.primary == rhs.primary &&
            lhs.incrementOrDecrementOperator == rhs.incrementOrDecrementOperator
    }
}

public class UnaryExpressionPrimaryAssignment: Equatable {
    
    public let identifier: Identifier

    public let `operator`: Token
    
    public init(identifier: Identifier, operator: Token) {
        self.identifier = identifier
        self.operator = `operator`
    }
    
    public static func ==(lhs: UnaryExpressionPrimaryAssignment, rhs: UnaryExpressionPrimaryAssignment) -> Bool {
        return lhs.identifier == rhs.identifier &&
            lhs.operator == rhs.operator
    }
}

public protocol Value {
    
    func isEqualTo(other: Value) -> Bool
}

extension Value where Self: Equatable {
    
    public func isEqualTo(other: Value) -> Bool {
        guard let value = other as? Self else { return false }
        return self == value
    }
}

public class AnyValue: Equatable {
    
    public let value: Value
    
    public init(value: Value) {
        self.value = value
    }
    
    public static func ==(lhs: AnyValue, rhs: AnyValue) -> Bool {
        return lhs.value.isEqualTo(other: rhs.value)
    }
}

public class ValueArray: Value, Equatable {
    
    public let leftBrace: Token

    public let values: [AnyValue]

    public let rightBrace: Token
    
    public init(leftBrace: Token, values: [AnyValue], rightBrace: Token) {
        self.leftBrace = leftBrace
        self.values = values
        self.rightBrace = rightBrace
    }
    
    public static func ==(lhs: ValueArray, rhs: ValueArray) -> Bool {
        return lhs.leftBrace == rhs.leftBrace &&
            lhs.values == rhs.values &&
            lhs.rightBrace == rhs.rightBrace
    }
}

public protocol VariableInitializer {
    
    func isEqualTo(other: VariableInitializer) -> Bool
}

extension VariableInitializer where Self: Equatable {
    
    public func isEqualTo(other: VariableInitializer) -> Bool {
        guard let variableInitializer = other as? Self else { return false }
        return self == variableInitializer
    }
}

public class AnyVariableInitializer: Equatable {
    
    public let variableInitializer: VariableInitializer
    
    public init(variableInitializer: VariableInitializer) {
        self.variableInitializer = variableInitializer
    }
    
    public static func ==(lhs: AnyVariableInitializer, rhs: AnyVariableInitializer) -> Bool {
        return lhs.variableInitializer.isEqualTo(other: rhs.variableInitializer)
    }
}

public class WhenPart: Equatable {
    
    public let whenKeyword: Token

    public let colon: Token?

    public let conditionalOrs: [ConditionalOr]
    
    public init(whenKeyword: Token, colon: Token?, conditionalOrs: [ConditionalOr]) {
        self.whenKeyword = whenKeyword
        self.colon = colon
        self.conditionalOrs = conditionalOrs
    }
    
    public static func ==(lhs: WhenPart, rhs: WhenPart) -> Bool {
        return lhs.whenKeyword == rhs.whenKeyword &&
            lhs.colon == rhs.colon &&
            lhs.conditionalOrs == rhs.conditionalOrs
    }
}
