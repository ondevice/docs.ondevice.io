
snippets: snippets/help/

snippets/help/: $(wildcard snippets/help/*.txt)

snippets/help/_.txt: phony
	$(MAKE) _snippet ARGS='help' OUTPUT="$@"

snippets/help/%.txt: phony
	$(MAKE) _snippet ARGS='help $*' OUTPUT="$@"

_snippet:
	@mkdir -p snippets/help/
	echo '$$ ondevice $(ARGS)' > "$(OUTPUT)"
	ondevice $(ARGS) >> "$(OUTPUT)" 2>&1

phony:
.PHONY: phony
