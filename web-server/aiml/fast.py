import glob

f = open("some.txt","w")
for g in glob.glob("*.aiml"):
    f.write("<learn>standard/"+g+"</learn>\n")

f.close()

    
