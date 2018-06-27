#
# Makefile for Go
# CREDIT: https://github.com/machine-drivers/docker-machine-driver-xhyve
#

# ----------------------------------------------------------------------------
# If true, disable optimizations and does NOT strip the binary
DEBUG ?=

# ----------------------------------------------------------------------------
# Include makefiles
-include mk/build.mk
-include mk/coverage.mk
-include mk/dev.mk
-include mk/main.mk
-include mk/test.mk
-include mk/validate.mk

# Plain make targets if not requested inside a container
ifneq (,$(findstring test-integration,$(MAKECMDGOALS)))
	include Makefile.inc
	include mk/main.mk
else ifneq ($(USE_CONTAINER), true)
	include Makefile.inc
	include mk/main.mk
else
# Otherwise, with docker, swallow all targets and forward into a container
DOCKER_BUILD_DONE := ""

test: .DEFAULT

.DEFAULT:
	@test ! -z "$(DOCKER_BUILD_DONE)" || ./script/build_in_container.sh $(MAKECMDGOALS)
	$(eval DOCKER_BUILD_DONE := "done")

endif


# # Project name, used to name the binaries
# PKG_NAME := docker-machine-driver-qemu


# # If true, "build" will produce a static binary (cross compile always produce static build regardless)
# STATIC ?=
# # If true, turn on verbose output for build
# VERBOSE ?=
# # Build tags
# BUILDTAGS ?=
# # Adjust number of parallel builds (XXX not used)
# PARALLEL ?= -1
# # Coverage default directory
# COVERAGE_DIR ?= cover
# # Whether to perform targets inside a docker container, or natively on the host
# USE_CONTAINER ?=

# # List of cross compilation targets
# ifeq ($(TARGET_OS),)
#   TARGET_OS := darwin linux windows
# endif

# ifeq ($(TARGET_ARCH),)
#   TARGET_ARCH := amd64 arm arm64 386
# endif

# # Output prefix, defaults to local directory if not specified
# ifeq ($(PREFIX),)
#   PREFIX := $(shell pwd)
# endif
