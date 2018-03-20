# Sample
print("------------------------------------------\n")
print("Sample Code Output: \n")
iteration = 0
count = 0
while iteration < 5:
    for letter in "hello, world":
        count += 1
    print("Iteration " + str(iteration) + "; count is: " + str(count))
    iteration += 1

print("------------------------------------------\n")
print("Test 1 Output: \n")
# Test 1 NO
for iteration in range(5):
    count = 0
    while True:
        for letter in "hello, world":
            count += 1
        print("Iteration " + str(iteration) + "; count is: " + str(count))

print("------------------------------------------\n")
print("Test 2 Output: \n")
# Test 2 NO
for iteration in range(5):
    count = 0
    while True:
        for letter in "hello, world":
            count += 1
        print("Iteration " + str(iteration) + "; count is: " + str(count))
        break

print("------------------------------------------\n")
print("Test 3 Output: \n")
# Test 3 YES
count = 0
phrase = "hello, world"
for iteration in range(5):
    index = 0
    while index < len(phrase):
        count += 1
        index += 1
        print("Iteration " + str(iteration) + "; count is: " + str(count))

print("------------------------------------------\n")
print("Test 4 Output: \n")
# Test 4    YES
count = 0
phrase = "hello, world"
for iteration in range(5):
    while True:
        count += len(phrase)
        break
    print("Iteration " + str(iteration) + "; count is: " + str(count))

print("------------------------------------------\n")
print("Test 5 Output: \n")
# Test 5    YES
count = 0
phrase = "hello, world"
for iteration in range(5):
    count += len(phrase)
    print("Iteration " + str(iteration) + "; count is: " + str(count))    