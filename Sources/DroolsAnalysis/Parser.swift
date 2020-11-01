
public class Parser {

    public enum Error: Swift.Error {
        case unexpected(actual: Token?, expected: Token? = nil)
    }

    private let reader: Reader<[Token]>

    public init(tokens: [Token]) {
        self.reader = Reader(collection: tokens)
    }

    public func parse() throws -> SyntaxTree {
        return SyntaxTree(
            compilationUnit: try self.parseCompilationUnit()
        )
    }

    internal func parseAccumulateAction() throws -> AccumulateAction {
        return AccumulateAction(
            actionKeyword: try self.expect(kind: .keyword, value: "action"),
            leftParenthesis: try self.expect(kind: .punctuator, value: "("),
            statements: self.zeroOrMany(Parser.parseStatement),
            rightParenthesis: try self.expect(kind: .punctuator, value: ")"),
            comma: self.maybe(kind: .punctuator, value: ",")
        )
    }

    internal func parseAccumulateClause() throws -> AccumulateClause {
        return AccumulateClause(
            accumulateKeyword: try self.expect(kind: .keyword, value: "accumulate"),
            leftParenthesis: try self.expect(kind: .punctuator, value: "("),
            conditionalAnd: try self.parseConditionalAnd(),
            comma: self.maybe(kind: .punctuator, value: ","),
            accumulateClauseBody: try self.parseAnyAccumulateClauseBody(),
            rightParenthesis: try self.expect(kind: .punctuator, value: ")")
        )
    }

    internal func parseAnyAccumulateClauseBody() throws -> AnyAccumulateClauseBody {
        return AnyAccumulateClauseBody(
            accumulateClauseBody: try self.maybe(Parser.parseAccumulateFunction)
                ?? self.parseAccumulateSteps()
        )
    }

    internal func parseAccumulateFunction() throws -> AccumulateFunction {
        return AccumulateFunction(
            identifier: try self.parseIdentifier(),
            leftParenthesis: try self.expect(kind: .punctuator, value: "("),
            conditionalExpressions: try self.zeroOrMany(
                Parser.parseConditionalExpression,
                separator: Token(kind: .punctuator, value: ",")
            ),
            rightParenthesis: try self.expect(kind: .punctuator, value: ")")
        )
    }

    internal func parseAccumulateInit() throws -> AccumulateInit {
        return AccumulateInit(
            initKeyword: try self.expect(kind: .keyword, value: "init"),
            leftParenthesis: try self.expect(kind: .punctuator, value: "("),
            statements: self.zeroOrMany(Parser.parseStatement),
            rightParenthesis: try self.expect(kind: .punctuator, value: ")"),
            comma: self.maybe(kind: .punctuator, value: ",")
        )
    }

    internal func parseAccumulateResult() throws -> AccumulateResult {
        return AccumulateResult(
            resultKeyword: try self.expect(kind: .keyword, value: "result"),
            leftParenthesis: try self.expect(kind: .punctuator, value: "("),
            conditionalExpression: try self.parseConditionalExpression(),
            rightParenthesis: try self.expect(kind: .punctuator, value: ")")
        )
    }

    internal func parseAccumulateReverse() throws -> AccumulateReverse {
        return AccumulateReverse(
            reverseKeyword: try self.expect(kind: .keyword, value: "reverse"),
            leftParenthesis: try self.expect(kind: .punctuator, value: "("),
            statements: self.zeroOrMany(Parser.parseStatement),
            rightParenthesis: try self.expect(kind: .punctuator, value: ")"),
            comma: self.maybe(kind: .punctuator, value: ",")
        )
    }

    internal func parseAccumulateSteps() throws -> AccumulateSteps {
        return AccumulateSteps(
            accumulateInit: try self.parseAccumulateInit(),
            accumulateAction: try self.parseAccumulateAction(),
            accumulateReverse: self.maybe(Parser.parseAccumulateReverse),
            accumulateResult: try self.parseAccumulateResult()
        )
    }

    internal func parseAccumulations() throws -> Accumulations {
        return Accumulations(
            accumulationsMappings: try self.oneOrMany(
                Parser.parseAccumulationsMapping,
                separator: Token(kind: .punctuator, value: ",")
            )
        )
    }

    internal func parseAccumulationsMapping() throws -> AccumulationsMapping {
        return AccumulationsMapping(
            identifier: try self.parseIdentifier(),
            colon: try self.expect(kind: .punctuator, value: ":"),
            accumulateFunction: try self.parseAccumulateFunction()
        )
    }

    internal func parseAdditiveExpression() throws -> AdditiveExpression {
        return AdditiveExpression(
            unaryExpression: try self.parseAnyUnaryExpression(),
            additiveExpressionRHS: self.maybe(Parser.parseAdditiveExpressionRHS)
        )
    }

    internal func parseAdditiveExpressionRHS() throws -> AdditiveExpressionRHS {
        return AdditiveExpressionRHS(
            operator: try self.expect(kind: .operator, values: ["+", "-", "*", "/", "%"]),
            unaryExpression: try self.parseAnyUnaryExpression(),
            additiveExpressionRHS: self.maybe(Parser.parseAdditiveExpressionRHS)
        )
    }

    internal func parseAnnotation() throws -> Annotation {
        return Annotation(
            atSign: try self.expect(kind: .punctuator, value: "@"),
            identifier: try self.parseIdentifier(),
            annotationBody: self.maybe(Parser.parseAnnotationBody)
        )
    }

    internal func parseAnnotationBody() throws -> AnnotationBody {
        return AnnotationBody(
            leftParenthesis: try self.expect(kind: .punctuator, value: "("),
            annotationInnerBody: try self.parseAnyAnnotationInnerBody(),
            rightParenthesis: try self.expect(kind: .punctuator, value: ")")
        )
    }

    internal func parseAnyAnnotationInnerBody() throws -> AnyAnnotationInnerBody {
        return AnyAnnotationInnerBody(
            annotationInnerBody: try self.maybe(Parser.parseAnnotationInnerBodyAssignments)
                ?? self.parseTokens()
        )
    }

    internal func parseAnnotationInnerBodyAssignment() throws -> AnnotationInnerBodyAssignment {
        return AnnotationInnerBodyAssignment(
            identifier: try self.parseIdentifier(),
            assignment: try self.expect(kind: .operator, value: "="),
            value: try self.parseAnyValue()
        )
    }

    internal func parseAnnotationInnerBodyAssignments() throws -> AnnotationInnerBodyAssignments {
        return AnnotationInnerBodyAssignments(
            annotationInnerBodyAssignments: try self.oneOrMany(
                Parser.parseAnnotationInnerBodyAssignment,
                separator: Token(kind: .punctuator, value: ",")
            )
        )
    }

    internal func parseArguments() throws -> Arguments {
        return Arguments(
            leftParenthesis: try self.expect(kind: .punctuator, value: "("),
            expressions: try self.zeroOrMany(
                Parser.parseExpression,
                separator: Token(kind: .punctuator, value: ",")
            ),
            rightParenthesis: try self.expect(kind: .punctuator, value: ")")
        )
    }

    internal func parseArrayCreatorRest() throws -> ArrayCreatorRest {
        return ArrayCreatorRest(
            arrayCreatorRestBody: try self.parseAnyArrayCreatorRestBody()
        )
    }

    internal func parseAnyArrayCreatorRestBody() throws -> AnyArrayCreatorRestBody {
        return AnyArrayCreatorRestBody(
            arrayCreatorRestBody: try self.maybe(Parser.parseArrayCreatorRestExpressionBody)
                ?? self.parseArrayCreatorRestInitializerBody()
        )
    }

