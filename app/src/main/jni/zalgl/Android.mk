LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_C_INCLUDES += $(LOCAL_PATH)/../lua
LOCAL_MODULE     := zalgl
LOCAL_SRC_FILES  := zalgl.c

LOCAL_STATIC_LIBRARIES := luajava

include $(BUILD_SHARED_LIBRARY)
