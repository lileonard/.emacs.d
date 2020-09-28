Getting started
---------------
Thank you for contributing!  EIN development will work best in a UNIX environment.

Fork the repo on github.  Clone the fork to your home directory.

Install cask.  Run `make dist` to ensure correct cask functionality.

Run `make test` to ensure a correct baseline.  This locally replicates the travis ci build.  You may need to install other software such as jupyter, R, matplotlib, etc.

Remove the MELPA-installed EIN by deleting the package directory (on my system, it's `~/.emacs.d/elpa/ein-20190122.1341`) or running `M-x package-delete`.

In your `init.el` or `.emacs`, add the following:

```
(add-to-list 'load-path "~/emacs-ipython-notebook/lisp")
(load "ein-autoloads")
```

Now whatever changes you make to the repo will be reflected in new emacs instances.

Dev tools
---------------
Most dev functionality lies in `ein-dev.el` the most important of which is `ein:dev-start-debug` which activates full logging and backtrace on error.

Quick sanity checking
---------------------
`make quick` runs a syntax check and the unit tests.  It is far quicker than the laborious `make test`.

Unit tests
----------
Located in `~/emacs-ipython-notebook/test`.

Integration tests
-----------------
If you add a feature, we encourage writing an integration test.

`cask exec ecukes` is the bulk of `make test`.  Ecukes is our friend and guardian.  We follow its opinionated file structure in `~/emacs-ipython-notebook/features`.

To run say just the login tests, `cask exec ecukes --tags "@login"`.
