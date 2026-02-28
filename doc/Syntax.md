# Syntax

The Syntax of howl is very much taken wholesale from [Wren](https://wren.io/), with changes meant for source code clarity. howl source code lives in files with the **.hw** extension, and by nature is very Class centered. howl source code is transpiled into either Luajit (Lua 5.1) or Javascipt, and hosts that run those code types execute it. I'd like to eventually also build a transpiler to C++, but that would be down the road a ways.

# Comments

Comments are identical to C. Line comments begin with a double forward slash: //

```c
    // This is a comment
    This is not
```

Block comments begin with a forward slash asterisk combo: /* and continue until a closing inverse */ is found. **Unlike Wren, they may not be nested.**

```c
    /* This is a multi-line comment
    continued */
```

# Reserved Words

These words are all action keyword for control, operation, and so on. Here is the list, with a couple changes from Wren: null is **nil**; we add both **const** and **from**; and remove **foreign**.

* **as** **break** **class** **const** **construct** **continue** **else** **false** **for** **if** **import** **in** **is** **nil** **return** **static** **super** **this** **true** **var** **while**

# Identifiers

Naming rules are similar to other programming languages. Identifiers start with a letter or underscore and may contain letters, digits, and underscores. Case is sensitive.

```
    hi
    camelCase
    PascalCase
    _under_score
    abc123
    ALL_CAPS
```
Identifiers that begin with an underscore _ are special, only appear inside class definitions and indicate a member field (local variable to the class instance object or static class object).

Capitalization is special and only used for classes in howl. **Variable identifiers may never begin with a capital letter.**

# Newlines

Newlines operate just as they do in Wren, in howl they separate statements:

```Wren
    // Two statements:
    System.print("hi") // Newline.
    System.print("bye")
```

A statement may cross one or more lines to complete as well:

```Wren
   System.print( // Newline here is ignored.
    "hi")
```

The inverse is not true, you may never place more than one statement on a line:

```Wren
    // Two statements on a line generate an error:
    System.print("hi") System.print("bye")
```

# Blocks

Unlike Wren, howl uses a colon to semi-colon bracket system for blocks. This separates them cleanly from curly braces **{}** used for Maps, and brackets **[]** used for Lists. Also unlike Wren, blocks are required when using any control/flow operations. Like here:

```
    if (happy && knowIt) :
        hands.clap()
    ; else : System.print("sad") ;
```

The code below is an error, as blocks are required. 

```
    if (happy && knowIt) :
        hands.clap()
    ; else System.print("sad")
```

All block delimiters demand whitespace on both sides of them, this code below will also generate an error:

```
    if (happy && knowIt):
        hands.clap()
    ; else: System.print("sad");
```

A single line block implicity returns the contained statements return value, without using the return operator:

```
    : obj.increment() ; // correct, returns the return value of this method call
    : return obj.increment() ; // incorrect, will generate an error
    :
        return obj.increment() // correct, will not generate an error
    ;
```

# Precendence and Associativity

TBD