# dotemacs

This is my personal KISS Emacs config.

# intro

There are many emacs configs, what makes this one different?

## kiss

This is a keep it simple stupid config.  It is built with 3 simple building blocks; small enough that it is white magic instead of black magic.

### simple building block 1

``` cl
(defun require-package (package)
  "Ensures that PACKAGE is installed."
  (unless (or (package-installed-p package)
              (require package nil 'noerror))
    (unless (assoc package package-archive-contents)
      (package-refresh-contents))
    (package-install package)))
```

The code here is self-explanatory.  This is how you declare what packages you want to install and use.  This was taken from [Purcell][1]'s config.

### simple building block 2

`with-eval-after-load` lets you defer execution of code until after a feature has been loaded.  This is used extensively throughout the config, so wrapping macro has been written for ease of use.  This is what keeps the config loading fast.

Another useful feature is that it can also be used to run code if a package has been installed by using `-autoloads`; e.g.

```cl
(after 'magit
  ;; execute after magit has been loaded
  )
(after "magit-autoloads"
  ;; execute if magit is installed/available
  )
(after [evil magit]
  ;; execute after evil and magit have been loaded
  )
```

This was taken from [milkypostman][2].

### simple building block 3

At the bottom of the `init.el` is the following gem:

``` cl
(cl-loop for file in (reverse (directory-files-recursively config-directory "\\.el$"))
  do (load file)))
```

Basically, it recursively finds anything in `config/` and loads it.  If you want to add additional configuration for a new language, simply create `new-language.el` in `config/` and it will automatically be loaded.  Files are loaded in reverse order so that any functions defined will be available in child nodes.

### other building blocks

#### bindings in one place

Another decision is to keep all keybindings in one place: `config-bindings.el`.  Because of this, things like [use-package][3] aren't particularly useful here because it doesn't add much value over `(require-package)` and `after`.

Keybindings are the single most differentiating factor between configs.  By defining them in one place, if you want to use/fork this config, you can simply change the bindings to your liking and still use all the other preconfigured packages as is.  If you're not an Evil user, delete `config-evil.el` and you will get a pure Emacs experience.

#### lazy installation of major mode packages

By combining `after`, `require-package`, and `auto-mode-alist`, packages are installed only when necessary.  If you never open a Javascript file, none of those packages will be installed.

# install

`git clone https://github.com/bling/dotemacs.git ~/.emacs.d`

# disclaimer

here be dragons.

# license

MIT


[1]: https://github.com/purcell/emacs.d
[2]: http://milkbox.net/note/single-file-master-emacs-configuration/
[3]: https://github.com/jwiegley/use-package