    internal func parseArrayCreatorRestExpressionBody() throws -> ArrayCreatorRestExpressionBody {
        return ArrayCreatorRestExpressionBody(
            bracketedExpressions: try self.oneOrMany(Parser.parseBracketedExpression),
            bracketPairs: self.zeroOrMany(Parser.parseBracketPair)
        )
    }

    internal func parseArrayCreatorRestInitializerBody() throws -> ArrayCreatorRestInitializerBody {
        return ArrayCreatorRestInitializerBody(
            bracketPairs: try self.oneOrMany(Parser.parseBracketPair),
            arrayInitializer: try self.parseArrayInitializer()
        )
    }

    internal func parseArrayInitializer() throws -> ArrayInitializer {
        return ArrayInitializer(
            leftBrace: try self.expect(kind: .punctuator, value: "{"),
            arrayVariableInitializers: try self.parseArrayVariableInitializers(),
            rightBrace: try self.expect(kind: .punctuator, value: "}")
        )
    }

    internal func parseArrayVariableInitializers() throws -> ArrayVariableInitializers {
        return ArrayVariableInitializers(
            variableInitializers: try self.zeroOrMany(
                Parser.parseAnyVariableInitializer,
                separator: Token(kind: .punctuator, value: ",")
            ),
            comma: self.maybe(kind: .punctuator, value: ",")
        )
    }

    internal func parseAssignmentOperator() throws -> AssignmentOperator {
        return AssignmentOperator(
            operator: try self.expect(
                kind: .operator,
                values: ["=", "+=", "-=", "*=", "/=", "%=", "&=", "|=", "^=", "<<=", ">>=", ">>>="]
            )
        )
    }

    internal func parseBindingPattern() throws -> BindingPattern {
        return BindingPattern(
            bindingPatternIdentifier: self.maybe(Parser.parseBindingPatternIdentifier),
            bindingPatternBody: try self.parseAnyBindingPatternBody()
        )
    }

    internal func parseAnyBindingPatternBody() throws -> AnyBindingPatternBody {
        return AnyBindingPatternBody(
            bindingPatternBody: try self.maybe(Parser.parseBindingPatternMultipleSourcePattern)
                ?? self.parseSourcePattern()
        )
    }
    
    internal func parseBindingPatternIdentifier() throws -> BindingPatternIdentifier {
        return BindingPatternIdentifier(
            identifier: try self.parseIdentifier(),
            colon: try self.expect(kind: .punctuator, value: ":")
        )
    }

    internal func parseBindingPatternMultipleSourcePattern() throws -> BindingPatternMultipleSourcePattern {
        return BindingPatternMultipleSourcePattern(
            leftParenthesis: try self.expect(kind: .punctuator, value: "("),
            sourcePatterns: try self.oneOrMany(
                Parser.parseSourcePattern,
                separator: Token(kind: .keyword, value: "or")
            ),
            rightParenthesis: try self.expect(kind: .punctuator, value: ")")
        )
    }

    internal func parseBlock() throws -> Block {
        return Block(
            leftBrace: try self.expect(kind: .punctuator, value: "{"),
            statements: self.zeroOrMany(Parser.parseStatement),
            rightBrace: try self.expect(kind: .punctuator, value: "}")
        )
    }

    internal func parseBooleanLiteral() throws -> BooleanLiteral {
        return BooleanLiteral(
            token: try self.expect(kind: .booleanLiteral)
        )
    }

    internal func parseBooleanLiteralRuleAttribute() throws -> BooleanLiteralRuleAttribute {
        return BooleanLiteralRuleAttribute(
            keyword: try self.expect(kind: .keyword, values: ["auto-focus", "no-loop", "lock-on-active"]),
            booleanLiteral: self.maybe(Parser.parseBooleanLiteral)
        )
    }

    internal func parseBracketedExpression() throws -> BracketedExpression {
        return BracketedExpression(
            leftBracket: try self.expect(kind: .punctuator, value: "["),
            expression: try self.parseExpression(),
            rightBracket: try self.expect(kind: .punctuator, value: "]")
        )
    }

    internal func parseBracketedExpressions() throws -> BracketedExpressions {
        return BracketedExpressions(
            bracketedExpressions: try self.oneOrMany(Parser.parseBracketedExpression)
        )
    }

    internal func parseBracketPair() throws -> BracketPair {
        return BracketPair(
            leftBracket: try self.expect(kind: .punctuator, value: "["),
            rightBracket: try self.expect(kind: .punctuator, value: "]")
        )
    }

    internal func parseCalendarsRuleAttribute() throws -> CalendarsRuleAttribute {
        return CalendarsRuleAttribute(
            calendarsKeyword: try self.expect(kind: .keyword, value: "calendars"),
            stringLiterals: try self.oneOrMany(
                Parser.parseStringLiteral,
                separator: Token(kind: .punctuator, value: ",")
            )
        )
    }

    internal func parseCollectBindingClause() throws -> CollectBindingClause {
        return CollectBindingClause(
            collectKeyword: try self.expect(kind: .keyword, value: "collect"),
            leftParenthesis: try self.expect(kind: .punctuator, value: "("),
            bindingPattern: try self.parseBindingPattern(),
            rightParenthesis: try self.expect(kind: .punctuator, value: ")")
        )
    }

    internal func parseCompilationUnit() throws -> CompilationUnit {
        return CompilationUnit(
            packageDeclaration: self.maybe(Parser.parsePackageDeclaration),
            fullDefinitions: self.zeroOrMany(Parser.parseFullDefinition)
        )
    }

    internal func parseComplexCreatedName() throws -> ComplexCreatedName {
        return ComplexCreatedName(
            complexCreatedNameParts: try self.oneOrMany(
                Parser.parseComplexCreatedNamePart,
                separator: Token(kind: .punctuator, value: ".")
            )
        )
    }

    internal func parseComplexCreatedNamePart() throws -> ComplexCreatedNamePart {
        return ComplexCreatedNamePart(
            identifier: try self.parseIdentifier(),
            typeArguments: self.maybe(Parser.parseTypeArguments)
        )
    }

    internal func parseComplexType() throws -> ComplexType {
        return ComplexType(
            complexTypeSegments: try self.oneOrMany(
                Parser.parseComplexTypeSegment,
                separator: Token(kind: .punctuator, value: ".")
            ),
            bracketPairs: self.zeroOrMany(Parser.parseBracketPair)
        )
    }

    internal func parseComplexTypeSegment() throws -> ComplexTypeSegment {
        return ComplexTypeSegment(
            identifier: try self.parseIdentifier(),
            typeArguments: self.maybe(Parser.parseTypeArguments)
        )
    }

    internal func parseConditionalAnd() throws -> ConditionalAnd {
        return ConditionalAnd(
            conditionalElements: try self.oneOrMany(
                Parser.parseConditionalElement,
                separator: Token(kind: .keyword, value: "and")
            )
        )
    }

    internal func parseConditionalElement() throws -> ConditionalElement {
        return ConditionalElement(
            conditionalElementBody: try self.parseAnyConditionalElementBody(),
            semicolon: self.maybe(kind: .punctuator, value: ";")
        )
    }

    internal func parseConditionalElementAccumulate() throws -> ConditionalElementAccumulate {
        return ConditionalElementAccumulate(
            accumulateKeyword: try self.expect(kind: .keyword, value: "accumulate"),
            leftParenthesis: try self.expect(kind: .punctuator, value: "("),
            conditionalAnd: try self.parseConditionalAnd(),
            comma: self.maybe(kind: .punctuator, value: ","),
            accumulations: try self.parseAccumulations(),
            rightParenthesis: try self.expect(kind: .punctuator, value: ")")
        )
    }

