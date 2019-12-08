CC 		:= gcc

TARGET 		:=
TST_TARGET 	:= tst_runner

SRC_DIR 	:= src
INC_DIR		:= inc
BUILD_DIR 	:= obj
TARGET_DIR 	:= bin
LIB_DIR		:= lib
OBJ_EXT		:= o
SRC_EXT		:= c
DEP_EXT		:= d
TST_FMT		:= *_test*

CFLAGS 		:= -Wall -Wextra
DFLAGS		:= -MMD -MP
LIB 		:=
INC		:= -I$(INC_DIR) -I/usr/local/include
INC_DEP		:= -I$(INC_DIR)

# -------------------------------------------------------------------
# TRY NOT TO EDIT BELOW
# -------------------------------------------------------------------

SOURCES 	:= $(shell find $(SRC_DIR) -type f -name *.$(SRC_EXT) ! -iname "$(TST_FMT)")
OBJECTS 	:= $(patsubst $(SRC_DIR)/%, $(BUILD_DIR)/%, $(SOURCES:.$(SRC_EXT)=.$(OBJ_EXT)))

all: directories $(TARGET)

# -------------------------------------------------------------------

TST_SOURCES 	:= $(shell find $(SRC_DIR) -type f -name *.$(SRC_EXT) -iname "$(TST_FMT)")
TST_OBJECTS 	:= $(patsubst $(SRC_DIR)/%, $(BUILD_DIR)/%, $(TST_SOURCES:.$(SRC_EXT)=.$(OBJ_EXT)))

test: directories $(TST_TARGET)
	@echo "==============="
	@./$(TARGET_DIR)/$(TST_TARGET)

# -------------------------------------------------------------------

remake: clean all

# -------------------------------------------------------------------

directories:
	@mkdir -p $(TARGET_DIR) && echo "[OK] built $(TARGET_DIR)"
	@mkdir -p $(BUILD_DIR) && echo "[OK] built $(BUILD_DIR)"

# -------------------------------------------------------------------

clean:
	@rm -rf $(BUILD_DIR)/* && echo "[OK] cleaned $(BUILD_DIR)/"
	@rm -f $(TARGET_DIR)/* && echo "[OK] cleaned $(TARGET_DIR)/"

# -------------------------------------------------------------------

cleaner: clean
	@rm -rf $(BUILD_DIR) && echo "[OK] deleted $(BUILD_DIR)/"
	@rm -rf $(TARGET_DIR) && echo "[OK] deleted $(TARGET_DIR)/"

# -------------------------------------------------------------------

-include $(OBJECTS:.$(OBJ_EXT)=.$(DEP_EXT))

# -------------------------------------------------------------------

$(TARGET): $(OBJECTS)
	@$(CC) -o $(TARGET_DIR)/$@ $^ $(LIB) && echo "[OK] $@"

# -------------------------------------------------------------------

$(TST_TARGET): $(TST_OBJECTS)
	@$(CC) -o $(TARGET_DIR)/$@ $^ $(LIB) && echo "[OK] $@"

# -------------------------------------------------------------------

$(BUILD_DIR)/%.$(OBJ_EXT): $(SRC_DIR)/%.$(SRC_EXT)
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) $(DFLAGS) $(INC) -c -o $@ $< && echo "[OK] $@"

# -------------------------------------------------------------------

.PHONY: remake, clean, all, resources, directories, cleaner, test
