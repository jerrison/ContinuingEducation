index = 0
count = 0

while index < len(s) - 2:
    element = s[index: index + 3]
    if element == 'bob':
        count +=1
    index += 1

print(count)
