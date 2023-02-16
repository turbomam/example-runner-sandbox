## Add your own custom Makefile targets here

RUN = poetry run
.PHONY: combined-extras examples-clean

examples-clean:
	@echo running examples-clean
	rm -rf runnable_examples/output

combined-extras: examples-clean runnable_examples/output

runnable_examples/output: src/example_runner_sandbox/schema/example_runner_sandbox.yaml
	@echo making runnable_examples/output
	mkdir -p $@
	$(RUN) linkml-run-examples \
		--counter-example-input-directory runnable_examples/invalid_examples \
		--input-directory runnable_examples/valid_examples \
		--output-directory $@ \
		--schema $< > $@/README.md
