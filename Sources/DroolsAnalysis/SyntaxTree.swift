
public class SyntaxTree {

    public let compilationUnit: CompilationUnit

    public init(compilationUnit: CompilationUnit) {
        self.compilationUnit = compilationUnit
    }
}

public class AccumulateAction {

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
}

public class AccumulateClause: SourcePatternFromPartSuffix {

    public let accumulateKeyword: Token

    public let leftParenthesis: Token

    public let conditionalAnd: ConditionalAnd

    public let comma: Token?

    public let accumulateClauseBody: AccumulateClauseBody

    public let rightParenthesis: Token

    public init(accumulateKeyword: Token, leftParenthesis: Token, conditionalAnd: ConditionalAnd, comma: Token?, accumulateClauseBody: AccumulateClauseBody, rightParenthesis: Token) {
        self.accumulateKeyword = accumulateKeyword
        self.leftParenthesis = leftParenthesis
        self.conditionalAnd = conditionalAnd
        self.comma = comma
        self.accumulateClauseBody = accumulateClauseBody
        self.rightParenthesis = rightParenthesis
    }
}

public protocol AccumulateClauseBody { }

public class AccumulateFunction: AccumulateClauseBody {

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
}

public class AccumulateInit {

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
}

public class AccumulateResult {

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
}

public class AccumulateReverse {

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
}

public class AccumulateSteps: AccumulateClauseBody {

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
}

public class Accumulations {

    public let accumulationsMappings: [AccumulationsMapping]

    public init(accumulationsMappings: [AccumulationsMapping]) {
        self.accumulationsMappings = accumulationsMappings
    }
}

public class AccumulationsMapping {

    public let identifier: Identifier

    public let colon: Token

    public let accumulateFunction: AccumulateFunction

    public init(identifier: Identifier, colon: Token, accumulateFunction: AccumulateFunction) {
        self.identifier = identifier
        self.colon = colon
        self.accumulateFunction = accumulateFunction
    }
}

public class AdditiveExpression {

    public let unaryExpression: UnaryExpression

    public let additiveExpressionRHS: AdditiveExpressionRHS?

    public init(unaryExpression: UnaryExpression, additiveExpressionRHS: AdditiveExpressionRHS?) {
        self.unaryExpression = unaryExpression
        self.additiveExpressionRHS = additiveExpressionRHS
    }
}

public class AdditiveExpressionRHS {

    public let `operator`: Token

    public let unaryExpression: UnaryExpression

    public let additiveExpressionRHS: AdditiveExpressionRHS?

    public init(operator: Token, unaryExpression: UnaryExpression, additiveExpressionRHS: AdditiveExpressionRHS?) {
        self.operator = `operator`
        self.unaryExpression = unaryExpression
        self.additiveExpressionRHS = additiveExpressionRHS
    }
}

public class Annotation {

    public let atSign: Token

    public let identifier: Identifier

    public let annotationBody: AnnotationBody?

    public init(atSign: Token, identifier: Identifier, annotationBody: AnnotationBody?) {
        self.atSign = atSign
        self.identifier = identifier
        self.annotationBody = annotationBody
    }
}

public class AnnotationBody {

    public let leftParenthesis: Token

    public let annotationInnerBody: AnnotationInnerBody

    public let rightParenthesis: Token

    public init(leftParenthesis: Token, annotationInnerBody: AnnotationInnerBody, rightParenthesis: Token) {
        self.leftParenthesis = leftParenthesis
        self.annotationInnerBody = annotationInnerBody
        self.rightParenthesis = rightParenthesis
    }
}

public protocol AnnotationInnerBody { }

public class AnnotationInnerBodyAssignment {

    public let identifier: Identifier

    public let assignment: Token

    public let value: Value

    public init(identifier: Identifier, assignment: Token, value: Value) {
        self.identifier = identifier
        self.assignment = assignment
        self.value = value
    }
}

public class AnnotationInnerBodyAssignments: AnnotationInnerBody {

    public let annotationInnerBodyAssignments: [AnnotationInnerBodyAssignment]

    public init(annotationInnerBodyAssignments: [AnnotationInnerBodyAssignment]) {
        self.annotationInnerBodyAssignments = annotationInnerBodyAssignments
    }
}

public class Arguments: CreatorBody, IdentifierSuffix, SuperSuffix {

    public let leftParenthesis: Token

    public let expressions: [Expression]

    public let rightParenthesis: Token

    public init(leftParenthesis: Token, expressions: [Expression], rightParenthesis: Token) {
        self.leftParenthesis = leftParenthesis
        self.expressions = expressions
        self.rightParenthesis = rightParenthesis
    }
}

public class ArrayCreatorRest: CreatorBody {

    public let arrayCreatorRestBody: ArrayCreatorRestBody

    public init(arrayCreatorRestBody: ArrayCreatorRestBody) {
        self.arrayCreatorRestBody = arrayCreatorRestBody
    }
}

public protocol ArrayCreatorRestBody { }

public class ArrayCreatorRestExpressionBody: ArrayCreatorRestBody {

    public let bracketedExpressions: [BracketedExpression]

    public let bracketPairs: [BracketPair]

    public init(bracketedExpressions: [BracketedExpression], bracketPairs: [BracketPair]) {
        self.bracketedExpressions = bracketedExpressions
        self.bracketPairs = bracketPairs
    }
}

public class ArrayCreatorRestInitializerBody: ArrayCreatorRestBody {

    public let bracketPairs: [BracketPair]

    public let arrayInitializer: ArrayInitializer

