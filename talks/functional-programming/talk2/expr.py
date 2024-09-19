
eg_string = "((1 + 2) * (3 - 4))"

eg_expr = ["Mul", ["Add", 1, 2], ["Sub", 3, 4]]

## An <expr> is:
##
## <expr> := <int>
##           Add <expr> <expr>
##           Sub <expr> <expr>
##           Mul <expr> <expr>
##           Div <expr> <expr>

## How do we represent this? Could use classes ... but a
## little overkill. What about we use a built-in datatype:
## the list.

def evalExpr(expr):
    match(expr):
        case int() as n        : return n
        case ["Add", arg1, arg2] : return evalExpr(arg1) + evalExpr(arg2)
        case ["Sub", arg1, arg2] : return evalExpr(arg1) - evalExpr(arg2)
        case ["Mul", arg1, arg2] : return evalExpr(arg1) * evalExpr(arg2)
        case ["Div", arg1, arg2] : return evalExpr(arg1) / evalExpr(arg2)
    raise RuntimeError("What!")


