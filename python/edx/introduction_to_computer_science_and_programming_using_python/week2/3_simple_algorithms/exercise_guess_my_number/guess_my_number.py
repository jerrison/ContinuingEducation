from math import floor

low = 0
high = 100
guess = 50
entry = ''

print("Please think of a number between 0 and 100!")

while True:
    print("Is your secret number {}?".format(guess))

    entry = input("Enter 'h' to indicate the guess is too high. Enter 'l' to "
        "indicate the guess is too low. Enter 'c' to indicate I guessed "
        "correctly. ")

    if entry == 'l':
        low = floor((high + low) / 2)
    elif entry == 'h':
        high = floor((high + low) / 2)
    elif entry == 'c':
        break
    else:
        print("Sorry, I did not understand your input.")
        continue

    guess = floor((high + low) / 2)

print("Game over. Your secret number was: {}".format(guess))
