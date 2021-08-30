; Description: Write 6 functions in Scheme using the IDE Racket
; to better understand how lists are used, maintained and
; manipulate in a Scheme like evironment.

#lang racket

; Defines Area function : one argument, int
(define (area r)
	; Area is Pi * r * r
	(* 3.14 r r))



; Define Power function : two arguments, int 
(define (power A B)
	; If B = 0, the result is 1 *base case*
	(cond ((= B 0) 1)
		; If B > 0, multiply A by recursive call to 
		; Power that's 1 less B than previous until the
		; base case is met
        ((> B 0) (* A (power A (- B 1)
		)))
			; If B < 0, divide A by recursive call to 
			; Power that's 1 more B than previous until the
			; base case is met			  
			((< B 0) (/ A (power A (+ B 1))
			))))	



; Defines countZero function : one argument, list
(define (countZero list)
  ; Checks if list is empty 
  (cond ((null? list) 0)
        ; Checks if the current item (head) is 0
        ((= (car list) 0)
			; Increments the counter and calls recursive function 
			; (list inclusive at second element)
			(+ 1 (countZero (cdr list))))
				; If the current item is not 0
				(else
					; Check next element without incrementing
					(countZero (cdr list))
	)))
					




; Define Reverse function : one argument, empty list
(define (reverse list (acc null) )
	; Checks if the list is empty 
	(if (empty? list)
		; Return acc as empty or intialized in next step
		acc
		; Recursive call ( list exluding first element)
		; That first element is constructed into list
		(reverse (cdr list) (cons (car list)
			; The list holder for the above cons car list
			; command, placing the first in the back and the 
			; back as the first
			acc))
	))

; Defines Palindrom function : one argument, list
(define (palindrome list)
	; Using let to act as an helper-function to initialize a list
	; to process in input list into a reference list (half)
	(let helper ((orig list) (aux list) (test '()))
			; Test conditions: Checks if aux is null 
			(cond ((null? aux)       
				; Checks if test and orig are equal
				(equal? test orig))
					; Checks if the next characters in aux are null
					((null? (cdr aux)) 
						; Checks if test and the rest of orig are equal
						(equal? test (cdr orig)))
							; recursive call ( rest of list from second character )
							; performing the checks until base case or inqualities happen							
							(else (helper (cdr orig) (cddr aux)
								; Constructs test, placing an element in front of the next in a list
								(cons (car orig) test)
			)))))
                 






(define (merge firstNameList lastNameList)
	
; Conditional : Check is either list is empty, return empty list 
 (cond ((or (empty? firstNameList)
             (empty? lastNameList)) empty)
	; If not an empty list, construct a pair to a list
	; using the first element in each list
        (else (cons (list (car firstNameList)
                     (car lastNameList))
		     ;After the list of pairs is construct, recursive call using (second 
		     ; element of list1, second element of list2) until base case is met
                     (merge (cdr firstNameList)(cdr lastNameList))))
        ))

