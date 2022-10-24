#SRC_PATH := $(shell pwd)
SRC_PATH := .
T_PATH = $(PWD)

#编译器
#CC = arm-linux-gnueabihf-gcc
CC = gcc
G++ = g++

#编译参数更多错误 -Werror
CFLAGS := -Wall -Werror -lstdc++

#编译参数内存问题打印 -fsanitize=address -g
CFLAGS += -fsanitize=address -g 

#忽略[-Wunused-variable]的警告 -Wno-unused-variable
#忽略[-Wunused-function]的警告 -Wno-unused-function
CFLAGS += -Wno-unused-function -Wno-unused-variable

#给代码中宏_DUAN_MSC_VER定义为1 -D_DUAN_MSC_VER=1    
CFLAGS += -D_DUAN_MSC_VER=1 

#make LFDUG=root
ifeq ($(LFDUG),root)
CFLAGS += -DTEST
else ifeq ($(LFDUG),one)
CFLAGS += -DTEST=1
else ifeq ($(LFDUG),two)
CFLAGS += -DTEST=2
endif

#make lf_type=3
ifneq ($(lf_type),)
CFLAGS += -D_LF_DEV_TYPE=$(lf_type)
endif

#加动态库
CFLAGS += -lpthread

#我写的动态库
#SHARE := -L$(SRC_PATH)/pthread
SHARE := -L$(SRC_PATH)
#CFLAGS += -lpthread_func

#静态库
LIBS := $(SRC_PATH)/libs/*.a

#目标文件
OUTPUT= $(SRC_PATH)/a.out

#头文件路径
INCLUDE := -I$(SRC_PATH)/
INCLUDE += -I$(SRC_PATH)/c_test
INCLUDE += -I$(SRC_PATH)/cpp_test

#源文件
SMP_SRCS := $(wildcard $(SRC_PATH)/c_test/*.c)

SMP_SRCScpp := $(wildcard $(SRC_PATH)/*.cpp)
SMP_SRCScpp += $(wildcard $(SRC_PATH)/cpp_test/*.cpp)

#替换为.o文件
TARGET := $(SMP_SRCS:%.c=%.o)
TARGETcpp := $(SMP_SRCScpp:%.cpp=%.o)

a.out:
$(OUTPUT):$(TARGETcpp) $(TARGET)
	$(G++) $(SHARE) $(TARGETcpp) $(TARGET) $(CFLAGS) -o $(OUTPUT)

$(TARGETcpp):%.o:%.cpp
	$(G++) -c $< $(CFLAGS) -o $@ $(INCLUDE) 
$(TARGET):%.o:%.c
	$(CC) -c $< $(CFLAGS) -o $@ $(INCLUDE) 

.PHONY:clean
clean:
	@-rm -f $(TARGET)
	@-rm -f $(OUTPUT)
	@-rm -f $(TARGETcpp)

echo:
	@echo $(CC)
	@echo $(SRC_PATH)
	@echo $(T_PATH)
	@echo $(INCLUDE)
	@echo $(CFLAGS)
	@echo $(SMP_SRCS)
	@echo $(TARGET)
	@echo $(TARGETcpp)
	@echo $(OUTPUT)
	@echo $(SMP_SRCScpp)