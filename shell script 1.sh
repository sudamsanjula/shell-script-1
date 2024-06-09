#!/bin/bash
#Name: Sudam Sanjula pullaperuma

#The bash script I designed serves the purpose of analyzing candidate password files iteratively. The script employs a structured approach, utilizing read for user input and nested loops for file validation, ensuring the file's existence and non-emptiness. It calculates the maximum line length by iterating through the lines, employing 'grep with regular expressions for extracting allowed and disallowed characters. The 'printf' statement is used for formatted and color-coded output, enhancing readability. User interaction is incorporated, prompting whether to process another file, adding a layer of usability. The script effectively combines core Bash commands, loop structures, and formatting techniques, showcasing a comprehensive use of fundamental concepts in shell scripting.
#this is to start an infinite loop until expression broken.
while true; do 
    #prompt user for a file name, and the input is stored in the variable 
    #(read -p) is used to remove the extra need for the echo statement.
    read -p "Enter the name of the candidate password file (including ext): " filename

    #used a nested loop to check if the specified file exists and is not empty.
    while [ ! -s "$filename" ]; do
        #If not, it shows user that file does not exist or is empty
        echo "The file does not exist or is empty"
        #It prompts the user again to enter a valid file name.
        read -p "Enter the name of the candidate password file (including ext): " filename
    done

#It reads each line from the file specified by the user and calculates the maximum line length.
max_length=0

#is to create an aloop that reads each line from the file specified by $filename.
# The IFS= ensures leading and trailing whitespaces are preserved
# -r prevents backslashes from being treated as escape characters.
while IFS= read -r line; do
    #Calculates the length of the current line and stores it in the variable
    current_length=${#line}
    #Checks if the current_length is greater than the max_length discovered so far
    if [ "$current_length" -gt "$max_length" ]; then
        #If the current line is longer than the previously recorded maximum, it updates max_length with the length of the current line
        max_length="$current_length"
        #by the end of this loop, max_length will hold the length of the longest line in the file. This information is then used for formatting the output later in the script.
    fi
done < "$filename"

while IFS= read -r line; do
    #Calculates the total number of characters in the current line and stores it in the variable
    total_chars=${#line}
    #grep is used to find and extract characters that match the specified pattern 
    #The -o option makes grep output only the matched characters
    #The result is then passed through tr -d '\n' to remove any newline characters
    allowed_chars=$(grep -o '[aeiou13579*#!._-]' <<< "$line" | tr -d '\n')
    disallowed_chars=$(grep -o '[^aeiou13579*#!._-]' <<< "$line" | tr -d '\n')

    #printf statement creates a visually informative,and color-coded output for each line, displaying the line itself, total characters, allowed characters, and disallowed characters.
    #\033[34m: This sets the text color to blue. It uses ANSI escape codes, where \033 is the escape character, and 34 is the code for blue.
    #\033[0m: This resets the text color and other text attributes to their default values.
    #[T: %d]: This prints the total number of characters (total_chars) in the format [T: %d]
    #[A: \033[32m%s\033[0m (%d)]: This prints the allowed characters in green color (\033[32m).
    #[D: \033[31m%s\033[0m (%d)]: This prints the disallowed characters in red color (\033[31m)
    #\n: This adds a newline character at the end to move to the next line.
    printf "\033[34m%-*s\033[0m %-10s [T: %d] [A: \033[32m%s\033[0m (%d)] [D: \033[31m%s\033[0m (%d)]\n" "$max_length" "$line" "" "$total_chars" "$allowed_chars" "${#allowed_chars}" "$disallowed_chars" "${#disallowed_chars}"
done < "$filename"

#now it gives tht output same as the screenshot provided in assignment
#When the user enters a file name that does not exist or is empty, the program prompts them to re-enter. but when the user enters a file that exists, the program runs based on that file name. What if the user needs to run another file? program does not support that part. In my opinion, it was a little issue.
#So using the knowledge I have gained so far, I add a part that asks the user whether he needs to do more operations or not. If yes, the program continues to run as before.
    
    #-p option is used to specify a prompt to be displayed before reading the input
    #it's asking the user whether they want to process another file and providing the options (yes/no).
    #This is the variable that will store the user's input. The user's response (either "yes" or "no") will be stored in the variable $choice
    read -p "Do you want to process another file? (yes/no): " choice
    #case statement(week-3),if the user enters "yes" or "y", the script may continue to the next iteration of the loop (processing another file). If the user enters anything else, the script may break out of the loop, potentially ending the script.
    case "$choice" in
        [Yy]|[Yy][Ee][Ss]) continue ;;
        *) break ;;
    esac
done
