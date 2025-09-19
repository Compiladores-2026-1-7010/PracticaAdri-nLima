CXX = g++
FLEX = flex++
LEX_FILE = lexer.ll
SRC_DIR = .
BIN_DIR = .

SOURCES = main.cpp Lexer.cpp
TARGET = compiler

all: $(TARGET)

$(TARGET): lex.yy.cc main.cpp
    $(CXX) -o $(TARGET) main.cpp lex.yy.cc

lex.yy.cc: $(LEX_FILE)
 $(FLEX) $(LEX_FILE)

clean:
 rm -f lex.yy.cc $(BIN_DIR)/$(TARGET) *.o

.PHONY: all clean