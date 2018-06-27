#
# Makefile for Go
# CREDIT: https://github.com/machine-drivers/
#

# Go and compilation related variables
# NOTE: Ideally I would place the build artifacts within a `build` dir, but build conflicts with the `build` command.
BUILD_DIR ?= out

# TODO: figure out way to make this work locally and globally.
ORG := github.com/ipatch
REPOPATH ?= $(ORG)/docker-machine-driver-qemu

vendor:
	dep ensure -v

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)
	rm -rf vendor

.PHONY: build
build: $(BUILD_DIR) vendor
	go build \
			-installsuffix "static" \
			-o $(BUILD_DIR)/docker-machine-driver-qemu
	chmod +x $(BUILD_DIR)/docker-machine-driver-qemu

install: $(BUILD_DIR) vendor
	sudo mv $(BUILD_DIR)/docker-machine-driver-qemu /usr/local/bin/ && sudo chown root:wheel /usr/local/bin/docker-machine-driver-qemu && sudo chmod u+s /usr/local/bin/docker-machine-driver-qemu

default: build 



# ----------------------------------------------------------------------------
# ifeq ($V, 1)
# 	VERBOSE =
# 	GO_VERBOSE = -v -x
# else
# 	VERBOSE = @
# 	GO_VERBOSE =
# endif

# ----------------------------------------------------------------------------
# Include makefiles
# -include mk/build.mk
# -include mk/coverage.mk
# -include mk/dev.mk
# -include mk/main.mk
# -include mk/test.mk
# -include mk/validate.mk


# ----------------------------------------------------------------------------
#  Package settings

# # Build package information
# GITHUB_USER := ipatch
# TOP_PACKAGE_DIR := github.com/${GITHUB_USER}
# PACKAGE := $(shell basename $(PWD))
# OUTPUT := bin/docker-machine-driver-qemu

# MAIN_FILE := $(shell grep "func main\(\)" *.go -l)


# ----------------------------------------------------------------------------
# Define main commands

# CC := $(shell xcrun -f clang)
# LIBTOOL := $(shell xcrun -f libtool)
# GO_CMD := $(shell which go)
# GIT_CMD := $(shell which git)
# DOCKER_CMD := $(shell which docker)

# ----------------------------------------------------------------------------
# Define sub commmands

# GO_BUILD = ${GO_CMD} build $(GO_VERBOSE) $(GO_BUILD_FLAG) -o ${OUTPUT}

# GO_INSTALL = ${GO_CMD} install $(GO_BUILD_TAGS)

# GO_RUN = ${GO_CMD} run

# GO_TEST = ${GO_CMD} test ${GO_VERBOSE}
# GO_TEST_RUN = ${GO_TEST} -run ${RUN}
# GO_TEST_ALL = test -race -cover -bench=.
# GO_VET = ${GO_CMD} vet
# GO_LINT = golint

# GO_DEPS=${GO_CMD} get -d
# GO_DEPS_UPDATE=${GO_CMD} get -d -u
# # Check godep binary
# GODEP = ${GOPATH}/bin/godep
# GODEP_CMD = $(if ${GODEP}, , $(error Please install godep: go get github.com/tools/godep)) ${GODEP}


# ----------------------------------------------------------------------------
# Define build flags

# Initialize
# CGO_CFLAGS :=
# CGO_LDFLAGS :=

# # Parse git current branch commit-hash
# GO_LDFLAGS ?= -X `go list ./qemu`.GitCommit=`git rev-parse --short HEAD 2>/dev/null`

# GO_BUILD_FLAG += -tags='$(GO_BUILD_TAGS)'

# # ----------------------------------------------------------------------------
# # Go environment variables

# export CGO_ENABLED=1

# ----------------------------------------------------------------------------
# Build jobs settings

# default: build

# build: bin/docker-machine-driver-qemu



# bin/docker-machine-driver-qemu:
# 	$(VERBOSE) test -d bin || mkdir -p bin;
# 	@echo "${CBLUE}==>${CRESET} Build ${CGREEN}${PACKAGE}${CRESET}..."
# 	$(VERBOSE) $(ENV) CGO_CFLAGS="$(CGO_CFLAGS)" CGO_LDFLAGS="$(CGO_LDFLAGS)" $(GO_BUILD) -gcflags "$(GO_GCFLAGS)" -ldflags "$(GO_LDFLAGS)" ${TOP_PACKAGE_DIR}/${PACKAGE}

# run: driver-run

# rm: driver-remove

# # Plain make targets if not requested inside a container
# ifneq (,$(findstring test-integration,$(MAKECMDGOALS)))
# 	include Makefile.inc
# 	include mk/main.mk
# else ifneq ($(USE_CONTAINER), true)
# 	include Makefile.inc
# 	include mk/main.mk
# else
# # Otherwise, with docker, swallow all targets and forward into a container
# DOCKER_BUILD_DONE := ""

# test: .DEFAULT

# .DEFAULT:
# 	@test ! -z "$(DOCKER_BUILD_DONE)" || ./script/build_in_container.sh $(MAKECMDGOALS)
# 	$(eval DOCKER_BUILD_DONE := "done")

# endif


# # # Project name, used to name the binaries
# # PKG_NAME := docker-machine-driver-qemu


# # # If true, "build" will produce a static binary (cross compile always produce static build regardless)
# # STATIC ?=
# # # If true, turn on verbose output for build
# # VERBOSE ?=
# # # Build tags
# # BUILDTAGS ?=
# # # Adjust number of parallel builds (XXX not used)
# # PARALLEL ?= -1
# # # Coverage default directory
# # COVERAGE_DIR ?= cover
# # # Whether to perform targets inside a docker container, or natively on the host
# # USE_CONTAINER ?=

# # # List of cross compilation targets
# # ifeq ($(TARGET_OS),)
# #   TARGET_OS := darwin linux windows
# # endif

# # ifeq ($(TARGET_ARCH),)
# #   TARGET_ARCH := amd64 arm arm64 386
# # endif

# # # Output prefix, defaults to local directory if not specified
# # ifeq ($(PREFIX),)
# #   PREFIX := $(shell pwd)
# # endif
