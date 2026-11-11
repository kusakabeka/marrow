let () =
    let open Marrow_frontend.Ast in


    let expression =
        Ast.BinOp (
            Add,
            Int 10,
            BinOp (Mul, int 2, Int 3)
        )
    in
    print_endline
      (Marrow_frontend.Ast_printer.string_of_expr expression)
