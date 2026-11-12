(** Abstract syntax tree: expressions, operators, variable mutability. *)

(** Binary operation - operators that take two operands.

    Each [binop] value corresponds to one language operators and
    is applied to a pair of expression: [{e_1 op e_2}].
    All Binary operations are infix; precedence and associativity
    are specified during the parsing stage, not here - this representaion captures the already parsed tree.

    Operations groups:
    {2 Arithmetic}
    - {!Add} - addition: [e_1 + e_2], result type - numeric
    - {!Sub} - subtraction: [e_1 - e_2], result type - numeric
    - {!Mul} - multiplication: [e_1 * e_2], result type - numeric
    - {!Div} - division: [e_1 / e_2], result type - numeric
      Division by zero is undefiend at the AST level; the check pertains to runtime semantics/analysis.

    {2 Comprarison}
    Comprarison operation return a boolean type ([Bool])
    - {!Eq} - equality: [e_1 == e_2]
    - {!Neq} - inequality: [e_1 != e_2]
    - {!Lt} - less than: [e_1 < e_2]
    - {!Le} - less than or equal to: [e_1 <= e_2]
    - {!Gt} - greater than: [e_1 > e_2]
    - {!Ge} - greater than or equal to: [e_1 >= e_2]

    {2 Logic}
    Logical operations expect logical operands and return [Bool]
    - {!And} - conjunction: [e_1 && e_2]
    - {!Or} - disjunction: [e_1 || e_2]

    @see_AST_EXPR see [Ast.BinOp] - a tree node representing an operation.
 **)
type binop =
    | Add (** Addition of two numerical expressions: [e_1 + e_2] **)
    | Sub (** Subtraction: [e_1 - e_2] **)
    | Mul (** Multiplication: [e_1 * e_2] **)
    | Div (** Division: [e_1 / e_2] **)
    | Eq (** Equality: [e_1 == e_2], result - [Bool] **)
    | Neq (** Inequality: [e_1 != e_2], result - [Bool] **)
    | Lt (** Less than: [e_1 < e_2], result - [Bool] **)
    | Le (** Less than of equal to: [e_1 <= e_2], result - [Bool] **)
    | Gt (** Greater than: [e_1 > e_2], result - [Bool] **)
    | Ge (** Greater than or equal to: [e_1 >= e_2], result - [Bool] **)
    | And (** Logical AND: [e_1 && e_2], result - [Bool] **)
    | Or (** Logical OR: [e_1 || e_2], result - [Bool] **)

(** Unary operations are operators that take a single operand. **)

type unop =
  | Neg (** - {!Neq} - arithmetic negation: [-e]. **)
  | Not (** - {!Not} - logical negation: [!e] (or [not e]), result - [Bool] **)

type mutability =
    | Immutable
    | Mutable

type expr =
    | Int of int
    | Bool of bool
    | Var of string

    | BinOp of binop * expr * expr
    | UnOp of unop * expr

    | If of expr * expr * expr
    | Let of mutability * string * expr * expr

    | Lambda of string * expr
    | Apply of expr * expr

    | Block of expr list

type declaration =
    | ValueDecl of mutability * string * expr
    | FunctionDecl of string * string list * expr

type program = declaration list