    public init(bracketPairs: [BracketPair], arrayInitializer: ArrayInitializer) {
        self.bracketPairs = bracketPairs
        self.arrayInitializer = arrayInitializer
    }
}

public class ArrayInitializer: VariableInitializer {

    public let leftBrace: Token

    public let arrayVariableInitializers: ArrayVariableInitializers

    public let rightBrace: Token

    public init(leftBrace: Token, arrayVariableInitializers: ArrayVariableInitializers, rightBrace: Token) {
        self.leftBrace = leftBrace
        self.arrayVariableInitializers = arrayVariableInitializers
        self.rightBrace = rightBrace
    }
}

public class ArrayVariableInitializers {

    public let variableInitializers: [VariableInitializer]

    public let comma: Token?

    public init(variableInitializers: [VariableInitializer], comma: Token?) {
        self.variableInitializers = variableInitializers
        self.comma = comma
    }
}

public class AssignmentOperator {

    public let `operator`: Token

    public init(operator: Token) {
        self.operator = `operator`
    }
}

public class BindingPattern: ConditionalElementBody, ConditionalElementExistsBody, ConditionalElementNotBody {

    public let bindingPatternIdentifier: BindingPatternIdentifier?

    public let bindingPatternBody: BindingPatternBody

    public init(bindingPatternIdentifier: BindingPatternIdentifier?, bindingPatternBody: BindingPatternBody) {
        self.bindingPatternIdentifier = bindingPatternIdentifier
        self.bindingPatternBody = bindingPatternBody
    }
}

public protocol BindingPatternBody { }

public class BindingPatternIdentifier {

    public let identifier: Identifier

    public let colon: Token?

    public init(identifier: Identifier, colon: Token?) {
        self.identifier = identifier
        self.colon = colon
    }
}

public class BindingPatternMultipleSourcePattern: BindingPatternBody {

    public let leftParenthesis: Token

    public let sourcePatterns: [SourcePattern]

    public let rightParenthesis: Token

    public init(leftParenthesis: Token, sourcePatterns: [SourcePattern], rightParenthesis: Token) {
        self.leftParenthesis = leftParenthesis
        self.sourcePatterns = sourcePatterns
        self.rightParenthesis = rightParenthesis
    }
}

public class Block {

    public let leftBrace: Token

    public let statements: [Statement]

    public let rightBrace: Token

    public init(leftBrace: Token, statements: [Statement], rightBrace: Token) {
        self.leftBrace = leftBrace
        self.statements = statements
        self.rightBrace = rightBrace
    }
}

public class BooleanLiteral: Literal {

    public let token: Token

    public init(token: Token) {
        self.token = token
    }
}

public class BooleanLiteralRuleAttribute: RuleAttribute {

    public let keyword: Token

    public let booleanLiteral: BooleanLiteral?

    public init(keyword: Token, booleanLiteral: BooleanLiteral?) {
        self.keyword = keyword
        self.booleanLiteral = booleanLiteral
    }
}

public class BracketedExpression: Selector {

    public let leftBracket: Token

    public let expression: Expression

    public let rightBracket: Token

    public init(leftBracket: Token, expression: Expression, rightBracket: Token) {
        self.leftBracket = leftBracket
        self.expression = expression
        self.rightBracket = rightBracket
    }
}

public class BracketedExpressions: IdentifierSuffix {

    public let bracketedExpressions: [BracketedExpression]

    public init(bracketedExpressions: [BracketedExpression]) {
        self.bracketedExpressions = bracketedExpressions
    }
}

public class BracketPair {

    public let leftBracket: Token

    public let rightBracket: Token

    public init(leftBracket: Token, rightBracket: Token) {
        self.leftBracket = leftBracket
        self.rightBracket = rightBracket
    }
}

public class CalendarsRuleAttribute: RuleAttribute {

    public let calendarsKeyword: Token

    public let stringLiterals: [StringLiteral]

    public init(calendarsKeyword: Token, stringLiterals: [StringLiteral]) {
        self.calendarsKeyword = calendarsKeyword
        self.stringLiterals = stringLiterals
    }
}

public class CollectBindingClause: SourcePatternFromPartSuffix {

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
}

public class CompilationUnit {

    public let packageDeclaration: PackageDeclaration?

    public let fullDefinitions: [FullDefinition]

    public init(packageDeclaration: PackageDeclaration?, fullDefinitions: [FullDefinition]) {
        self.packageDeclaration = packageDeclaration
        self.fullDefinitions = fullDefinitions
    }
}

public class ComplexCreatedName: CreatedName {

    public let complexCreatedNameParts: [ComplexCreatedNamePart]

    public init(complexCreatedNameParts: [ComplexCreatedNamePart]) {
        self.complexCreatedNameParts = complexCreatedNameParts
    }
}

public class ComplexCreatedNamePart {

    public let identifier: Identifier

    public let typeArguments: TypeArguments?

    public init(identifier: Identifier, typeArguments: TypeArguments?) {
        self.identifier = identifier
        self.typeArguments = typeArguments
    }
}

public class ComplexType: Type {

    public let complexTypeSegments: [ComplexTypeSegment]

    public let bracketPairs: [BracketPair]

    public init(complexTypeSegments: [ComplexTypeSegment], bracketPairs: [BracketPair]) {
        self.complexTypeSegments = complexTypeSegments
        self.bracketPairs = bracketPairs
    }
}

public class ComplexTypeSegment {

    public let identifier: Identifier

    public let typeArguments: TypeArguments?

    public init(identifier: Identifier, typeArguments: TypeArguments?) {
        self.identifier = identifier
        self.typeArguments = typeArguments
    }
}