    internal func parseAnyConditionalElementBody() throws -> AnyConditionalElementBody {
        if let bindingPattern = self.maybe(Parser.parseBindingPattern) {
            return AnyConditionalElementBody(conditionalElementBody: bindingPattern)
        }
        if let conditionalElementAccumulate = self.maybe(Parser.parseConditionalElementAccumulate) {
            return AnyConditionalElementBody(conditionalElementBody: conditionalElementAccumulate)
        }
        if let conditionalElementEval = self.maybe(Parser.parseConditionalElementEval) {
            return AnyConditionalElementBody(conditionalElementBody: conditionalElementEval)
        }
        if let conditionalElementExists = self.maybe(Parser.parseConditionalElementExists) {
            return AnyConditionalElementBody(conditionalElementBody: conditionalElementExists)
        }
        if let conditionalElementForall = self.maybe(Parser.parseConditionalElementForall) {
            return AnyConditionalElementBody(conditionalElementBody: conditionalElementForall)
        }
        if let conditionalElementNot = self.maybe(Parser.parseConditionalElementNot) {
            return AnyConditionalElementBody(conditionalElementBody: conditionalElementNot)
        }
        return AnyConditionalElementBody(conditionalElementBody: try self.parseParenthesizedConditionalOr())
    }

    internal func parseConditionalElementEval() throws -> ConditionalElementEval {
        return ConditionalElementEval(
            evalKeyword: try self.expect(kind: .keyword, value: "eval"),
            leftParenthesis: try self.expect(kind: .punctuator, value: "("),
            conditionalExpression: try self.parseConditionalExpression(),
            rightParenthesis: try self.expect(kind: .punctuator, value: ")")
        )
    }

    internal func parseConditionalElementExists() throws -> ConditionalElementExists {
        return ConditionalElementExists(
            existsKeyword: try self.expect(kind: .keyword, value: "exists"),
            conditionalElementExistsBody: try self.parseAnyConditionalElementExistsBody()
        )
    }

    internal func parseAnyConditionalElementExistsBody() throws -> AnyConditionalElementExistsBody {
        return AnyConditionalElementExistsBody(
            conditionalElementExistsBody: try self.maybe(Parser.parseBindingPattern)
                ?? self.parseParenthesizedConditionalOr()
        )
    }

    internal func parseConditionalElementForall() throws -> ConditionalElementForall {
        return ConditionalElementForall(
            forallKeyword: try self.expect(kind: .keyword, value: "forall"),
            leftParenthesis: try self.expect(kind: .punctuator, value: "("),
            bindingPatterns: try self.oneOrMany(Parser.parseBindingPattern),
            rightParenthesis: try self.expect(kind: .punctuator, value: ")")
        )
    }

    internal func parseConditionalElementNot() throws -> ConditionalElementNot {
        return ConditionalElementNot(
            notKeyword: try self.expect(kind: .keyword, value: "not"),
            conditionalElementNotBody: try self.parseAnyConditionalElementNotBody()
        )
    }

    internal func parseAnyConditionalElementNotBody() throws -> AnyConditionalElementNotBody {
        return AnyConditionalElementNotBody(
            conditionalElementNotBody: try self.maybe(Parser.parseBindingPattern)
                ?? self.parseParenthesizedConditionalOr()
        )
    }

    internal func parseConditionalExpression() throws -> ConditionalExpression {
        return ConditionalExpression(
            conditionalOrExpression: try self.parseConditionalOrExpression(),
            conditionalExpressionBody: self.maybe(Parser.parseConditionalExpressionBody)
        )
    }

    internal func parseConditionalExpressionBody() throws -> ConditionalExpressionBody {
        return ConditionalExpressionBody(
            questionMark: try self.expect(kind: .punctuator, value: "?"),
            trueExpression: try self.parseExpression(),
            colon: try self.expect(kind: .punctuator, value: ":"),
            falseExpression: try self.parseExpression()
        )
    }
    
    internal func parseConditionalExpressionRuleAttribute() throws -> ConditionalExpressionRuleAttribute {
        return ConditionalExpressionRuleAttribute(
            keyword: try self.expect(kind: .keyword, values: ["salience", "enabled"]),
            conditionalExpression: try self.parseConditionalExpression()
        )
    }

    internal func parseConditionalOr() throws -> ConditionalOr {
        return ConditionalOr(
            conditionalAnds: try self.oneOrMany(
                Parser.parseConditionalAnd,
                separator: try self.expect(kind: .keyword, value: "or")
            )
        )
    }

    internal func parseConditionalOrExpression() throws -> ConditionalOrExpression {
        return ConditionalOrExpression(
            instanceOfExpression: try self.parseInstanceOfExpression(),
            conditionalOrExpressionRHS: self.maybe(Parser.parseConditionalOrExpressionRHS)
        )
    }

    internal func parseConditionalOrExpressionRHS() throws -> ConditionalOrExpressionRHS {
        return ConditionalOrExpressionRHS(
            operator: try self.expect(kind: .operator, values: ["&", "|", "^", "&&", "||", "==", "!="]),
            instanceOfExpression: try self.parseInstanceOfExpression(),
            conditionalOrExpressionRHS: self.maybe(Parser.parseConditionalOrExpressionRHS)
        )
    }

    internal func parseConstraints() throws -> Constraints {
        return Constraints(
            constraintsLeadingExpressions: self.maybe(Parser.parseConstraintsLeadingExpressions),
            constraintsTrailingExpressions: self.maybe(Parser.parseConstraintsTrailingExpressions)
        )
    }

    internal func parseConstraintsLeadingExpressions() throws -> ConstraintsLeadingExpressions {
        return ConstraintsLeadingExpressions(
            conditionalOrExpressions: try self.oneOrMany(
                Parser.parseConditionalOrExpression,
                separator: Token(kind: .punctuator, value: ",")
            ),
            semicolon: try self.expect(kind: .punctuator, value: ";")
        )
    }

    internal func parseConstraintsTrailingExpressions() throws -> ConstraintsTrailingExpressions {
        return ConstraintsTrailingExpressions(
            conditionalOrExpressions: try self.oneOrMany(
                Parser.parseConditionalOrExpression,
                separator: Token(kind: .punctuator, value: ",")
            )
        )
    }

    internal func parseAnyCreatedName() throws -> AnyCreatedName {
        return AnyCreatedName(
            createdName: try self.maybe(Parser.parsePrimitiveType)
                ?? self.parseComplexCreatedName()
        )
    }

    internal func parseCreator() throws -> Creator {
        return Creator(
            nonWildcardTypeArguments: self.maybe(Parser.parseNonWildcardTypeArguments),
            createdName: try self.parseAnyCreatedName(),
            creatorBody: try self.parseAnyCreatorBody()
        )
    }

    internal func parseAnyCreatorBody() throws -> AnyCreatorBody {
        return AnyCreatorBody(
            creatorBody: try self.maybe(Parser.parseArguments)
                ?? self.parseArrayCreatorRest()
        )
    }

    internal func parseAnyDefinition() throws -> AnyDefinition {
        if let ruleAttribute = self.maybe(Parser.parseAnyRuleAttribute) {
            return AnyDefinition(definition: ruleAttribute.ruleAttribute)
        }
        if let importDefinition = self.maybe(Parser.parseImportDefinition) {
            return AnyDefinition(definition: importDefinition)
        }
        if let globalDefinition = self.maybe(Parser.parseGlobalDefinition) {
            return AnyDefinition(definition: globalDefinition)
        }
        if let functionDefinition = self.maybe(Parser.parseFunctionDefinition) {
            return AnyDefinition(definition: functionDefinition)
        }
        if let typeDefinition = self.maybe(Parser.parseTypeDefinition) {
            return AnyDefinition(definition: typeDefinition)
        }
        if let ruleDefinition = self.maybe(Parser.parseRuleDefinition) {
            return AnyDefinition(definition: ruleDefinition)
        }
        return AnyDefinition(definition: try parseQueryDefinition())
    }

