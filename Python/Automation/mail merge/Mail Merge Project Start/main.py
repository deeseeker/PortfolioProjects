# TODO 1: Create a letter using starting_letter.txt
# TODO 2: Read all the invite names
# TODO 3: Replace the [name] placeholder with the actual name.
# TODO 4:  Save the letters in the folder "ReadyToSend".

# Useful Resources:
# 1: This method will help you: https://www.w3schools.com/python/ref_file_readlines.asp
# 2: This method will also help you: https://www.w3schools.com/python/ref_string_replace.as
# 3: THis method will help you: https://www.w3schools.com/python/ref_string_strip.asp

with open('input/Names/invited_names.txt') as file:
    invites = file.read().split()
    print(invites)

with open('input/Letters/starting_letter.txt') as file:
    letter = file.readlines()
    print(letter)
    for invite in invites:
        print(invite)
        letter[0] = letter[0].replace(letter[0], f'Dear {invite}')
        print(letter)
        with open(f"output/ReadyToSend/{invite}.txt", "w") as file:
            for line in letter:
                file.write(line)
