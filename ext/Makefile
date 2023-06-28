.PHONY: all

all: make_exts

check_envs:
	@if [ -z "${uname_s}" ]; then echo "env var 'uname_s' is undefined"; exit 1; fi
	@if [ -z "${uname_m}" ]; then echo "env var 'uname_m' is undefined"; exit 1; fi
	@if [ -z "${TARGETDIR}" ]; then echo "env var 'TARGETDIR' is undefined"; exit 1; fi

make_exts: check_envs make_html2text
	echo "all done."

fset_html2text := $(TARGETDIR)/bin/html2text
make_html2text: $(fset_html2text)
$(fset_html2text):
	echo "making html2text"
	if [[ -e ./html2text.git-${uname_s}_${uname_m}.patch ]]; then \
	  patch -d html2text.git -N < ./html2text.git-${uname_s}_${uname_m}.patch; \
	fi; \
	cd ./html2text.git; \
	PREFIX=${TARGETDIR} ./configure && \
	$(MAKE) && \
	$(MAKE) install