public class ConditionalAnd {

    public let conditionalElements: [ConditionalElement]

    public init(conditionalElements: [ConditionalElement]) {
        self.conditionalElements = conditionalElements
    }
}

public class ConditionalElement {

    public let conditionalElementBody: ConditionalElementBody

    public let semicolon: Token?

    public init(conditionalElementBody: ConditionalElementBody, semicolon: Token?) {
        self.conditionalElementBody = conditionalElementBody
        self.semicolon = semicolon
    }
}

public class ConditionalElementAccumulate: ConditionalElementBody {

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
}

public protocol ConditionalElementBody { }

public class ConditionalElementEval: ConditionalElementBody {

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
}

public class ConditionalElementExists: ConditionalElementBody {

    public let existsKeyword: Token

    public let conditionalElementExistsBody: ConditionalElementExistsBody

    public init(existsKeyword: Token, conditionalElementExistsBody: ConditionalElementExistsBody) {
        self.existsKeyword = existsKeyword
        self.conditionalElementExistsBody = conditionalElementExistsBody
    }
}

public protocol ConditionalElementExistsBody { }

public class ConditionalElementForall: ConditionalElementBody {

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
}

public class ConditionalElementNot: ConditionalElementBody {

    public let notKeyword: Token

    public let conditionalElementNotBody: ConditionalElementNotBody

    public init(notKeyword: Token, conditionalElementNotBody: ConditionalElementNotBody) {
        self.notKeyword = notKeyword
        self.conditionalElementNotBody = conditionalElementNotBody
    }
}

public protocol ConditionalElementNotBody { }

public class ConditionalExpression: Value {

    public let conditionalOrExpression: ConditionalOrExpression

    public let conditionalExpressionBody: ConditionalExpressionBody?

    public init(conditionalOrExpression: ConditionalOrExpression, conditionalExpressionBody: ConditionalExpressionBody?) {
        self.conditionalOrExpression = conditionalOrExpression
        self.conditionalExpressionBody = conditionalExpressionBody
    }
}

public class ConditionalExpressionBody {

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
}

public class ConditionalExpressionRuleAttribute: RuleAttribute {

    public let keyword: Token

    public let conditionalExpression: ConditionalExpression

    public init(keyword: Token, conditionalExpression: ConditionalExpression) {
        self.keyword = keyword
        self.conditionalExpression = conditionalExpression
    }
}

public class ConditionalOr {

    public let conditionalAnds: [ConditionalAnd]

    public init(conditionalAnds: [ConditionalAnd]) {
        self.conditionalAnds = conditionalAnds
    }
}

public class ConditionalOrExpression: SourcePatternFromPartSuffix {

    public let instanceOfExpression: InstanceOfExpression

    public let conditionalOrExpressionRHS: ConditionalOrExpressionRHS?

    public init(instanceOfExpression: InstanceOfExpression, conditionalOrExpressionRHS: ConditionalOrExpressionRHS?) {
        self.instanceOfExpression = instanceOfExpression
        self.conditionalOrExpressionRHS = conditionalOrExpressionRHS
    }
}

public class ConditionalOrExpressionRHS {

    public let `operator`: Token

    public let instanceOfExpression: InstanceOfExpression

    public let conditionalOrExpressionRHS: ConditionalOrExpressionRHS?

    public init(operator: Token, instanceOfExpression: InstanceOfExpression, conditionalOrExpressionRHS: ConditionalOrExpressionRHS?) {
        self.operator = `operator`
        self.instanceOfExpression = instanceOfExpression
        self.conditionalOrExpressionRHS = conditionalOrExpressionRHS
    }
}

public class Constraints {

    public let constraintsLeadingExpressions: ConstraintsLeadingExpressions?

    public let constraintsTrailingExpressions: ConstraintsTrailingExpressions?

    public init(constraintsLeadingExpressions: ConstraintsLeadingExpressions?, constraintsTrailingExpressions: ConstraintsTrailingExpressions?) {
        self.constraintsLeadingExpressions = constraintsLeadingExpressions
        self.constraintsTrailingExpressions = constraintsTrailingExpressions
    }
}

public class ConstraintsLeadingExpressions {

    public let conditionalOrExpressions: [ConditionalOrExpression]

    public let semicolon: Token

    public init(conditionalOrExpressions: [ConditionalOrExpression], semicolon: Token) {
        self.conditionalOrExpressions = conditionalOrExpressions
        self.semicolon = semicolon
    }
}

public class ConstraintsTrailingExpressions {

    public let conditionalOrExpressions: [ConditionalOrExpression]

    public init(conditionalOrExpressions: [ConditionalOrExpression]) {
        self.conditionalOrExpressions = conditionalOrExpressions
    }
}

public protocol CreatedName { }

public class Creator {

    public let nonWildcardTypeArguments: NonWildcardTypeArguments?

    public let createdName: CreatedName

    public let creatorBody: CreatorBody

    public init(nonWildcardTypeArguments: NonWildcardTypeArguments?, createdName: CreatedName, creatorBody: CreatorBody) {
        self.nonWildcardTypeArguments = nonWildcardTypeArguments
        self.createdName = createdName
        self.creatorBody = creatorBody
    }
}

public protocol CreatorBody { }

public protocol Definition { }

public class EntryPointClause: SourcePatternFromPartSuffix {

    public let entryPointKeyword: Token

    public let stringID: StringID

    public init(entryPointKeyword: Token, stringID: StringID) {
        self.entryPointKeyword = entryPointKeyword
        self.stringID = stringID
    }
}

public class ExplicitGenericInvocation {

