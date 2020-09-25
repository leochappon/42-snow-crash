import sys

if len(sys.argv) > 1:
    string = ""
    for i, c in enumerate(sys.argv[1]):
        string += chr(ord(c) - i)

    print(string)