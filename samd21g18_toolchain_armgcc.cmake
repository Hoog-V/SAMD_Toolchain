set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)
if(${CMAKE_VERSION} VERSION_LESS "3.16.0")
    message(WARNING "Current CMake version is ${CMAKE_VERSION}. This toolchain requires CMake 3.16 or greater")

endif()

set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")


set(CMAKE_OBJCOPY arm-none-eabi-objcopy)
set(CMAKE_OBJDUMP arm-none-eabi-objdump)
set(SIZE arm-none-eabi-size)
set(MCPU cortex-m0plus)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

add_definitions(-D__SAMD21G18A__
                -mcpu=${MCPU}
                -fno-common 
                -g3 
                -gdwarf-4 
                -Wall 
                -fmessage-length=0 
                -fno-builtin 
                -ffunction-sections 
                -fno-strict-aliasing
                -fdata-sections 
                -fmerge-constants
                -mapcs)

set(LINKER_SCRIPT ${CMAKE_CURRENT_LIST_DIR}/linker_script.ld)
add_link_options(-T ${LINKER_SCRIPT}
                -mthumb
                -mthumb-interwork
                -mcpu=${MCPU}
                -specs=nano.specs 
                -Wl,--gc-sections
                -Wl,--print-memory-usage
                -lm
                -Wl,-Map=${PROJECT_BINARY_DIR}/${PROJECT_NAME}.map)

include_directories("${CMAKE_CURRENT_LIST_DIR}/cmsis-header-sam/samd21a/gcc/"
					"${CMAKE_CURRENT_LIST_DIR}/CMSIS_5/CMSIS/Core/Include/"
					"${CMAKE_CURRENT_LIST_DIR}/cmsis-header-sam/samd21a/include")


set(STARTUP_SCRIPT_SOURCES "${CMAKE_CURRENT_LIST_DIR}/gcc/system_samd21.c" "${CMAKE_CURRENT_LIST_DIR}/gcc/startup_samd21.c")