    public let nonWildcardTypeArguments: NonWildcardTypeArguments

    public let arguments: Arguments

    public init(nonWildcardTypeArguments: NonWildcardTypeArguments, arguments: Arguments) {
        self.nonWildcardTypeArguments = nonWildcardTypeArguments
        self.arguments = arguments
    }
}

public class ExplicitGenericInvocationArgumentsSuffix: ExplicitGenericInvocationSuffix {

    public let identifier: Identifier

    public let arguments: Arguments

    public init(identifier: Identifier, arguments: Arguments) {
        self.identifier = identifier
        self.arguments = arguments
    }
}

public protocol ExplicitGenericInvocationSuffix: PrimaryNonWildcardTypeArgumentsSuffix { }

public class ExplicitGenericInvocationSuperSuffix: ExplicitGenericInvocationSuffix {

    public let superKeyword: Token

    public let superSuffix: SuperSuffix

    public init(superKeyword: Token, superSuffix: SuperSuffix) {
        self.superKeyword = superKeyword
        self.superSuffix = superSuffix
    }
}

public class Expression: VariableInitializer {

    public let conditionalExpression: ConditionalExpression

    public let expressionRHS: ExpressionRHS?

    public init(conditionalExpression: ConditionalExpression, expressionRHS: ExpressionRHS?) {
        self.conditionalExpression = conditionalExpression
        self.expressionRHS = expressionRHS
    }
}

public class ExpressionRHS {

    public let assignmentOperator: AssignmentOperator

    public let expression: Expression

    public init(assignmentOperator: AssignmentOperator, expression: Expression) {
        self.assignmentOperator = assignmentOperator
        self.expression = expression
    }
}

public class ExtendsClause {

    public let extendsKeyword: Token

    public let stringID: StringID

    public init(extendsKeyword: Token, stringID: StringID) {
        self.extendsKeyword = extendsKeyword
        self.stringID = stringID
    }
}

public class Field {

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
}

public class FieldAssignment {

    public let assignment: Token

    public let conditionalExpression: ConditionalExpression

    public init(assignment: Token, conditionalExpression: ConditionalExpression) {
        self.assignment = assignment
        self.conditionalExpression = conditionalExpression
    }
}

public class FromAccumulateClause {
    
    public let fromKeyword: Token

    public let accumulateClause: AccumulateClause
    
    public init(fromKeyword: Token, accumulateClause: AccumulateClause) {
        self.fromKeyword = fromKeyword
        self.accumulateClause = accumulateClause
    }
}

public class FromClause {
    
    public let fromKeyword: Token

    public let conditionalOrExpression: ConditionalOrExpression
    
    public init(fromKeyword: Token, conditionalOrExpression: ConditionalOrExpression) {
        self.fromKeyword = fromKeyword
        self.conditionalOrExpression = conditionalOrExpression
    }
}

public class FromCollectClause {
    
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
}

public class FullDefinition {

    public let definition: Definition

    public let semicolon: Token?

    public init(definition: Definition, semicolon: Token?) {
        self.definition = definition
        self.semicolon = semicolon
    }
}

public class FunctionDefinition: Definition {

    public let functionKeyword: Token

    public let type: Type?

    public let identifier: Identifier

    public let parameters: Parameters

    public let block: Block

    public init(functionKeyword: Token, type: Type?, identifier: Identifier, parameters: Parameters, block: Block) {
        self.functionKeyword = functionKeyword
        self.type = type
        self.identifier = identifier
        self.parameters = parameters
        self.block = block
    }
}

public class GlobalDefinition: Definition {

    public let globalKeyword: Token

    public let type: Type

    public let identifier: Identifier

    public init(globalKeyword: Token, type: Type, identifier: Identifier) {
        self.globalKeyword = globalKeyword
        self.type = type
        self.identifier = identifier
    }
}

public class Identifier: StringID {

    public let token: Token

    public init(token: Token) {
        self.token = token
    }
}

extension Identifier: Equatable {

    public static func ==(lhs: Identifier, rhs: Identifier) -> Bool {
        return lhs.token == rhs.token
    }
}

public class IdentifierSelector: Selector {

    public let period: Token

    public let identifier: Identifier

    public let arguments: Arguments?

    public init(period: Token, identifier: Identifier, arguments: Arguments?) {
        self.period = period
        self.identifier = identifier
        self.arguments = arguments
    }
}

public protocol IdentifierSuffix { }

public class IdentifierSuffixClass: IdentifierSuffix {

    public let bracketPairs: [BracketPair]

    public let period: Token

    public let classKeyword: Token

    public init(bracketPairs: [BracketPair], period: Token, classKeyword: Token) {
        self.bracketPairs = bracketPairs
        self.period = period
        self.classKeyword = classKeyword
    }
}

public class IdentifierSuperSuffix: SuperSuffix {

    public let period: Token

    public let identifier: Identifier

    public let arguments: Arguments?

    public init(period: Token, identifier: Identifier, arguments: Arguments?) {
        self.period = period
        self.identifier = identifier
        self.arguments = arguments
    }
}

public class ImportDefinition: Definition {

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
}

public class ImportDefinitionSuffix {

    public let period: Token

    public let asterisk: Token

    public init(period: Token, asterisk: Token) {
        self.period = period
        self.asterisk = asterisk
    }
}

public class InExpression {

    public let relationalExpression: RelationalExpression

    public let notKeyword: Token?

    public let inKeyword: Token

    public let leftParenthesis: Token

    public let expressions: [Expression]

    public let rightParenthesis: Token

