grammar Graphql;

document
    : definition+
    ;

definition
    : operationDefinition
    | fragmentDefinition
    ;

operationDefinition
    : selectionSet
    | operationType Name? variableDefinitions? directives? selectionSet
    ;

operationType
    : 'query'
    | 'mutation'
    ;

variableDefinitions
    : '(' variableDefinition+ ')'
    ;

variableDefinition
    : variable ':' type defaultValue?
    ;

variable
    : '$' Name
    ;

defaultValue
    : '=' value
    ;

selectionSet
    : '{' selection+ '}'
    ;

selection
    : field
    | fragmentSpread
    | inlineFragment
    ;

field
    : alias? Name arguments? directives? selectionSet?
    ;

alias
    : Name ':'
    ;

arguments
    : '(' argument+ ')'
    ;

argument
    : Name ':' value
    ;

fragmentSpread
    : '...' fragmentName directives?
    ;

inlineFragment
    : '...' 'on' typeCondition directives? selectionSet
    ;

fragmentDefinition
    : 'fragment' fragmentName 'on' typeCondition directives? selectionSet
    ;

fragmentName
    : Name
    ;

typeCondition
    : typeName
    ;

value
    : IntValue
    | FloatValue
    | StringValue
    | BooleanValue
    | NullValue
    | enumValue
    | arrayValue
    | objectValue
    | variable
    ;

enumValue
    : Name
    ;

arrayValue
    : '[' value* ']'
    ;

objectValue
    : '{' objectField* '}'
    ;

objectField
    : Name ':' value
    ;

directives
    : directive+
    ;

directive
    : '@' Name arguments?
    ;

type
    : typeName
    | listType
    | nonNullType
    ;

typeName
    : Name
    ;

listType
    : '[' type ']'
    ;

nonNullType
    : typeName '!'
    | listType '!'
    ;

BooleanValue
    : 'true'
    | 'false'
    ;

NullValue
    : Null
    ;

Null
    : 'null'
    ;

Name
    : [_A-Za-z][_0-9A-Za-z]*
    ;

IntValue
    : Sign? IntegerPart
    ;

FloatValue
    : Sign? IntegerPart ('.' Digit+)? ExponentPart?
    ;

Sign
    : '-'
    ;

IntegerPart
    : '0'
    | NonZeroDigit
    | NonZeroDigit Digit+
    ;

NonZeroDigit
    : '1'.. '9'
    ;

ExponentPart
    : ('e'|'E') Sign? Digit+
    ;

Digit
    : '0'..'9'
    ;

StringValue
    : DoubleQuote (~(["\\\n\r\u2028\u2029])|EscapedChar)* DoubleQuote
    ;

fragment EscapedChar
    :  '\\' (["\\/bfnrt] | Unicode)
    ;

fragment Unicode
   : 'u' Hex Hex Hex Hex
   ;

fragment DoubleQuote
   : '"'
   ;

fragment Hex
   : [0-9a-fA-F]
   ;

Ignored
   : (Whitespace|Comma|LineTerminator|Comment) -> skip
   ;

fragment Comment
   : '#' ~[\n\r\u2028\u2029]*
   ;

fragment LineTerminator
   : [\n\r\u2028\u2029]
   ;

fragment Whitespace
   : [\t\u000b\f\u0020\u00a0]
   ;

fragment Comma
   : ','
   ;