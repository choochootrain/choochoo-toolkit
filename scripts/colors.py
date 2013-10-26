print "16-color mode:"
for color in range(0, 16) :
  for i in range(0, 3) :
    print "\033[0;%sm%02s\033[m" % (str(color + 30), str(color)),
  print

# Programs like ls and vim use the first 16 colors of the 256-color palette.
print "256-color mode:"
for color in range(0, 256) :
  for i in range(0, 3) :
    print "\033[38;5;%sm%03s\033[m" % (str(color), str(color)),
  print
