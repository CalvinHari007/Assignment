/* The Solution contains 2 source code files and one junit testing module */

1. Main.java - Reads input (Object and Key), calls the parser module with data
   and prints the output
   Example Input to provide in SYSINPUT
    Line1 -     {"a":{"x":{"y":{"z":"d"}}}}
    Line 2 -    a/x/y/z

2. ObjectParser.java - Builds and Store nested Object.
    a. constructor method will build the nested Object and Create an array of Keys
    b. valueReturner method will parse the nested object for value corresponding to 
    the key provided
3. TestNesting.java - Junit test modules that will execute some sample test cases.
