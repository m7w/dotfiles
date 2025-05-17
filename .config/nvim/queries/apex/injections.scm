(variable_declarator
  name: (identifier) @_name (#match? @_name "^query")
  (string_literal) @soql (#offset! @soql 0 1 0 -1)
  )

(variable_declarator
  name: (identifier) @name (#match? @name "^query")
  (binary_expression 
    left: (#set! node left)
    right: (#set! node right)) @soql (#offset! @soql 0 1 0 -1)
  )

(variable_declarator
  name: (identifier) @_name (#match? @_name "^query")
  (array_creation_expression
    (array_initializer
      (string_literal) @soql (#offset! @soql 0 1 0 -1)
      )
    )
  )
