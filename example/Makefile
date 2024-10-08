.PHONY: gen-gql-%
gen-gql-%:
	protoc --gql_out=svc=true:. -I ../../../api -I . ./pb/$*.proto --experimental_allow_proto3_optional

.PHONY: clean-%
clean-%:
	rm -rf pb/$*.pb.go pb/$*.graphql