    internal func parseEntryPointClause() throws -> EntryPointClause {
        return EntryPointClause(
            entryPointKeyword: try self.expect(kind: .keyword, value: "entry-point"),
            stringID: try self.parseAnyStringID()
        )
    }

    internal func parseExplicitGenericInvocation() throws -> ExplicitGenericInvocation {
        return ExplicitGenericInvocation(
            nonWildcardTypeArguments: try self.parseNonWildcardTypeArguments(),
            arguments: try self.parseArguments()
        )
    }

    internal func parseExplicitGenericInvocationSuffix() throws -> ExplicitGenericInvocationSuffix {
        return try self.maybe(Parser.parseExplicitGenericInvocationSuperSuffix)
            ?? self.parseExplicitGenericInvocationArgumentsSuffix()
    }

    internal func parseExplicitGenericInvocationArgumentsSuffix() throws -> ExplicitGenericInvocationArgumentsSuffix {
        return ExplicitGenericInvocationArgumentsSuffix(
            identifier: try self.parseIdentifier(),
            arguments: try self.parseArguments()
        )
    }

    internal func parseExplicitGenericInvocationSuperSuffix() throws -> ExplicitGenericInvocationSuperSuffix {
        return ExplicitGenericInvocationSuperSuffix(
            superKeyword: try self.expect(kind: .keyword, value: "super"),
            superSuffix: try self.parseAnySuperSuffix()
        )
    }

    internal func parseExpression() throws -> Expression {
        return Expression(
            conditionalExpression: try self.parseConditionalExpression(),
            expressionRHS: self.maybe(Parser.parseExpressionRHS)
        )
    }

    internal func parseExpressionRHS() throws -> ExpressionRHS {
        return ExpressionRHS(
            assignmentOperator: try self.parseAssignmentOperator(),
            expression: try self.parseExpression()
        )
    }

    internal func parseExtendsClause() throws -> ExtendsClause {
        return ExtendsClause(
            extendsKeyword: try self.expect(kind: .keyword, value: "extends"),
            stringID: try self.parseAnyStringID()
        )
    }

    internal func parseField() throws -> Field {
        return Field(
            identifier: try self.parseIdentifier(),
            colon: try self.expect(kind: .punctuator, value: ":"),
            qualifiedName: try self.parseQualifiedName(),
            fieldAssignment: self.maybe(Parser.parseFieldAssignment),
            annotations: self.zeroOrMany(Parser.parseAnnotation),
            semicolon: self.maybe(kind: .punctuator, value: ";")
        )
    }

    internal func parseFieldAssignment() throws -> FieldAssignment {
        return FieldAssignment(
            assignment: try self.expect(kind: .operator, value: "="),
            conditionalExpression: try self.parseConditionalExpression()
        )
    }

    internal func parseFromAccumulateClause() throws -> FromAccumulateClause {
        return FromAccumulateClause(
            fromKeyword: try self.expect(kind: .keyword, value: "from"),
            accumulateClause: try self.parseAccumulateClause()
        )
    }

    internal func parseFromClause() throws -> FromClause {
        return FromClause(
            fromKeyword: try self.expect(kind: .keyword, value: "from"),
            conditionalOrExpression: try self.parseConditionalOrExpression()
        )
    }

    internal func parseFromCollectClause() throws -> FromCollectClause {
        return FromCollectClause(
            fromKeyword: try self.expect(kind: .keyword, value: "from"),
            collectKeyword: try self.expect(kind: .keyword, value: "collect"),
            leftParenthesis: try self.expect(kind: .punctuator, value: "("),
            sourcePattern: try self.parseSourcePattern(),
            rightParenthesis: try self.expect(kind: .punctuator, value: ")")
        )
    }

    internal func parseFullDefinition() throws -> FullDefinition {
        return FullDefinition(
            definition: try self.parseAnyDefinition(),
            semicolon: self.maybe(kind: .punctuator, value: ";")
        )
    }

    internal func parseFunctionDefinition() throws -> FunctionDefinition {
        return FunctionDefinition(
            functionKeyword: try self.expect(kind: .keyword, value: "function"),
            type: self.maybe(Parser.parseAnyType),
            identifier: try self.parseIdentifier(),
            parameters: try self.parseParameters(),
            block: try self.parseBlock()
        )
    }

    internal func parseGlobalDefinition() throws -> GlobalDefinition {
        return GlobalDefinition(
            globalKeyword: try self.expect(kind: .keyword, value: "global"),
            type: try self.parseAnyType(),
            identifier: try self.parseIdentifier()
        )
    }

    internal func parseIdentifier() throws -> Identifier {
        return Identifier(
            token: try self.expect(kind: .identifier)
        )
    }
    
    internal func parseIdentifierSelector() throws -> IdentifierSelector {
        return IdentifierSelector(
            period: try self.expect(kind: .punctuator, value: "."),
            identifier: try self.parseIdentifier(),
            arguments: self.maybe(Parser.parseArguments)
        )
    }

    internal func parseAnyIdentifierSuffix() throws -> AnyIdentifierSuffix {
        return AnyIdentifierSuffix(
            identifierSuffix: try self.maybe(Parser.parseIdentifierSuffixClass)
                ?? self.maybe(Parser.parseBracketedExpressions)
                ?? self.parseArguments()
        )
    }
    
    internal func parseIdentifierSuffixClass() throws -> IdentifierSuffixClass {
        return IdentifierSuffixClass(
            bracketPairs: try self.oneOrMany(Parser.parseBracketPair),
            period: try self.expect(kind: .punctuator, value: "."),
            classKeyword: try self.expect(kind: .keyword, value: "class")
        )
    }
    
    internal func parseIdentifierSuperSuffix() throws -> IdentifierSuperSuffix {
        return IdentifierSuperSuffix(
            period: try self.expect(kind: .punctuator, value: "."),
            identifier: try self.parseIdentifier(),
            arguments: self.maybe(Parser.parseArguments)
        )
    }

    internal func parseImportDefinition() throws -> ImportDefinition {
        return ImportDefinition(
            importKeyword: try self.expect(kind: .keyword, value: "import"),
            functionOrStaticKeyword: self.maybe(kind: .keyword, values: ["function", "static"]),
            qualifiedName: try self.parseQualifiedName(),
            importDefinitionSuffix: self.maybe(Parser.parseImportDefinitionSuffix)
        )
    }

    internal func parseImportDefinitionSuffix() throws -> ImportDefinitionSuffix {
        return ImportDefinitionSuffix(
            period: try self.expect(kind: .punctuator, value: "."),
            asterisk: try self.expect(kind: .operator, value: "*")
        )
    }

    internal func parseInExpression() throws -> InExpression {
        return InExpression(
            relationalExpression: try self.parseRelationalExpression(),
            notKeyword: self.maybe(kind: .keyword, value: "not"),
            inKeyword: try self.expect(kind: .keyword, value: "in"),
            leftParenthesis: try self.expect(kind: .punctuator, value: "("),
            expressions: try self.oneOrMany(
                Parser.parseExpression,
                separator: Token(kind: .punctuator, value: ",")
            ),
            rightParenthesis: try self.expect(kind: .punctuator, value: ")")
        )
    }
    
    internal func parseInheritanceTypeArgument() throws -> InheritanceTypeArgument {
        return InheritanceTypeArgument(
            questionMark: try self.expect(kind: .operator, value: "?"),
            inheritanceTypeArgumentSuffix: self.maybe(Parser.parseInheritanceTypeArgumentSuffix)
        )
    }
    
    internal func parseInheritanceTypeArgumentSuffix() throws -> InheritanceTypeArgumentSuffix {
        return InheritanceTypeArgumentSuffix(
            extendsOrSuperKeyword: try self.expect(kind: .keyword, values: ["extends", "super"]),
            type: try self.parseAnyType()
        )
    }
    
