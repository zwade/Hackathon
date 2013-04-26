def createcrap(string):
	stri = ""
	for i in string:
		stri += chr(ord(i)+3)
	print("\"\".join([chr(ord(i)-3) for i in \"",stri,"\"])",sep="")

def main():
	from sys import argv
	crap = argv[1] or "hello"
	createcrap(argv[1])


main()
