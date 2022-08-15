LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_C_INCLUDES += $(LOCAL_PATH)/../lua
LOCAL_MODULE     := lposix
LOCAL_SRC_FILES  := lposix.c
LOCAL_STATIC_LIBRARIES := luajava

include $(BUILD_SHARED_LIBRARY)
