# Go tools dependencies
GO_TOOLS := ./protoc-gen-gql

GOPATH := $(shell go env GOPATH)

.PHONY: all
all: tools generate-proto

.PHONY: tools
tools: install-protoc go-tools

define LIST_RULE
.PHONY: install-$(notdir $(l))
install-$(notdir $(l)):
	go install $(l)
endef

$(foreach l, $(GO_TOOLS), $(eval $(call LIST_RULE, $(l) )))

.PHONY: go-tools
go-tools: $(foreach l, ${GO_TOOLS}, install-$(notdir $(l)))

.PHONY: clean
clean:
	$(foreach l, ${GO_TOOLS},rm -f ${GOPATH}/bin/$(notdir $(l)))

.PHONY: generate-proto
generate-proto:
	export PATH="$$PATH:$(GOPATH)/bin" && protoc -I ./api/sin392/protobuf -I ./api  --go_out=paths=source_relative:./pkg/graphqlpb ./api/sin392/protobuf/graphql.proto

.PHONY: install-protoc
install-protoc:
	./scripts/install-protoc.sh
