longest_string = ''
counter = 0

for i in range(len(s)):
    current_string = s[i]
    index = 1
    try:
        while s[i + index] >= s[i + index - 1]:
            current_string += s[i + index]
            index += 1
    except IndexError:
        current_string = current_string
    if len(current_string) > len(longest_string):
            longest_string = current_string

print("Longest substring in alphabetical order is: ", longest_string)
