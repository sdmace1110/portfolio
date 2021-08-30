# Project 2
# Shawn Mace
# CSCI 3210-01
# Due: April 10, 2019
# In this project we use R to create a program that read from a file
# contain student numbers and grades per assignment type.  We prompt 
# twice to recover individual records, then automatically print the entire
# roster along with roster average per assignment and max scores.

# Gets working directory
dir <- getwd()
# Sets working directory
setwd(dir)

# Create class template
# Student is name of class
Student <- setClass("Student",
		# Slot are class attributes declared by representation function 
      	representation(
      	# Hold C-Number
    		cNum = "character",
      	# Holds CLA scores
    		CLA = "numeric",
   		  # Holds OLA scores
   		  OLA = "numeric",
   		  # Holds quiz scores
    		quiz = "numeric",
     		# Holds exam scores
    		exam = "numeric",
    		# Holds final exam scores
      	final = "numeric",
      	# Holds total points collected for avg
      	totalPoints = "numeric",
      	# Holds letter grade
      	letterGrade = "character"
	 	)
)

# Sets the grading guideline to file in "letterGrade"
# total is combined grades 
assignLetterGrades <- function(total){
	  	if (total >= 90) {
    			"A"
  		} else if (total >= 87 && total < 90) {
    			"B+"
  		} else if (total >= 83 && total < 87) {
    			"B"
		} else if (total >= 80 && total < 83) {
    			"B-"
  		} else if (total >= 77 && total < 80) {
    			"C+"
  		} else if (total >= 73 && total < 77) {
    			"C"
		} else if (total >= 70 && total < 73) {
    			"C-"
  		} else if (total >= 67 && total < 70) {
    			"D+"
  		} else if (total >= 63 && total < 67) {
    			"D"
		} else if (total >= 60 && x < 63) {
    			"D-"
  		} else {
			"F"
		}
}

# Prints an individual students records
printStudent <- function(student){
			# Cat is used to print the class slots
			# @ is the accessor to the class slots
			cat("cNumber:  ",student@cNum,"  ",
				"CLA: ",student@CLA,"  ",
				"OLA: ",student@OLA,"  ",
				"Quizzes: ",student@quiz,"  ",
				"Exams: ",student@exam,"  ",
				"Final Exam: ",student@final,"  ",
				"Grade:  ",student@letterGrade,"\n\n"
			)
}

# Function to print the average scores by assignment type
printAvg <- function(studentsList){
			
			# Initialize variables 
			initCLA <- 0
			initOLA <- 0
			initQuiz <- 0
			initExam <- 0
			initFinal <- 0

			# For loop to sum each student's individual score
			# into the initialized variable
			for (student in studentsList){
				initCLA <- initCLA + student@CLA
				initOLA <- initOLA + student@OLA
				initQuiz <- initQuiz + student@quiz
				initExam <- initExam + student@exam
				initFinal <- initFinal + student@final
			}

			# Creates an "average" variables and stores the avg
			avgCLA <- initCLA / length(studentsList)
			avgOLA <- initOLA / length(studentsList)
			avgQuiz <- initQuiz / length(studentsList)
			avgExam <- initExam / length(studentsList)
			avgFinal <- initFinal / length(studentsList)
	
			# Print the average of each assignment type
			cat("\nAverage scores for each assignment type are:\n",
				"CLA: ",avgCLA,"  ",
				"OLA: ",avgOLA,"  ",
				"Quizzes: ",avgQuiz,"  ",
				"Exams: ",avgExam,"  ",
				"Final Exam: ",avgFinal,"\n"
			)
}

# Function to print all 
printAll <- function(studentsList){
  			for (student in studentsList){
    				cat("cNumber:  ",student@cNum,"  ",
        			"CLA: ",student@CLA,"  ",
        			"OLA: ",student@OLA,"  ",
        			"Quizzes: ",student@quiz,"  ",
        			"Exams: ",student@exam,"  ",
       			"Final Exam: ",student@final,"  ",
        			"Grade:  ",student@letterGrade,"\n"
    				)
 			}
}

printMax <- function(studentsList){
				# initialize max scores to 0
				maxCLA <- 0
				maxOLA <- 0
				maxQuiz <- 0
				maxExam <- 0
				maxFinal <- 0
								
				# If statements to test is current is max
				for (student in studentsList){
					if (student@CLA > maxCLA){
						maxCLA <- student@CLA
					}
					if (student@OLA > maxOLA){
						maxOLA <- student@OLA
					}
					if (student@quiz > maxQuiz){
						maxQuiz <- student@quiz
					}
					if (student@exam > maxExam){
						maxExam <- student@exam	
					}
					if (student@final > maxFinal){
						maxFinal <- student@final
					}
				}
				# Prints max of each score base
				cat("\nMax scores in each assignment type are:\n",
						"CLA: ",maxCLA,"  ",
						"OLA: ",maxOLA,"  ",
						"Quizzes: ",maxQuiz,"  ",
						"Exams: ",maxExam,"  ",
						"Final Exam: ",maxFinal,"\n\n"
					)
			}

# Constructs main driving function
driver <- function(){

	# Puts the file into a variable
  # readLine reads from a prompt
	readFile = readline("Input file: ")

	# Reads the input variable line by line
	inFile <- file(readFile,open="r")
	# readLines reads from a file saving each line into "lines"
	lines = readLines(inFile)
	
	# Create roster to hold student classes
	roster <- list()
	
	# Read line by line from files, ignore the header line
	for (i in 2:length(lines)){
		# Use string split function to split each line into indidual elements
		temp <- strsplit(lines[i]," ")
		# Automate class creating by using the temp and classVars 
		# as.[type] maintains type integrity by creating an S3 class
		# polymorphing into S4 on read
		classCNum <- temp[[1]][1]
		classCLA <- as.integer(temp[[1]][2])
		classOLA <- as.integer(temp[[1]][3])
		classQuiz <- as.integer(temp[[1]][4])
		classExam <- as.integer(temp[[1]][5])
		classFinal <- as.integer(temp[[1]][6])
		# Creates a class total by summing all the grades
		classTotal <- classCLA + classOLA + classQuiz + classExam + classFinal
		# Creates a variable to hold function result when calling grades 
		# and inserts it into the new class
		classLetterGrade <- assignLetterGrades(classTotal)

		# create new student object
		newStudent <- new("Student", 
						cNum = classCNum, 
						CLA = classCLA, 
						OLA = classOLA, quiz= classQuiz,
						exam = classExam, 
						final = classFinal, 	
						totalPoints = classTotal,
						letterGrade = classLetterGrade
					)
		
		# Place the newly created class into the roster list
		roster[classCNum] <- newStudent
	}
	
	# Gets user input to specify a student to view
	firstSearch = readline("Input the C-Number of student you wish to examine: ")
	# Print the student at that location
	printStudent(roster[[firstSearch]])

	# Gets user input for a second time to select the next student to view
	secondSearch = readline("Input the C-Number of student you wish to examine: ")
	# Print the student at that location
	printStudent(roster[[secondSearch]])
	
	# Call to print all records in roster
	printAll(roster)

	# Call to print average 
	printAvg(roster)
	
	# Call to print maximum 
	printMax(roster)
	
	# Closes the opened file
	close(inFile)
}
driver()