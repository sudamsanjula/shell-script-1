I developed a shell script utilizing fundamental command-line utilities. The script prompts the user for the name of a file in their current working directory, ensuring robust error handling by verifying the existence and non-emptiness of the file. If the provided file does not meet these criteria, the user is informed of the issue and prompted again without script termination. Once a valid file is obtained, the script processes each string within it, parsing out allowed and disallowed characters according to predefined criteria. For each string, the script generates a report displaying the total count of characters as well as the counts of allowed and disallowed characters, providing a clear overview of the data's composition.

script processes a list of strings contained in an external text file, and for each string in the list, parses
out characters that are allowed characters from those characters that are disallowed, printing a report to the 
screen of total [T], allowed [A] and disallowed [D] characters found, and their counts.

Only the following characters are allowed:
• Lowercase vowels
• Odd numbers within the range 1–9
• The following subset of special characters:
*#!._-
All other characters are disallowed.

str1list, str2list and strlist3 are the text string files i used to test the shell script i wrote.

Through this task, I demonstrated proficiency in file handling, string manipulation, and error management within the constraints of the specified techniques and utilities.