    internal func parseInlineListExpression() throws -> InlineListExpression {
        return InlineListExpression(
            leftBracket: try self.expect(kind: .punctuator, value: "["),
            expressions: try self.oneOrMany(
                Parser.parseExpression,
                separator: Token(kind: .punctuator, value: ",")
            ),
            rightBracket: try self.expect(kind: .punctuator, value: "]")
        )
    }

    internal func parseInlineMapExpression() throws -> InlineMapExpression {
        return InlineMapExpression(
            leftBracket: try self.expect(kind: .punctuator, value: "["),
            mappings: try self.oneOrMany(
                Parser.parseMapping,
                separator: Token(kind: .punctuator, value: ",")
            ),
            rightBracket: try self.expect(kind: .punctuator, value: "]")
        )
    }

    internal func parseInnerCreator() throws -> InnerCreator {
        return InnerCreator(
            identifier: try self.parseIdentifier(),
            arguments: try self.parseArguments()
        )
    }

    internal func parseInstanceOfExpression() throws -> InstanceOfExpression {
        return InstanceOfExpression(
            inExpression: try self.parseInExpression(),
            instanceOfSuffix: self.maybe(Parser.parseInstanceOfSuffix)
        )
    }

    internal func parseInstanceOfSuffix() throws -> InstanceOfSuffix {
        return InstanceOfSuffix(
            instanceOfKeyword: try self.expect(kind: .keyword, value: "instanceof"),
            type: try self.parseAnyType()
        )
    }
    
    internal func parseIntLiteral() throws -> IntLiteral {
        return IntLiteral(
            token: try self.expect(kind: .intLiteral)
        )
    }

    internal func parseLiteral() throws -> Literal {
        return try self.maybe(Parser.parseIntLiteral)
            ?? self.maybe(Parser.parseRealLiteral)
            ?? self.maybe(Parser.parseBooleanLiteral)
            ?? self.parseStringLiteral()
    }
    
    internal func parseMapping() throws -> Mapping {
        return Mapping(
            leftExpression: try self.parseExpression(),
            colon: try self.expect(kind: .punctuator, value: ":"),
            rightExpression: try self.parseExpression()
        )
    }

    internal func parseModifyStatement() throws -> ModifyStatement {
        return ModifyStatement(
            modifyKeyword: try self.expect(kind: .keyword, value: "modify"),
            leftParenthesis: try self.expect(kind: .punctuator, value: "("),
            conditionalExpression: try self.parseConditionalExpression(),
            rightParenthesis: try self.expect(kind: .punctuator, value: ")"),
            leftBrace: try self.expect(kind: .punctuator, value: "{"),
            conditionalExpressions: try self.zeroOrMany(
                Parser.parseConditionalExpression,
                separator: Token(kind: .punctuator, value: ",")
            ),
            rightBrace: try self.expect(kind: .punctuator, value: "}")
        )
    }
    
    internal func parseNewSelector() throws -> NewSelector {
        return NewSelector(
            period: try self.expect(kind: .punctuator, value: "."),
            newKeyword: try self.expect(kind: .keyword, value: "new"),
            nonWildcardTypeArguments: self.maybe(Parser.parseNonWildcardTypeArguments),
            innerCreator: try self.parseInnerCreator()
        )
    }

    internal func parseNonWildcardTypeArguments() throws -> NonWildcardTypeArguments {
        return NonWildcardTypeArguments(
            leftAngle: try self.expect(kind: .operator, value: "<"),
            types: try self.oneOrMany(
                Parser.parseAnyType,
                separator: Token(kind: .punctuator, value: ",")
            ),
            rightAngle: try self.expect(kind: .operator, value: ">")
        )
    }

    internal func parseOrRestriction() throws -> OrRestriction {
        return OrRestriction(
            singleRestriction: try self.parseAnySingleRestriction(),
            orRestrictionRHS: self.maybe(Parser.parseOrRestrictionRHS)
        )
    }

    internal func parseOrRestrictionRHS() throws -> OrRestrictionRHS {
        return OrRestrictionRHS(
            operator: try self.expect(kind: .operator, values: ["&&", "||"]),
            singleRestriction: try self.parseAnySingleRestriction(),
            orRestrictionRHS: self.maybe(Parser.parseOrRestrictionRHS)
        )
    }

    internal func parseOverClause() throws -> OverClause {
        return OverClause(
            overKeyword: try self.expect(kind: .keyword, value: "over"),
            leftIdentifier: try self.parseIdentifier(),
            colon: try self.expect(kind: .punctuator, value: ":"),
            rightIdentifier: try self.parseIdentifier(),
            leftParenthesis: try self.expect(kind: .punctuator, value: "("),
            conditionalExpressions: try self.zeroOrMany(
                Parser.parseConditionalExpression,
                separator: Token(kind: .punctuator, value: ",")
            ),
            rightParenthesis: try self.expect(kind: .punctuator, value: ")")
        )
    }
    
    internal func parsePackageDeclaration() throws -> PackageDeclaration {
        return PackageDeclaration(
            packageKeyword: try self.expect(kind: .keyword, value: "package"),
            qualifiedName: try self.parseQualifiedName(),
            semicolon: self.maybe(kind: .punctuator, value: ";")
        )
    }

    internal func parseParameter() throws -> Parameter {
        return Parameter(
            type: try self.parseAnyType(),
            identifier: try self.parseIdentifier(),
            bracketPairs: self.zeroOrMany(Parser.parseBracketPair)
        )
    }

    internal func parseParameters() throws -> Parameters {
        return Parameters(
            leftParenthesis: try self.expect(kind: .punctuator, value: "("),
            parameters: try self.zeroOrMany(
                Parser.parseParameter,
                separator: Token(kind: .punctuator, value: ",")
            ),
            rightParenthesis: try self.expect(kind: .punctuator, value: ")")
        )
    }
    
    internal func parseParenthesizedConditionalOr() throws -> ParenthesizedConditionalOr {
        return ParenthesizedConditionalOr(
            leftParenthesis: try self.expect(kind: .punctuator, value: "("),
            conditionalOr: try self.parseConditionalOr(),
            rightParenthesis: try self.expect(kind: .punctuator, value: ")")
        )
    }
    
    internal func parseParenthesizedOrRestriction() throws -> ParenthesizedOrRestriction {
        return ParenthesizedOrRestriction(
            leftParenthesis: try self.expect(kind: .punctuator, value: "("),
            orRestriction: try self.parseOrRestriction(),
            rightParenthesis: try self.expect(kind: .punctuator, value: ")")
        )
    }
    
    internal func parseParenthesizedExpression() throws -> ParenthesizedExpression {
        return ParenthesizedExpression(
            leftParenthesis: try self.expect(kind: .punctuator, value: "("),
            expression: try self.parseExpression(),
            rightParenthesis: try self.expect(kind: .punctuator, value: ")")
        )
    }
    
    internal func parsePattern() throws -> Pattern {
        // BUG: This isn't elaborated on in the parse diagrams.
        return Pattern()
    }

    internal func parsePlaceholders() throws -> Placeholders {
        return Placeholders(
            leftParenthesis: try self.expect(kind: .punctuator, value: "("),
            identifiers: try self.zeroOrMany(
                Parser.parseIdentifier,
                separator: Token(kind: .punctuator, value: ",")
            ),
            rightParenthesis: try self.expect(kind: .punctuator, value: ")")
        )
    }

