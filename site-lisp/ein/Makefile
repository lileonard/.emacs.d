SRC=$(shell cask files)
PKBUILD=2.3
ELCFILES = $(SRC:.el=.elc)
ifeq ($(TRAVIS_PULL_REQUEST_SLUG),)
TRAVIS_PULL_REQUEST_SLUG := $(shell git config --global user.name)/$(shell basename `git rev-parse --show-toplevel`)
endif
ifeq ($(TRAVIS_PULL_REQUEST_BRANCH),)
TRAVIS_PULL_REQUEST_BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
endif
ifeq ($(TRAVIS_PULL_REQUEST_SHA),)
TRAVIS_PULL_REQUEST_SHA := $(shell if git show-ref --quiet --verify origin/$(TRAVIS_PULL_REQUEST_BRANCH) ; then git rev-parse origin/$(TRAVIS_PULL_REQUEST_BRANCH) ; fi))
endif

.DEFAULT_GOAL := test-compile

README.rst: README.in.rst
	cask eval "(progn \
	             (add-to-list 'load-path \"./lisp\") \
	             (load \"ein-notebook\") \
	             (describe-minor-mode \"ein:notebook-mode\") \
	             (with-current-buffer \"*Help*\" (princ (buffer-string))))" 2>/dev/null \
	| tools/readme-sed.sh "KEYS NOTEBOOK" README.in.rst > README.rst0
	cask eval "(progn \
	             (add-to-list 'load-path \"./lisp\") \
	             (load \"ein-connect\") \
	             (describe-minor-mode \"ein:connect-mode\") \
	             (with-current-buffer \"*Help*\" (princ (buffer-string))))" 2>/dev/null \
	| tools/readme-sed.sh "KEYS CONNECT" README.rst0 > README.rst
	rm README.rst0

.PHONY: autoloads
autoloads:
	emacs -Q --batch --eval "(package-initialize)" --eval "(package-generate-autoloads \"ein\" \"./lisp\")"

.PHONY: clean
clean:
	cask clean-elc
	rm -rf test/test-install

.PHONY: dist-clean
dist-clean: clean
	rm -rf dist


.PHONY: test-compile
test-compile: clean autoloads
#	TODO When we are ready to properly compile, replace the disaster here
#	with (setq byte-compile-error-on-warn t) --dickmao
	! ( cask build 2>&1 | awk '{if (/^ /) { gsub(/^ +/, " ", $$0); printf "%s", $$0 } else { printf "\n%s", $$0 }}' | egrep -a "not known|Error|free variable|error for|Use of gv-ref|multiple times|Unused|but requires" )
	cask clean-elc

.PHONY: quick
quick: test-compile test-unit

.PHONY: test-jupyterhub
test-jupyterhub:
# jupyterhub slightly temperamental with json-readtable-error
# seems to be affecting ob-ipython too but probably my bug.. just need to find it
	-cask exec ecukes --tags @jupyterhub

.PHONY: test
test: quick test-int

.PHONY: test-int
test-int:
	cask exec ert-runner -L ./lisp -L ./test -l test/testfunc.el test/test-func.el
	cask exec ecukes

.PHONY: test-unit
test-unit:
	cask exec ert-runner -L ./lisp -L ./test -l test/testein.el test/test-ein*.el

.PHONY: test-install
test-install:
	mkdir -p test/test-install
	if [ ! -s "test/test-install/$(PKBUILD).tar.gz" ] ; then \
	  cd test/test-install ; curl -sLOk https://github.com/melpa/package-build/archive/$(PKBUILD).tar.gz ; fi
	cd test/test-install ; tar xfz $(PKBUILD).tar.gz
	cd test/test-install ; rm -f $(PKBUILD).tar.gz
	cd test/test-install/package-build-$(PKBUILD) ; make -s loaddefs
	mkdir -p test/test-install/recipes
	cd test/test-install/recipes ; curl -sLOk https://raw.githubusercontent.com/melpa/melpa/master/recipes/ein
	! ( emacs -Q --batch -L test/test-install/package-build-$(PKBUILD) \
	--eval "(require 'package-build)" \
	--eval "(require 'subr-x)" \
	--eval "(package-initialize)" \
	--eval "(add-to-list 'package-archives '(\"melpa\" . \"http://melpa.org/packages/\"))" \
	--eval "(package-refresh-contents)" \
	--eval "(setq rcp (package-recipe-lookup \"ein\"))" \
	--eval "(unless (file-exists-p package-build-archive-dir) \
	           (make-directory package-build-archive-dir))" \
	--eval "(let* ((my-repo \"$(TRAVIS_PULL_REQUEST_SLUG)\") \
	               (my-branch \"$(TRAVIS_PULL_REQUEST_BRANCH)\") \
	               (my-commit \"$(TRAVIS_PULL_REQUEST_SHA)\")) \
	           (oset rcp :repo my-repo) \
	           (oset rcp :branch my-branch) \
	           (oset rcp :commit my-commit))" \
	--eval "(package-build--package rcp (package-build--checkout rcp))" \
	--eval "(package-install-file (car (file-expand-wildcards (concat package-build-archive-dir \"ein*.tar\"))))" 2>&1 | egrep -a "Error: " )

.PHONY: dist
dist:
	rm -rf dist
	cask package

.PHONY: install
install: dist
	emacs -Q --batch --eval "(package-initialize)" \
	  --eval "(add-to-list 'package-archives '(\"melpa\" . \"http://melpa.org/packages/\"))" \
	  --eval "(package-refresh-contents)" \
	  --eval "(package-install-file (car (file-expand-wildcards \"dist/ein*.tar\")))"