    public init(relationalExpression: RelationalExpression, notKeyword: Token?, inKeyword: Token, leftParenthesis: Token, expressions: [Expression], rightParenthesis: Token) {
        self.relationalExpression = relationalExpression
        self.notKeyword = notKeyword
        self.inKeyword = inKeyword
        self.leftParenthesis = leftParenthesis
        self.expressions = expressions
        self.rightParenthesis = rightParenthesis
    }
}

public class InheritanceTypeArgument: TypeArgument {

    public let questionMark: Token

    public let inheritanceTypeArgumentSuffix: InheritanceTypeArgumentSuffix?

    public init(questionMark: Token, inheritanceTypeArgumentSuffix: InheritanceTypeArgumentSuffix?) {
        self.questionMark = questionMark
        self.inheritanceTypeArgumentSuffix = inheritanceTypeArgumentSuffix
    }
}

public class InheritanceTypeArgumentSuffix {

    public let extendsOrSuperKeyword: Token

    public let type: Type

    public init(extendsOrSuperKeyword: Token, type: Type) {
        self.extendsOrSuperKeyword = extendsOrSuperKeyword
        self.type = type
    }
}

public class InlineListExpression: Primary {

    public let leftBracket: Token

    public let expressions: [Expression]

    public let rightBracket: Token

    public init(leftBracket: Token, expressions: [Expression], rightBracket: Token) {
        self.leftBracket = leftBracket
        self.expressions = expressions
        self.rightBracket = rightBracket
    }
}

public class InlineMapExpression: Primary {

    public let leftBracket: Token

    public let mappings: [Mapping]

    public let rightBracket: Token

    public init(leftBracket: Token, mappings: [Mapping], rightBracket: Token) {
        self.leftBracket = leftBracket
        self.mappings = mappings
        self.rightBracket = rightBracket
    }
}

public class InnerCreator {

    public let identifier: Identifier

    public let arguments: Arguments

    public init(identifier: Identifier, arguments: Arguments) {
        self.identifier = identifier
        self.arguments = arguments
    }
}

public class InstanceOfExpression {

    public let inExpression: InExpression

    public let instanceOfSuffix: InstanceOfSuffix?

    public init(inExpression: InExpression, instanceOfSuffix: InstanceOfSuffix?) {
        self.inExpression = inExpression
        self.instanceOfSuffix = instanceOfSuffix
    }
}

public class InstanceOfSuffix {

    public let instanceOfKeyword: Token

    public let type: Type

    public init(instanceOfKeyword: Token, type: Type) {
        self.instanceOfKeyword = instanceOfKeyword
        self.type = type
    }
}

public class IntLiteral: Literal {

    public let token: Token

    public init(token: Token) {
        self.token = token
    }
}

public protocol Literal: Primary { }

public class Mapping {

    public let leftExpression: Expression

    public let colon: Token

    public let rightExpression: Expression

    public init(leftExpression: Expression, colon: Token, rightExpression: Expression) {
        self.leftExpression = leftExpression
        self.colon = colon
        self.rightExpression = rightExpression
    }
}

public class ModifyStatement: RHSStatement {

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
}

public class NewSelector: Selector {

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
}

public class NonWildcardTypeArguments {

    public let leftAngle: Token

    public let types: [Type]

    public let rightAngle: Token

    public init(leftAngle: Token, types: [Type], rightAngle: Token) {
        self.leftAngle = leftAngle
        self.types = types
        self.rightAngle = rightAngle
    }
}

public class OrRestriction {

    public let singleRestriction: SingleRestriction

    public let orRestrictionRHS: OrRestrictionRHS?

    public init(singleRestriction: SingleRestriction, orRestrictionRHS: OrRestrictionRHS?) {
        self.singleRestriction = singleRestriction
        self.orRestrictionRHS = orRestrictionRHS
    }
}

public class OrRestrictionRHS {

    public let `operator`: Token

    public let singleRestriction: SingleRestriction

    public let orRestrictionRHS: OrRestrictionRHS?

    public init(operator: Token, singleRestriction: SingleRestriction, orRestrictionRHS: OrRestrictionRHS?) {
        self.operator = `operator`
        self.singleRestriction = singleRestriction
        self.orRestrictionRHS = orRestrictionRHS
    }
}

public class OverClause {

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
}

public class PackageDeclaration {

    public let packageKeyword: Token

    public let qualifiedName: QualifiedName

    public let semicolon: Token?

    public init(packageKeyword: Token, qualifiedName: QualifiedName, semicolon: Token?) {
        self.packageKeyword = packageKeyword
        self.qualifiedName = qualifiedName
        self.semicolon = semicolon
    }
}

public class Parameter {

    public let type: Type

    public let identifier: Identifier

    public let bracketPairs: [BracketPair]

    public init(type: Type, identifier: Identifier, bracketPairs: [BracketPair]) {
        self.type = type
        self.identifier = identifier
        self.bracketPairs = bracketPairs
    }
}

public class Parameters: QueryOptionsPrefix {

    public let leftParenthesis: Token

    public let parameters: [Parameter]

    public let rightParenthesis: Token

    public init(leftParenthesis: Token, parameters: [Parameter], rightParenthesis: Token) {
        self.leftParenthesis = leftParenthesis
        self.parameters = parameters
        self.rightParenthesis = rightParenthesis
    }
}

public class ParenthesizedConditionalOr: ConditionalElementBody, ConditionalElementExistsBody, ConditionalElementNotBody {

    public let leftParenthesis: Token

    public let conditionalOr: ConditionalOr

    public let rightParenthesis: Token