    internal func parseAnyPrimary() throws -> AnyPrimary {
        if let parenthesizedExpression = self.maybe(Parser.parseParenthesizedExpression) {
            return AnyPrimary(primary: parenthesizedExpression)
        }
        if let parsePrimaryNonWildcardTypeArguments = self.maybe(Parser.parsePrimaryNonWildcardTypeArguments) {
            return AnyPrimary(primary: parsePrimaryNonWildcardTypeArguments)
        }
        if let literal = self.maybe(Parser.parseLiteral) {
            return AnyPrimary(primary: literal)
        }
        if let primarySuperSuffix = self.maybe(Parser.parsePrimarySuperSuffix) {
            return AnyPrimary(primary: primarySuperSuffix)
        }
        if let primaryNewCreator = self.maybe(Parser.parsePrimaryNewCreator) {
            return AnyPrimary(primary: primaryNewCreator)
        }
        if let primaryPrimitiveTypeClass = self.maybe(Parser.parsePrimaryPrimitiveTypeClass) {
            return AnyPrimary(primary: primaryPrimitiveTypeClass)
        }
        if let primaryVoidClass = self.maybe(Parser.parsePrimaryVoidClass) {
            return AnyPrimary(primary: primaryVoidClass)
        }
        if let primaryThisKeyword = self.maybe(Parser.parsePrimaryThisKeyword) {
            return AnyPrimary(primary: primaryThisKeyword)
        }
        if let inlineMapExpression = self.maybe(Parser.parseInlineMapExpression) {
            return AnyPrimary(primary: inlineMapExpression)
        }
        if let inlineListExpression = self.maybe(Parser.parseInlineListExpression) {
            return AnyPrimary(primary: inlineListExpression)
        }
        return AnyPrimary(primary: try self.parsePrimaryIdentifier())
    }
    
    internal func parsePrimaryIdentifier() throws -> PrimaryIdentifier {
        return PrimaryIdentifier(
            identifiers: try self.oneOrMany(
                Parser.parseIdentifier,
                separator: Token(kind: .punctuator, value: ".")
            ),
            identifierSuffix: self.maybe(Parser.parseAnyIdentifierSuffix)
        )
    }
    
    internal func parsePrimaryNewCreator() throws -> PrimaryNewCreator {
        return PrimaryNewCreator(
            newKeyword: try self.expect(kind: .keyword, value: "new"),
            creator: try self.parseCreator()
        )
    }
    
    internal func parsePrimaryNonWildcardTypeArguments() throws -> PrimaryNonWildcardTypeArguments {
        return PrimaryNonWildcardTypeArguments(
            nonWildcardTypeArguments: try self.parseNonWildcardTypeArguments(),
            primaryNonWildcardTypeArgumentsSuffix: try self.parseAnyPrimaryNonWildcardTypeArgumentsSuffix()
        )
    }
    
    internal func parseAnyPrimaryNonWildcardTypeArgumentsSuffix() throws -> AnyPrimaryNonWildcardTypeArgumentsSuffix {
        return AnyPrimaryNonWildcardTypeArgumentsSuffix(
            primaryNonWildcardTypeArgumentsSuffix: try self.maybe(Parser.parseExplicitGenericInvocationSuffix)
                ?? self.parsePrimaryNonWildcardTypeArgumentsThisSuffix()
        )
    }
    
    internal func parsePrimaryNonWildcardTypeArgumentsThisSuffix() throws -> PrimaryNonWildcardTypeArgumentsThisSuffix {
        return PrimaryNonWildcardTypeArgumentsThisSuffix(
            thisKeyword: try self.expect(kind: .keyword, value: "this"),
            arguments: try self.parseArguments()
        )
    }
    
    internal func parsePrimaryPrimitiveTypeClass() throws -> PrimaryPrimitiveTypeClass {
        return PrimaryPrimitiveTypeClass(
            primitiveType: try self.parsePrimitiveType(),
            bracketPairs: self.zeroOrMany(Parser.parseBracketPair),
            period: try self.expect(kind: .punctuator, value: "."),
            classKeyword: try self.expect(kind: .keyword, value: "class")
        )
    }
    
    internal func parsePrimarySuperSuffix() throws -> PrimarySuperSuffix {
        return PrimarySuperSuffix(
            superKeyword: try self.expect(kind: .keyword, value: "super"),
            superSuffix: try self.parseAnySuperSuffix()
        )
    }
    
    internal func parsePrimaryVoidClass() throws -> PrimaryVoidClass {
        return PrimaryVoidClass(
            voidKeyword: try self.expect(kind: .keyword, value: "void"),
            period: try self.expect(kind: .punctuator, value: "."),
            classKeyword: try self.expect(kind: .keyword, value: "class")
        )
    }
    
    internal func parsePrimaryThisKeyword() throws -> PrimaryThisKeyword {
        return PrimaryThisKeyword(
            thisKeyword: try self.expect(kind: .keyword, value: "this")
        )
    }

    internal func parsePrimitiveType() throws -> PrimitiveType {
        return PrimitiveType(
            token: try self.expect(
                kind: .keyword,
                values: ["boolean", "char", "byte", "short", "int", "long", "float", "double"]
            )
        )
    }

    internal func parseQualifiedName() throws -> QualifiedName {
        return QualifiedName(
            identifiers: try self.oneOrMany(
                Parser.parseIdentifier,
                separator: Token(kind: .punctuator, value: ".")
            )
        )
    }

    internal func parseQueryDefinition() throws -> QueryDefinition {
        return QueryDefinition(
            queryKeyword: try self.expect(kind: .keyword, value: "query"),
            stringID: try self.parseAnyStringID(),
            queryOptions: try self.parseQueryOptions(),
            conditionalOrs: self.zeroOrMany(Parser.parseConditionalOr),
            endKeyword: try self.expect(kind: .keyword, value: "end")
        )
    }

    internal func parseQueryOptions() throws -> QueryOptions {
        return QueryOptions(
            queryOptionsPrefix: try self.parseAnyQueryOptionsPrefix(),
            annotations: self.zeroOrMany(Parser.parseAnnotation)
        )
    }

    internal func parseAnyQueryOptionsPrefix() throws -> AnyQueryOptionsPrefix {
        return AnyQueryOptionsPrefix(
            queryOptionsPrefix: try self.maybe(Parser.parseParameters)
                ?? self.parsePlaceholders()
        )
    }

    internal func parseRealLiteral() throws -> RealLiteral {
        return RealLiteral(
            token: try self.expect(kind: .realLiteral)
        )
    }

    internal func parseRelationalExpression() throws -> RelationalExpression {
        return RelationalExpression(
            shiftExpression: try self.parseShiftExpression(),
            orRestrictions: self.zeroOrMany(Parser.parseOrRestriction)
        )
    }

    internal func parseAnyRelationalOperator() throws -> AnyRelationalOperator {
        return AnyRelationalOperator(
            relationalOperator: try self.maybe(Parser.parseRelationalOperatorToken)
                ?? self.parseRelationalOperatorExpression()
        )
    }

    internal func parseRelationalOperatorExpression() throws -> RelationalOperatorExpression {
        return RelationalOperatorExpression(
            notKeyword: self.maybe(kind: .keyword, value: "not"),
            identifier: try self.parseIdentifier(),
            bracketedExpressions: self.maybe(Parser.parseBracketedExpressions)
        )
    }

    internal func parseRelationalOperatorToken() throws -> RelationalOperatorToken {
        return RelationalOperatorToken(
            token: try self.expect(kind: .operator, values: ["<", ">", "<=", ">=", "==", "!="])
        )
    }

    internal func parseAnyRHSStatement() throws -> AnyRHSStatement {
        return AnyRHSStatement(
            rhsStatement: try self.maybe(Parser.parseModifyStatement)
                ?? self.parseStatement()
        )
    }

