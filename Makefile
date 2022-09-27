#
# Shell2 lex/yacc Makefile
# Shawn Ostermann - Sept 27, 2022
#
CFLAGS = -Wall -Werror -O2
CC = gcc
CXX = g++

PROGRAM = bash
CFILES  = ${wildcard *.c}
CCFILES = ${wildcard *.cc}
HFILE = bash.h


##################################################
#
# You shouldn't need to change anything else
#
##################################################


# compute the OFILES
OFILES = ${CFILES:.c=.o} ${CCFILES:.cc=.o}

# all of the .o files that the program needs
OBJECTS = parser.tab.o lex.yy.o ${OFILES}


# How to make the whole program
${PROGRAM} : ${OBJECTS}
	${CXX} ${CFLAGS} ${OBJECTS} -o ${PROGRAM} 


# 
# Turn the parser.y file into parser.tab.c using "bison"
# 

parser.tab.c : parser.y ${HFILES}
	bison -dvt ${YFLAGS} parser.y
parser.tab.o: parser.tab.c
	${CC} ${CFLAGS} -c parser.tab.c
parser.tab.h: parser.tab.c


# 
#  Turn the scanner.l file into lex.yy.c using "lex"
# 
lex.yy.c : scanner.l parser.tab.h ${HFILE}
	flex ${LFLAGS} scanner.l
lex.yy.o: lex.yy.c
	${CC} ${CFLAGS} -Wno-unused-function -g -c lex.yy.c

#
# File dependencies
#
${OFILES}: ${HFILE} parser.tab.h

test: bash
	-chmod a+rx ./test.?
	-for TEST in ./test.?; do echo "$$TEST: "; $$TEST; done
	
clean: cleanbuild cleantest

cleantest:
	/bin/rm -f *.o lex.yy.c y.output parser.tab.c ${PROGRAM} parser.h parser.output *.tab.c *.tab.h core 

cleanbuild:
	/bin/rm -f test.*.myoutput test.*.correct test.*.input test.*.unixoutput tmp.* typescript
	/bin/rm -rf tmpdir.dir
	