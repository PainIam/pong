# -----------------------------
# Makefile for Pong Project (Linux)
# -----------------------------

# Compiler
CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra -O2

# SFML & system libraries
SFML_LIBS = -lsfml-graphics -lsfml-window -lsfml-system \
            -lX11 -lXrandr -lXi -lXxf86vm -lXcursor -lGL -ldl -lpthread

# Source files
SRCS = main.cpp bat.cpp ball.cpp
OBJS = $(SRCS:.cpp=.o)
TARGET = pong

# Default target
all: $(TARGET)

# Link object files
$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $^ $(SFML_LIBS)

# Compile .cpp → .o
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Clean compiled files
clean:
	rm -f $(OBJS) $(TARGET)

# Rebuild everything
rebuild: clean all

.PHONY: all clean rebuild