    internal func parseAnyRuleAttribute() throws -> AnyRuleAttribute {
        return AnyRuleAttribute(
            ruleAttribute: try self.maybe(Parser.parseConditionalExpressionRuleAttribute)
                ?? self.maybe(Parser.parseBooleanLiteralRuleAttribute)
                ?? self.maybe(Parser.parseStringLiteralRuleAttribute)
                ?? self.maybe(Parser.parseTimerRuleAttribute)
                ?? self.parseCalendarsRuleAttribute()
        )
    }

    internal func parseRuleAttributes() throws -> RuleAttributes {
        return RuleAttributes(
            ruleAttributesPrefix: self.maybe(Parser.parseRuleAttributesPrefix),
            ruleAttributesSuffix: self.maybe(Parser.parseRuleAttributesSuffix)
        )
    }

    internal func parseRuleAttributesPrefix() throws -> RuleAttributesPrefix {
        return RuleAttributesPrefix(
            attributesKeyword: try self.expect(kind: .keyword, value: "attributes"),
            colon: self.maybe(kind: .punctuator, value: ":")
        )
    }

    internal func parseRuleAttributesSuffix() throws -> RuleAttributesSuffix {
        return RuleAttributesSuffix(
            ruleAttributesSuffixSegments: self.zeroOrMany(Parser.parseRuleAttributesSuffixSegment)
        )
    }

    internal func parseRuleAttributesSuffixSegment() throws -> RuleAttributesSuffixSegment {
        return RuleAttributesSuffixSegment(
            ruleAttribute: try self.parseAnyRuleAttribute(),
            comma: self.maybe(kind: .punctuator, value: ",")
        )
    }

    internal func parseRuleDefinition() throws -> RuleDefinition {
        return RuleDefinition(
            ruleKeyword: try self.expect(kind: .keyword, value: "rule"),
            stringID: try self.parseAnyStringID(),
            ruleOptions: try self.parseRuleOptions(),
            whenPart: self.maybe(Parser.parseWhenPart),
            thenPart: try self.parseThenPart()
        )
    }

    internal func parseRuleOptions() throws -> RuleOptions {
        return RuleOptions(
            extendsClause: try self.parseExtendsClause(),
            annotations: self.zeroOrMany(Parser.parseAnnotation),
            ruleAttributes: try self.parseRuleAttributes()
        )
    }

    internal func parseAnySelector() throws -> AnySelector {
        return AnySelector(
            selector: try self.maybe(Parser.parseSuperSelector)
                ?? self.maybe(Parser.parseNewSelector)
                ?? self.maybe(Parser.parseIdentifierSelector)
                ?? self.parseBracketedExpression()
        )
    }

    internal func parseShiftExpression() throws -> ShiftExpression {
        return ShiftExpression(
            additiveExpression: try self.parseAdditiveExpression(),
            shiftExpressionRHS: self.maybe(Parser.parseShiftExpressionRHS)
        )
    }

    internal func parseShiftExpressionRHS() throws -> ShiftExpressionRHS {
        return ShiftExpressionRHS(
            operator: try self.expect(kind: .operator, values: ["<<", ">>", ">>>"]),
            additiveExpression: try self.parseAdditiveExpression(),
            shiftExpressionRHS: self.maybe(Parser.parseShiftExpressionRHS)
        )
    }
    
    internal func parseSimpleType() throws -> SimpleType {
        return SimpleType(
            primitiveType: try self.parsePrimitiveType(),
            bracketPairs: self.zeroOrMany(Parser.parseBracketPair)
        )
    }
    
    internal func parseSingleRelationalRestriction() throws -> SingleRelationalRestriction {
        return SingleRelationalRestriction(
            relationalOperator: try self.parseAnyRelationalOperator(),
            shiftExpression: try self.parseShiftExpression()
        )
    }

    internal func parseAnySingleRestriction() throws -> AnySingleRestriction {
        return AnySingleRestriction(
            singleRestriction: try self.maybe(Parser.parseSingleRelationalRestriction)
                ?? self.parseParenthesizedOrRestriction()
        )
    }

    internal func parseSourcePattern() throws -> SourcePattern {
        return SourcePattern(
            pattern: try self.parsePattern(),
            overClause: self.maybe(Parser.parseOverClause),
            sourcePatternFromPart: self.maybe(Parser.parseSourcePatternFromPart)
        )
    }

    internal func parseSourcePatternFromPart() throws -> SourcePatternFromPart {
        return SourcePatternFromPart(
            fromKeyword: try self.expect(kind: .keyword, value: "from"),
            sourcePatternFromPartSuffix: try self.parseAnySourcePatternFromPartSuffix()
        )
    }

    internal func parseAnySourcePatternFromPartSuffix() throws -> AnySourcePatternFromPartSuffix {
        return AnySourcePatternFromPartSuffix(
            sourcePatternFromPartSuffix: try self.maybe(Parser.parseConditionalOrExpression)
                ?? self.maybe(Parser.parseCollectBindingClause)
                ?? self.maybe(Parser.parseEntryPointClause)
                ?? self.parseAccumulateClause()
        )
    }
    
    internal func parseStatement() throws -> Statement {
        // BUG: This isn't elaborated on in the parse diagrams.
        return Statement()
    }

    internal func parseAnyStringID() throws -> AnyStringID {
        return AnyStringID(
            stringID: try self.maybe(Parser.parseIdentifier)
                ?? self.parseStringLiteral()
        )
    }
    
    internal func parseStringLiteral() throws -> StringLiteral {
        return StringLiteral(
            token: try self.expect(kind: .stringLiteral)
        )
    }
    
    internal func parseStringLiteralRuleAttribute() throws -> StringLiteralRuleAttribute {
        return StringLiteralRuleAttribute(
            keyword: try self.expect(
                kind: .keyword,
                values: [
                    "agenda-group",
                    "activation-group",
                    "date-effective",
                    "date-expires",
                    "dialect",
                    "ruleflow-group"
                ]
            ),
            stringLiteral: try self.parseStringLiteral()
        )
    }
    
    internal func parseSuperSelector() throws -> SuperSelector {
        return SuperSelector(
            period: try self.expect(kind: .punctuator, value: "."),
            superKeyword: try self.expect(kind: .keyword, value: "super"),
            superSuffix: try self.parseAnySuperSuffix()
        )
    }

    internal func parseAnySuperSuffix() throws -> AnySuperSuffix {
        return AnySuperSuffix(
            superSuffix: try self.maybe(Parser.parseArguments)
                ?? self.parseIdentifierSuperSuffix()
        )
    }

    internal func parseThenPart() throws -> ThenPart {
        return ThenPart(
            thenKeyword: try self.expect(kind: .keyword, value: "then"),
            rhsStatements: self.zeroOrMany(Parser.parseAnyRHSStatement),
            endKeyword: try self.expect(kind: .keyword, value: "end")
        )
    }
    
    internal func parseTimerRuleAttribute() throws -> TimerRuleAttribute {
        return TimerRuleAttribute(
            timerKeyword: try self.expect(kind: .keyword, value: "timer"),
            leftParenthesis: try self.expect(kind: .punctuator, value: "("),
            tokens: try self.parseTokens(),
            rightParenthesis: try self.expect(kind: .punctuator, value: ")")
        )
    }
    
    internal func parseTokens() throws -> Tokens {
        // BUG: This isn't elaborated on in the parse diagrams.
        return Tokens()
    }

    internal func parseAnyType() throws -> AnyType {
        return AnyType(
            type: try self.maybe(Parser.parseSimpleType)
                ?? self.parseComplexType()
        )
    }

    internal func parseAnyTypeArgument() throws -> AnyTypeArgument {
        return AnyTypeArgument(
            typeArgument: try self.maybe(Parser.parseAnyType)?.type
                ?? self.parseInheritanceTypeArgument()
        )
    }

    internal func parseTypeArguments() throws -> TypeArguments {
        return TypeArguments(
            leftAngle: try self.expect(kind: .operator, value: "<"),
            typeArguments: try self.oneOrMany(Parser.parseAnyTypeArgument),
            rightAngle: try self.expect(kind: .operator, value: ">")
        )
    }

