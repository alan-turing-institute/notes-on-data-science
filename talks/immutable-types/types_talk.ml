(* Pay no attention to the man behind the curtain *)

let is_zero = ((=) 0) ;;

(** I ----------------------------------------------------------

    A philosophy of programming:
    
    1. To program is to describe a computation.
    2. To compute is to calculate the value of a function.
    3. Functions turn inputs into outputs.

    For example: the "square" program:

    ( 3 ) ----[ square ]---> ( 9 )

    
    
    
 *)


(** II ---------------------------------------------------------

    Values are the things that are inputs to, and outputs from,
    functions.

    Every value is a value of some type. Most languages come with some
    "built-in" types and some way of writing values of those types.

    - [3] is a value of type [int]
    - [true] and [false] are the only values of type [bool]
    - ["hello"] is a value of type [string]

    Values can be given names, using the special syntax, let
    
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

    [solve_advent_of_code : string -> string] <-- We want to create this!
        
 *)


(** IV ---------------------------------------------------------

    Program 1
    
    To "program" all we need to do is to combine the built-in
    functions to make new functions.

    ...

 *)


(** V ----------------------------------------------------------

    Making new types. 

    - Types that are isomorphic to (but not identical to!) an existing
    type

    - Product types

    - Sum types
    
 *)

type port = Port of int

