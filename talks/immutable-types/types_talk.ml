(* Pay no attention to the man behind the curtain *)

let is_zero = ((=) 0) ;;

(** I ----------------------------------------------------------

    A philosophy of programming:
    
    1. To program is to describe a computation.
    
    2. To compute is to calculate the value of a function.

    3. Functions turn inputs into outputs.

 *)


(** II ---------------------------------------------------------

    Values are the things that are inputs to, and outputs from,
    functions.

    Every value is a value of some type. Most languages come with some
    "built-in" types and some way of writing values of those types.

    - [3] is a value of type [int]
    - [true] and [false] are the only values of type [bool]
    - ["hello"] is a value of type [string]

 *)


(** III --------------------------------------------------------
    
    Languages also come with built-in functions that operate on those
    built-in types.

    Every function takes exactly one input and produces exactly one
    output. 
    
    [succ : int -> int] 
    [pred : int -> int]
    [is_zero : int -> bool]
    [string_of_int : int -> string]
        
 *)


(** IV ---------------------------------------------------------

    To "program" all we need to do is to combine the built-in
    functions to make new functions.

    ...

 *)

let is_nonzero n =
  not (is_zero n)

let add2 n =
  succ (succ n)