    internal func parseTypeDefinition() throws -> TypeDefinition {
        return TypeDefinition(
            declareKeyword: try self.expect(kind: .keyword, value: "declare"),
            qualifiedName: try self.parseQualifiedName(),
            typeOptions: try self.parseTypeOptions(),
            fields: self.zeroOrMany(Parser.parseField),
            endKeyword: try self.expect(kind: .keyword, value: "end")
        )
    }

    internal func parseTypeOptions() throws -> TypeOptions {
        return TypeOptions(
            typeOptionsExtension: self.maybe(Parser.parseTypeOptionsExtension),
            annotations: self.zeroOrMany(Parser.parseAnnotation)
        )
    }
    
    internal func parseTypeOptionsExtension() throws -> TypeOptionsExtension {
        return TypeOptionsExtension(
            extendsKeyword: try self.expect(kind: .keyword, value: "extends"),
            qualifiedName: try self.parseQualifiedName()
        )
    }

    internal func parseAnyUnaryExpression() throws -> AnyUnaryExpression {
        return AnyUnaryExpression(
            unaryExpression: try self.maybe(Parser.parseUnaryExpressionPlusMinus)
                ?? self.maybe(Parser.parseUnaryExpressionIncrementDecrement)
                ?? self.maybe(Parser.parseUnaryExpressionNegation)
                ?? self.maybe(Parser.parseUnaryExpressionCast)
                ?? self.parseUnaryExpressionPrimary()
        )
    }

    internal func parseUnaryExpressionCast() throws -> UnaryExpressionCast {
        return UnaryExpressionCast(
            leftParenthesis: try self.expect(kind: .punctuator, value: "("),
            unaryExpressionCastType: try self.parseAnyUnaryExpressionCastType(),
            rightParenthesis: try self.expect(kind: .punctuator, value: ")"),
            unaryExpression: try self.parseAnyUnaryExpression()
        )
    }

    internal func parseAnyUnaryExpressionCastType() throws -> AnyUnaryExpressionCastType {
        return AnyUnaryExpressionCastType(
            unaryExpressionCastType: try self.maybe(Parser.parsePrimitiveType)
                ?? self.parseAnyType().type
        )
    }

    internal func parseUnaryExpressionIncrementDecrement() throws -> UnaryExpressionIncrementDecrement {
        return UnaryExpressionIncrementDecrement(
            operator: try self.expect(kind: .operator, values: ["++", "--"]),
            primary: try self.parseAnyPrimary()
        )
    }

    internal func parseUnaryExpressionNegation() throws -> UnaryExpressionNegation {
        return UnaryExpressionNegation(
            operator: try self.expect(kind: .operator, values: ["~", "!"]),
            unaryExpression: try self.parseAnyUnaryExpression()
        )
    }

    internal func parseUnaryExpressionPlusMinus() throws -> UnaryExpressionPlusMinus {
        return UnaryExpressionPlusMinus(
            operator: try self.expect(kind: .operator, values: ["+", "-"]),
            unaryExpression: try self.parseAnyUnaryExpression()
        )
    }

    internal func parseUnaryExpressionPrimary() throws -> UnaryExpressionPrimary {
        return UnaryExpressionPrimary(
            unaryExpressionPrimaryAssignment: self.maybe(Parser.parseUnaryExpressionPrimaryAssignment),
            primary: try self.parseAnyPrimary(),
            incrementOrDecrementOperator: self.maybe(kind: .operator, values: ["++", "--"])
        )
    }

    internal func parseUnaryExpressionPrimaryAssignment() throws -> UnaryExpressionPrimaryAssignment {
        return UnaryExpressionPrimaryAssignment(
            identifier: try self.parseIdentifier(),
            // BUG: Does not implement := operator.
            operator: try self.expect(kind: .punctuator, value: ":")
        )
    }

    internal func parseAnyValue() throws -> AnyValue {
        return AnyValue(
            value: try self.maybe(Parser.parseValueArray)
                ?? self.parseConditionalExpression()
        )
    }

    internal func parseValueArray() throws -> ValueArray {
        return ValueArray(
            leftBrace: try self.expect(kind: .punctuator, value: "{"),
            values: try self.zeroOrMany(
                Parser.parseAnyValue,
                separator: Token(kind: .punctuator, value: ",")
            ),
            rightBrace: try self.expect(kind: .punctuator, value: "}")
        )
    }

    internal func parseAnyVariableInitializer() throws -> AnyVariableInitializer {
        return AnyVariableInitializer(
            variableInitializer: try self.maybe(Parser.parseArrayInitializer)
                ?? self.parseExpression()
        )
    }

    internal func parseWhenPart() throws -> WhenPart {
        return WhenPart(
            whenKeyword: try self.expect(kind: .keyword, value: "when"),
            colon: self.maybe(kind: .punctuator, value: ":"),
            conditionalOrs: self.zeroOrMany(Parser.parseConditionalOr)
        )
    }

    internal func oneOrMany<T>(_ callback: (Parser) -> () throws -> T) throws -> [T] {
        return try self.oneOrMany(callback, separator: nil)
    }

    internal func oneOrMany<T>(_ callback: (Parser) -> () throws -> T, separator: Token?) throws -> [T] {
        let array = [try callback(self)()]
        // BUG: This allows for a trailing separator in the case of exactly one element.
        if let sep = separator {
            let _ = try self.expect(token: sep)
        }
        return try array + self.zeroOrMany(callback, separator: separator)
    }

    internal func zeroOrMany<T>(_ callback: (Parser) -> () throws -> T) -> [T] {
        return try! self.zeroOrMany(callback, separator: nil)
    }

    internal func zeroOrMany<T>(_ callback: (Parser) -> () throws -> T, separator: Token?) throws -> [T] {
        var array: [T] = []
        if let first = self.maybe(callback) {
            array.append(first)
        }
        if let sep = separator {
            while let _ = self.maybe(token: sep) {
                array.append(try callback(self)())
            }
        }
        else {
            while let next = self.maybe(callback) {
                array.append(next)
            }
        }
        return array
    }

    internal func maybe(token: Token) -> Token? {
        return self.maybe(kind: token.kind, value: token.value)
    }
    
    internal func maybe(kind: Token.Kind) -> Token? {
        return self.maybe(kind: kind, values: [])
    }

    internal func maybe(kind: Token.Kind, value: String) -> Token? {
        return self.maybe(kind: kind, values: [value])
    }
    
    internal func maybe(kind: Token.Kind, values: [String]) -> Token? {
        do {
            return try self.expect(kind: kind, values: values)
        }
        catch {
            return nil
        }
    }

    internal func maybe<T>(_ callback: (Parser) -> () throws -> T?) -> T? {
        do {
            return try callback(self)()
        }
        catch {
            return nil
        }
    }

    internal func expect(token: Token) throws -> Token {
        return try self.expect(kind: token.kind, value: token.value)
    }
    
    internal func expect(kind: Token.Kind) throws -> Token {
        return try self.expect(kind: kind, values: [])
    }

    internal func expect(kind: Token.Kind, value: String) throws -> Token {
        return try self.expect(kind: kind, values: [value])
    }
    
    internal func expect(kind: Token.Kind, values: [String] = []) throws -> Token {
        guard let peek = self.reader.peek() else {
            throw Error.unexpected(actual: nil)
        }
        guard peek.kind == kind else {
            throw Error.unexpected(actual: peek)
        }
        if !values.isEmpty {
            guard values.contains(peek.value) else {
                let token = Token(kind: kind, value: values.first!)
                throw Error.unexpected(actual: peek, expected: token)
            }
        }
        return self.reader.next()!
    }
}
