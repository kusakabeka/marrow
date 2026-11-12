let string_of_binop = function
    | Ast.Add -> "+"
    | Ast.Sub -> "-"
    | Ast.Mul -> "*"
    | Ast.Div -> "/"
    | Ast.Eq -> "=="
    | Ast.Neq -> "!="
    | Ast.Lt -> "<"
    | Ast.Le -> "<="
    | Ast.Gt -> ">"
    | Ast.Ge -> ">="
    | Ast.And -> "&&"
    | Ast.Or -> "||"


let string_of_unop = function
  | Ast.Neg -> "-"
  | Ast.Not -> "!"

let rec string_of_expr = function
    | Ast.Int n ->
        string_of_int n
    | Ast.Bool b ->
        string_of_bool b
    | Ast.Var name ->
        name
    | Ast.BinOp (op, left, right) ->
        "("
         ^ string_of_expr left
         ^ " " ^ string_of_binop op ^ " "
         ^ string_of_expr right
         ^ ")"
    | Ast.UnOp (op, expr) ->
            "(" ^ string_of_unop op ^ string_of_expr expr ^ ")"
    | Ast.If (condition, then_branch, else_branch) ->
            "(if "
            ^ string_of_expr condition
            ^ " then "
            ^ string_of_expr then_branch
            ^ " else "
            ^ string_of_expr else_branch
            ^ ")"
    | Ast.Let (mutability, name, value, body) ->
            let keyword =
                match mutability with
                | Ast.Immutable -> "let"
                | Ast.Mutable -> "var"
            in
            "(" ^ keyword ^ " " ^ name
            ^ " = " ^ string_of_expr value
            ^ " in " ^ string_of_expr body ^ ")"
    | Ast.Lambda (param, body) ->
            "(fun " ^ param ^ " -> " ^ string_of_expr body ^ ")"
    | Ast.Apply (fn, arg) ->
            "(" ^ string_of_expr fn ^ " " ^ string_of_expr arg ^ ")"
    | Ast.Block expressions ->
            "{ "
            ^ String.concat "; " (List.map string_of_expr expressions)
            ^ " }"

let string_of_declaration = function
    | Ast.ValueDecl (mutability, name, value) ->
            let keyword =
                match mutability with
                | Ast.Immutable -> "let"
                | Ast.Mutable -> "var"
            in
            keyword ^ " " ^ name ^ " = " ^ string_of_expr value
    | Ast.FunctionDecl (name, params, body) ->
            "fn " ^ name
            ^ " (" ^ String.concat ", " params ^ ") = "
            ^ string_of_expr body

let string_of_program program =
   String.concat "\n"
    (List.map string_of_declaration program)


