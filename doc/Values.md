# Values

Values are the built-in atomic object types that all other objects are composed of. They can be created through literals, expressions that evaluate to a value. All values are immutable—once created, they do not change. The number 3 is always the number 3. The string "frozen" can never have its character array modified in place.

# Nil

Nil is a special native value type and represents nothing. It is also equal to the boolean literal false, but distinct in that it represents a lack of value.

# Booleans

A boolean value represents truth or falsehood. There are two boolean literals, true and false. These are a native value type.

# Numbers

Like other scripting languages, Wren has a single numeric type: double-precision floating point. Number literals look like you expect coming from other languages:

```Wren
    0
    1234
    -5678
    3.14159
    1.0
    -12.34
    0.0314159e02
    0.0314159e+02
    314.159e-02
    0xcaffe2
```

Numbers are also part of the native value types set.

# Strings

A string is an array of bytes. Typically, they store characters encoded in UTF-8, but you can put any byte values in there, even zero or invalid UTF-8 sequences. (You might have some trouble printing the latter to your terminal, though.)

String literals are surrounded in double quotes:

```Wren
    "hi there"
```

They can also span multiple lines. When they do, the newline character within the string will always be \n (\r\n is normalized to \n).

```Wren
    "hi
    there,
    again"
```

## Escaping

A handful of escape characters are supported:

```Wren
    "\0" // The NUL byte: 0.
    "\"" // A double quote character.
    "\\" // A backslash.
    "\%" // A percent sign.
    "\a" // Alarm beep. (Who uses this?)
    "\b" // Backspace.
    "\e" // ESC character.
    "\f" // Formfeed.
    "\n" // Newline.
    "\r" // Carriage return.
    "\t" // Tab.
    "\v" // Vertical tab.

    "\x48"        // Unencoded byte     (2 hex digits)
    "\u0041"      // Unicode code point (4 hex digits)
    "\U0001F64A"  // Unicode code point (8 hex digits)
```

A \x followed by two hex digits specifies a single unencoded byte:

```Wren
    System.print("\x48\x69\x2e") //> Hi.
```

A \u followed by four hex digits can be used to specify a Unicode code point:

```Wren
    System.print("\u0041\u0b83\u00DE") //> AஃÞ
```

A capital \U followed by eight hex digits allows Unicode code points outside of the basic multilingual plane, like all-important emoji:

```Wren
    System.print("\U0001F64A\U0001F680") //> 🙊🚀
```

## Interpolation

String literals also allow interpolation. If you have a percent sign (%) followed by a parenthesized expression, the expression is evaluated. The resulting object’s toString method is called and the result is inserted in the string:

```Wren
    System.print("Math %(3 + 4 * 5) is fun!") //> Math 23 is fun!
```

Arbitrarily complex expressions are allowed inside the parentheses, even crossing lines. Lines crossed inside the expression do not add additional newlines to the resultant string.

```
    System.print("
        Your color is: '%(
            if (this.color == Red) : 'Red'
            ; else if (this.color == Blue) : 'Blue' 
            ;
        )' !
    ")
```

An interpolated expression does not support nesting, so **you may not put a string with interpolation inside a interpolation expression**.

## Raw Strings

A string literal can also be created using triple quotes """ which is parsed as a raw string. A raw string is no different from any other string, it’s just parsed in a different way.

Raw strings do not process escapes and do not apply any interpolation.

```Wren
    """hi there"""
```

When a raw string spans multiple lines and a triple quote is on it’s own line, any whitespace on that line will be ignored. This means the opening and closing lines are not counted as part of the string when the triple quotes are separate lines, as long as they only contain whitespace (spaces + tabs).

```Wren
  """
    Hello world
  """
```

The resulting value in the string above has no newlines or trailing whitespace. Note the spaces in front of the Hello are preserved.

    Hello world

A raw string will be parsed exactly as is in the file, unmodified. This means it can contain quotes, invalid syntax, other data formats and so on without being modified by Wren.

```Wren
"""
  {
    "hello": "wren",
    "from" : "json"
  }
"""
```

# Native Value Types

Booleans, Nil, Numbers, and Strings are native value types. This means they are not a class object, so they do not derive from Object. Type testing still works on them however, like with all Object derived classes. So you can do syntax magic like:

```
    if (3 is Number) : 
        return true ;

    if (Object.type(someVariable) is Number) :
        return true ;
```

The parser respects the native type names Boolean, Nil, Number, and String for these uses.

# Ranges

A range is a little object that represents a consecutive range of numbers. They don’t have their own dedicated literal syntax. Instead, the number class implements the .. and ... operators to create them:

```Wren
    3..8
```

This creates a range from three to eight, including eight itself. If you want a half-inclusive range, use ...:

```Wren
    4...6
```

This creates a range from four to six not including six itself. Ranges are commonly used for iterating over a sequences of numbers, but are useful in other places too. You can pass them to a list‘s subscript operator to return a subset of the list, for example, or on a String, the substring in that range:

```Wren
    var list = ["a", "b", "c", "d", "e"]
    var slice = list[1..3]
    System.print(slice) //> [b, c, d]

    var string = "hello wren"
    var wren = string[-4..-1]
    System.print(wren) //> wren
```

Ranges are not a native value type, or class objects. They are syntax sugar that become an iterator that iterates over the given sequence of numbers in the context of how they are used. TODO: explain with example pseudo-code.