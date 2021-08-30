-- Stack uses the framework of example (List) to impliment
-- stack functionalities for an empty stack (list).

class Stack inherits IO {

	-- Test boolean for an empty list
	isNil(): Bool { true };
	
	-- The head of an empty list
	head(): String { "" };
	
	-- The tail of an empty list
	tail(): Stack { self };
	
	-- Pushes the new input into the stack
	push(str: String): Stack {
		if (not str = "") then 
			(new Cons).init(str, self)
		else self
		fi
	};
	
	-- Removes the character from head of stack
	-- replaces any strings with empty string
	pop(): String { "" };
	
	-- Displays stack head
	peek(): Stack{
		self
	};
		
};


-- Use the Cons example to create/manipulate none empty stack/list
class Cons inherits Stack {

	car: String;
	cdr: Stack;
	
	-- Sets bool to false representing a non-empty stack
	isNil(): Bool { false };

	-- Assigns an input string as head of the list
	head(): String { car };

	-- Establishes the rest of a non-empty list
	tail(): Stack { cdr };
	
	-- List initializing functions that takes a string (head)
	-- and rest (tail) and returns self (a stack type)
	init(str: String, rest: Stack): Stack{
      {
		car <- str;
		cdr <- rest;
		self;
      }
	};
	
	-- Pulls the head node from the list
	pop(): String {
		-- set local variable to display head
		let head: String <- car in
		{
			-- Replaces CAR with head of CRD, return the rest to CDR
			-- and shows the head to match return type
			car <- cdr.head();
			cdr <- cdr.tail();
			head;
		}
	};
	
	-- to display a non-empty list
	display(): Stack {
      {
        
		-- if the head is not empty, print the head and concatenates a newline
		if (not car = "")
		then 
			out_string(car.concat("\n"))
		else 
			false
		fi;
		-- if head is empty, tests the first character in tail for an input presence
		cdr.peek();
		self;
       }
	};
};

-- Menu driver from each input
class Menu inherits IO {
	-- boolean, when true, takes an input
	-- when false, closes the program
	active: Bool <- true;
	
	-- function to pass bool setting to input stream
	isActive(): Bool {
		active
	};
	
	-- The menu selector 
	menu(str: String) : Menu {
		{
			if str = "d" then 
				(new D)
			else if str = "e" then 
				(new E)
			else if str = "x" then 
				(new X)
			else 
				(new Push)
			fi fi fi;
			
		}
	};
	
	-- Allows menu access to the head of the stack to evaluate
	-- 
	stackLink(str: String, stack: Stack): Stack {
		stack
	};
 
-- insert A2I
  
   c2i(char : String) : Int {
	if char = "0" then 0 else
	if char = "1" then 1 else
	if char = "2" then 2 else
    if char = "3" then 3 else
    if char = "4" then 4 else
    if char = "5" then 5 else
    if char = "6" then 6 else
    if char = "7" then 7 else
    if char = "8" then 8 else
    if char = "9" then 9 else
		{ abort(); 0; }  -- the 0 is needed to satisfy the typchecker
    fi fi fi fi fi fi fi fi fi fi
     };

    i2c(i : Int) : String {
	if i = 0 then "0" else
	if i = 1 then "1" else
	if i = 2 then "2" else
	if i = 3 then "3" else
	if i = 4 then "4" else
	if i = 5 then "5" else
	if i = 6 then "6" else
	if i = 7 then "7" else
	if i = 8 then "8" else
	if i = 9 then "9" else
	{ abort(); ""; }  -- the "" is needed to satisfy the typchecker
        fi fi fi fi fi fi fi fi fi fi
     };

     a2i(s : String) : Int {
        if s.length() = 0 then 0 else
	if s.substr(0,1) = "-" then ~a2i_aux(s.substr(1,s.length()-1)) else
        if s.substr(0,1) = "+" then a2i_aux(s.substr(1,s.length()-1)) else
           a2i_aux(s)
        fi fi fi
     };

     a2i_aux(s : String) : Int {
	(let int : Int <- 0 in	
           {	
               (let j : Int <- s.length() in
	          (let i : Int <- 0 in
		    while i < j loop
			{
			    int <- int * 10 + c2i(s.substr(i,1));
			    i <- i + 1;
			}
		    pool
		  )
	       );
              int;
	    }
        )
     };

    i2a(i : Int) : String {
	if i = 0 then "0" else 
        if 0 < i then i2a_aux(i) else
          "-".concat(i2a_aux(i * ~1)) 
        fi fi
    };
	
    i2a_aux(i : Int) : String {
        if i = 0 then "" else 
	    (let next : Int <- i / 10 in
		i2a_aux(next).concat(i2c(i - next * 10))
	    )
        fi
    };
};
-- End atoi insert

-- If "d" is input, this will loo at the stack head
class D inherits Menu {
	stackLink(str: String, stack: Stack): Stack{
		stack.peek()
	};
};

class E inherits Menu {
	stackLink(str: String, stack: Stack): Stack{
		-- defines local variables to allow addition and head manipulation
		let head: String, add1: String, add2: String in
		{
			-- Pop head
			head <- stack.pop();
			
			-- Test for "+"
			if head = "+" then
				-- If yes, use A2I and perform addition
				{
          		add1 <- stack.pop();
				add2 <- stack.pop();
				stack.push(i2a(a2i(add1) + a2i(add2)));
			}
                  else 
				-- If not "+", push the element back onto the stack
				stack.push(head)
			fi;
		}
	};
	
};

class X inherits Menu {
  stackLink(str: String, stack: Stack): Stack{
  	{
		-- sets active bool to false to exit program
		active <- false;
		-- for type checking
	stack;
  	}
   };
};
 
-- the default process when the command line input is not "d","x","e", or "+"
class Push inherits Menu{
	-- The default position on the menu.  If "x", "d", or "e"
	-- is not displayed, the input is pushed on the stack
	stackLink(str: String, stack: Stack): Stack{
		stack.push(str)
	};
};

class Main inherits IO {
	-- create variables to assign input character
	-- holds the menu option that best corresponds with the input
	command: Menu <- new Menu;
	
	current: Menu <- new Menu;
	stack: Stack <- new Stack;
	str: String;
	
	main(): Object {
		-- will ask for input until bool is false
		while current.isActive() loop
		{
			out_string(">");
			-- in stream character is passed into variable
			str <- in_string();
			-- selects a menu option, determines which process to run
			current <- command.menu(str);
			-- passes the result of the menu examination to the stack
			stack <- current.stackLink(str, stack);
		}
		pool
			
		};
	
	};
	
