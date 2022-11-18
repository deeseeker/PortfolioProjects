# TODO 1: Create a letter using starting_letter.txt
# TODO 2: Read all the invite names
# TODO 3: Replace the [name] placeholder with the actual name.
# TODO 4:  Save the letters in the folder "ReadyToSend".



PLACEHOLDER = "[name]"

with open('input/Names/invited_names.txt') as file:
    invites = file.read().split()

with open('input/Letters/starting_letter.txt') as file:
    letter = file.read()
    for invite in invites:
        new_letter = letter.replace(PLACEHOLDER, invite)
        with open(f"output/ReadyToSend/{invite}.txt", "w") as file:
                file.write(new_letter)