    public init(leftParenthesis: Token, conditionalOr: ConditionalOr, rightParenthesis: Token) {
        self.leftParenthesis = leftParenthesis
        self.conditionalOr = conditionalOr
        self.rightParenthesis = rightParenthesis
    }
}

public class ParenthesizedOrRestriction: SingleRestriction {

    public let leftParenthesis: Token

    public let orRestriction: OrRestriction

    public let rightParenthesis: Token

    public init(leftParenthesis: Token, orRestriction: OrRestriction, rightParenthesis: Token) {
        self.leftParenthesis = leftParenthesis
        self.orRestriction = orRestriction
        self.rightParenthesis = rightParenthesis
    }
}

public class ParenthesizedExpression: Primary {
    
    public let leftParenthesis: Token
    
    public let expression: Expression
    
    public let rightParenthesis: Token
    
    public init(leftParenthesis: Token, expression: Expression, rightParenthesis: Token) {
        self.leftParenthesis = leftParenthesis
        self.expression = expression
        self.rightParenthesis = rightParenthesis
    }
}

public class Pattern { }

public class Placeholders: QueryOptionsPrefix {

    public let leftParenthesis: Token

    public let identifiers: [Identifier]

    public let rightParenthesis: Token

    public init(leftParenthesis: Token, identifiers: [Identifier], rightParenthesis: Token) {
        self.leftParenthesis = leftParenthesis
        self.identifiers = identifiers
        self.rightParenthesis = rightParenthesis
    }
}

public protocol Primary { }

public class PrimaryIdentifier: Primary {
        
    public let identifiers: [Identifier]
    
    public let identifierSuffix: IdentifierSuffix?
    
    internal init(identifiers: [Identifier], identifierSuffix: IdentifierSuffix?) {
        self.identifiers = identifiers
        self.identifierSuffix = identifierSuffix
    }
}

public class PrimaryNewCreator: Primary {
    
    public let newKeyword: Token
    
    public let creator: Creator
    
    public init(newKeyword: Token, creator: Creator) {
        self.newKeyword = newKeyword
        self.creator = creator
    }
}

public class PrimaryNonWildcardTypeArguments: Primary {
        
    public let nonWildcardTypeArguments: NonWildcardTypeArguments
    
    public let primaryNonWildcardTypeArgumentsSuffix: PrimaryNonWildcardTypeArgumentsSuffix
    
    public init(nonWildcardTypeArguments: NonWildcardTypeArguments, primaryNonWildcardTypeArgumentsSuffix: PrimaryNonWildcardTypeArgumentsSuffix) {
        self.nonWildcardTypeArguments = nonWildcardTypeArguments
        self.primaryNonWildcardTypeArgumentsSuffix = primaryNonWildcardTypeArgumentsSuffix
    }
}

public protocol PrimaryNonWildcardTypeArgumentsSuffix { }

public class PrimaryNonWildcardTypeArgumentsThisSuffix: PrimaryNonWildcardTypeArgumentsSuffix {
    
    public let thisKeyword: Token
    
    public let arguments: Arguments
    
    public init(thisKeyword: Token, arguments: Arguments) {
        self.thisKeyword = thisKeyword
        self.arguments = arguments
    }
}

public class PrimaryPrimitiveTypeClass: Primary {
        
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
}

public class PrimaryThisKeyword: Primary {
    
    public let thisKeyword: Token
    
    public init(thisKeyword: Token) {
        self.thisKeyword = thisKeyword
    }
}

public class PrimaryVoidClass: Primary {
        
    public let voidKeyword: Token
    
    public let period: Token
    
    public let classKeyword: Token
    
    public init(voidKeyword: Token, period: Token, classKeyword: Token) {
        self.voidKeyword = voidKeyword
        self.period = period
        self.classKeyword = classKeyword
    }
}

public class PrimarySuperSuffix: Primary {
        
    public let superKeyword: Token
    
    public let superSuffix: SuperSuffix
    
    public init(superKeyword: Token, superSuffix: SuperSuffix) {
        self.superKeyword = superKeyword
        self.superSuffix = superSuffix
    }
}

public class PrimitiveType: CreatedName, UnaryExpressionCastType {

    public let token: Token

    public init(token: Token) {
        self.token = token
    }
}

public class QualifiedName {

    public let identifiers: [Identifier]

    public init(identifiers: [Identifier]) {
        self.identifiers = identifiers
    }
}

public class QueryDefinition: Definition {

    public let queryKeyword: Token

    public let stringID: StringID

    public let queryOptions: QueryOptions

    public let conditionalOrs: [ConditionalOr]

    public let endKeyword: Token

    public init(queryKeyword: Token, stringID: StringID, queryOptions: QueryOptions, conditionalOrs: [ConditionalOr], endKeyword: Token) {
        self.queryKeyword = queryKeyword
        self.stringID = stringID
        self.queryOptions = queryOptions
        self.conditionalOrs = conditionalOrs
        self.endKeyword = endKeyword
    }
}

public class QueryOptions {

    public let queryOptionsPrefix: QueryOptionsPrefix?

    public let annotations: [Annotation]

    public init(queryOptionsPrefix: QueryOptionsPrefix?, annotations: [Annotation]) {
        self.queryOptionsPrefix = queryOptionsPrefix
        self.annotations = annotations
    }
}

public protocol QueryOptionsPrefix { }

public class RealLiteral: Literal {

    public let token: Token

    public init(token: Token) {
        self.token = token
    }
}

public class RelationalExpression {

    public let shiftExpression: ShiftExpression

    public let orRestrictions: [OrRestriction]

