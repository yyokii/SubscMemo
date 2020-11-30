PRODUCT_NAME := SubscMemo
SCHEME_NAME := ${PRODUCT_NAME}
PROJECT_NAME := ${PRODUCT_NAME}.xcodeproj
UI_TESTS_TARGET_NAME := ${PRODUCT_NAME}UITests

TEST_SDK := iphonesimulator
TEST_CONFIGURATION := Debug
TEST_PLATFORM := iOS Simulator
TEST_DEVICE ?= iPhone 11 Pro Max
TEST_OS ?= 13.4.1
TEST_DESTINATION := 'platform=${TEST_PLATFORM},name=${TEST_DEVICE},OS=${TEST_OS}'

.PHONY: start
start:
	make install
	make create-project
	make open

.PHONY: intall
install: install-mint install-gems
install-mint:
	sh Scripts/Mint/mint-install.sh 
install-gems:
	sh Scripts/Ruby/bundle-install.sh	

.PHONY: create-project
create-project:
	mint run yonaskolb/XcodeGen xcodegen generate
	sh Scripts/Cocoapods/pod-install.sh

.PHONY: open
open:
	open ./${PRODUCT_NAME}.xcworkspace

.PHONY: show-devices
show-devices:
	instruments -s devices

.PHONY: build-debug
build-debug:
	set -o pipefail && \
xcodebuild \
-sdk ${TEST_SDK} \
-configuration ${TEST_CONFIGURATION} \
-project ${PROJECT_NAME} \
-scheme ${SCHEME_NAME} \
build \
| xcpretty

.PHONY: test
test:
	set -o pipefail && \
xcodebuild \
-sdk ${TEST_SDK} \
-configuration ${TEST_CONFIGURATION} \
-project ${PROJECT_NAME} \
-scheme ${SCHEME_NAME} \
-destination ${TEST_DESTINATION} \
-skip-testing:${UI_TESTS_TARGET_NAME} \
clean test \
| xcpretty