    public init(shiftExpression: ShiftExpression, orRestrictions: [OrRestriction]) {
        self.shiftExpression = shiftExpression
        self.orRestrictions = orRestrictions
    }
}

public protocol RelationalOperator { }

public class RelationalOperatorExpression: RelationalOperator {

    public let notKeyword: Token?

    public let identifier: Identifier

    public let bracketedExpressions: BracketedExpressions?

    public init(notKeyword: Token?, identifier: Identifier, bracketedExpressions: BracketedExpressions?) {
        self.notKeyword = notKeyword
        self.identifier = identifier
        self.bracketedExpressions = bracketedExpressions
    }
}

public class RelationalOperatorToken: RelationalOperator {

    public let token: Token

    public init(token: Token) {
        self.token = token
    }
}

public protocol RHSStatement { }

public protocol RuleAttribute: Definition { }

public class RuleAttributes {

    public let ruleAttributesPrefix: RuleAttributesPrefix?

    public let ruleAttributesSuffix: RuleAttributesSuffix?

    public init(ruleAttributesPrefix: RuleAttributesPrefix?, ruleAttributesSuffix: RuleAttributesSuffix?) {
        self.ruleAttributesPrefix = ruleAttributesPrefix
        self.ruleAttributesSuffix = ruleAttributesSuffix
    }
}

public class RuleAttributesPrefix {

    public let attributesKeyword: Token

    public let colon: Token?

    public init(attributesKeyword: Token, colon: Token?) {
        self.attributesKeyword = attributesKeyword
        self.colon = colon
    }
}

public class RuleAttributesSuffix {

    public let ruleAttributesSuffixSegments: [RuleAttributesSuffixSegment]

    public init(ruleAttributesSuffixSegments: [RuleAttributesSuffixSegment]) {
        self.ruleAttributesSuffixSegments = ruleAttributesSuffixSegments
    }
}

public class RuleAttributesSuffixSegment {

    public let ruleAttribute: RuleAttribute

    public let comma: Token?

    public init(ruleAttribute: RuleAttribute, comma: Token?) {
        self.ruleAttribute = ruleAttribute
        self.comma = comma
    }
}

public class RuleDefinition: Definition {

    public let ruleKeyword: Token

    public let stringID: StringID

    public let ruleOptions: RuleOptions

    public let whenPart: WhenPart?

    public let thenPart: ThenPart

    public init(ruleKeyword: Token, stringID: StringID, ruleOptions: RuleOptions, whenPart: WhenPart?, thenPart: ThenPart) {
        self.ruleKeyword = ruleKeyword
        self.stringID = stringID
        self.ruleOptions = ruleOptions
        self.whenPart = whenPart
        self.thenPart = thenPart
    }
}

public class RuleOptions {

    public let extendsClause: ExtendsClause

    public let annotations: [Annotation]

    public let ruleAttributes: RuleAttributes

    public init(extendsClause: ExtendsClause, annotations: [Annotation], ruleAttributes: RuleAttributes) {
        self.extendsClause = extendsClause
        self.annotations = annotations
        self.ruleAttributes = ruleAttributes
    }
}

public protocol Selector { }

public class ShiftExpression {

    public let additiveExpression: AdditiveExpression

    public let shiftExpressionRHS: ShiftExpressionRHS?

    public init(additiveExpression: AdditiveExpression, shiftExpressionRHS: ShiftExpressionRHS?) {
        self.additiveExpression = additiveExpression
        self.shiftExpressionRHS = shiftExpressionRHS
    }
}

public class ShiftExpressionRHS {

    public let `operator`: Token

    public let additiveExpression: AdditiveExpression

    public let shiftExpressionRHS: ShiftExpressionRHS?

    public init(operator: Token, additiveExpression: AdditiveExpression, shiftExpressionRHS: ShiftExpressionRHS?) {
        self.operator = `operator`
        self.additiveExpression = additiveExpression
        self.shiftExpressionRHS = shiftExpressionRHS
    }
}

public class SimpleType: Type {
    
    public let primitiveType: PrimitiveType

    public let bracketPairs: [BracketPair]
    
    public init(primitiveType: PrimitiveType, bracketPairs: [BracketPair]) {
        self.primitiveType = primitiveType
        self.bracketPairs = bracketPairs
    }
}

public class SingleRelationalRestriction: SingleRestriction {
    
    public let relationalOperator: RelationalOperator

    public let shiftExpression: ShiftExpression
    
    public init(relationalOperator: RelationalOperator, shiftExpression: ShiftExpression) {
        self.relationalOperator = relationalOperator
        self.shiftExpression = shiftExpression
    }
}

public protocol SingleRestriction { }

public class SourcePattern: BindingPatternBody {
    
    public let pattern: Pattern

    public let overClause: OverClause?

    public let sourcePatternFromPart: SourcePatternFromPart?
    
    public init(pattern: Pattern, overClause: OverClause?, sourcePatternFromPart: SourcePatternFromPart?) {
        self.pattern = pattern
        self.overClause = overClause
        self.sourcePatternFromPart = sourcePatternFromPart
    }
}

public class SourcePatternFromPart {

    public let fromKeyword: Token

    public let sourcePatternFromPartSuffix: SourcePatternFromPartSuffix
    
    public init(fromKeyword: Token, sourcePatternFromPartSuffix: SourcePatternFromPartSuffix) {
        self.fromKeyword = fromKeyword
        self.sourcePatternFromPartSuffix = sourcePatternFromPartSuffix
    }
}

public protocol StringID { }

public protocol SourcePatternFromPartSuffix { }

public class Statement: RHSStatement {
    // TODO
}

public class StringLiteral: Literal, StringID {
    
    public let token: Token
    
    public init(token: Token) {
        self.token = token
    }
}

public class StringLiteralRuleAttribute: RuleAttribute {
    
    public let keyword: Token

    public let stringLiteral: StringLiteral
    
    public init(keyword: Token, stringLiteral: StringLiteral) {
        self.keyword = keyword
        self.stringLiteral = stringLiteral
    }
}

public class SuperSelector: Selector {
    
    public let period: Token

    public let superKeyword: Token

    public let superSuffix: SuperSuffix
    
    public init(period: Token, superKeyword: Token, superSuffix: SuperSuffix) {
        self.period = period
        self.superKeyword = superKeyword
        self.superSuffix = superSuffix
    }
}

public protocol SuperSuffix { }

public class ThenPart {
    
    public let thenKeyword: Token

    public let rhsStatements: [RHSStatement]

    public let endKeyword: Token
    
    public init(thenKeyword: Token, rhsStatements: [RHSStatement], endKeyword: Token) {
        self.thenKeyword = thenKeyword
        self.rhsStatements = rhsStatements
        self.endKeyword = endKeyword
    }
}

public class TimerRuleAttribute: RuleAttribute {
    
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
}

public class Tokens: AnnotationInnerBody {
    
    public init() { }
}

public protocol Type: TypeArgument, UnaryExpressionCastType { }

public protocol TypeArgument { }

public class TypeArguments {
    
    public let leftAngle: Token

    public let typeArguments: [TypeArgument]

    public let rightAngle: Token
    
    public init(leftAngle: Token, typeArguments: [TypeArgument], rightAngle: Token) {
        self.leftAngle = leftAngle
        self.typeArguments = typeArguments
        self.rightAngle = rightAngle
    }
}

public class TypeDefinition: Definition {
    
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
}

public class TypeOptions {
    
    public let typeOptionsExtension: TypeOptionsExtension?

    public let annotations: [Annotation]
    
    public init(typeOptionsExtension: TypeOptionsExtension?, annotations: [Annotation]) {
        self.typeOptionsExtension = typeOptionsExtension
        self.annotations = annotations
    }
}

public class TypeOptionsExtension {
    
    public let extendsKeyword: Token

    public let qualifiedName: QualifiedName
    
    public init(extendsKeyword: Token, qualifiedName: QualifiedName) {
        self.extendsKeyword = extendsKeyword
        self.qualifiedName = qualifiedName
    }
}

public protocol UnaryExpression { }

public class UnaryExpressionCast: UnaryExpression {
    
    public let leftParenthesis: Token

    public let unaryExpressionCastType: UnaryExpressionCastType

    public let rightParenthesis: Token

    public let unaryExpression: UnaryExpression
    
    public init(leftParenthesis: Token, unaryExpressionCastType: UnaryExpressionCastType, rightParenthesis: Token, unaryExpression: UnaryExpression) {
        self.leftParenthesis = leftParenthesis
        self.unaryExpressionCastType = unaryExpressionCastType
        self.rightParenthesis = rightParenthesis
        self.unaryExpression = unaryExpression
    }
}

public protocol UnaryExpressionCastType { }

public class UnaryExpressionIncrementDecrement: UnaryExpression {
    
    public let `operator`: Token

    public let primary: Primary
    
    public init(operator: Token, primary: Primary) {
        self.operator = `operator`
        self.primary = primary
    }
}

public class UnaryExpressionNegation: UnaryExpression {
    
    public let `operator`: Token

    public let unaryExpression: UnaryExpression
    
    public init(operator: Token, unaryExpression: UnaryExpression) {
        self.operator = `operator`
        self.unaryExpression = unaryExpression
    }
}

public class UnaryExpressionPlusMinus: UnaryExpression {
    
    public let `operator`: Token

    public let unaryExpression: UnaryExpression
    
    public init(operator: Token, unaryExpression: UnaryExpression) {
        self.operator = `operator`
        self.unaryExpression = unaryExpression
    }
}

public class UnaryExpressionPrimary: UnaryExpression {
    
    public let unaryExpressionPrimaryAssignment: UnaryExpressionPrimaryAssignment?

    public let primary: Primary

    public let incrementOrDecrementOperator: Token?
    
    public init(unaryExpressionPrimaryAssignment: UnaryExpressionPrimaryAssignment?, primary: Primary, incrementOrDecrementOperator: Token?) {
        self.unaryExpressionPrimaryAssignment = unaryExpressionPrimaryAssignment
        self.primary = primary
        self.incrementOrDecrementOperator = incrementOrDecrementOperator
    }
}

public class UnaryExpressionPrimaryAssignment {
    
    public let identifier: Identifier

    public let `operator`: Token
    
    public init(identifier: Identifier, operator: Token) {
        self.identifier = identifier
        self.operator = `operator`
    }
}

public protocol Value { }

public class ValueArray: Value {
    
    public let leftBrace: Token

    public let values: [Value]

    public let rightBrace: Token
    
    public init(leftBrace: Token, values: [Value], rightBrace: Token) {
        self.leftBrace = leftBrace
        self.values = values
        self.rightBrace = rightBrace
    }
}

public protocol VariableInitializer { }

public class WhenPart {
    
    public let whenKeyword: Token

    public let colon: Token?

    public let conditionalOrs: [ConditionalOr]
    
    public init(whenKeyword: Token, colon: Token?, conditionalOrs: [ConditionalOr]) {
        self.whenKeyword = whenKeyword
        self.colon = colon
        self.conditionalOrs = conditionalOrs
    }
}
