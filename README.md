# macOS + Python mid-2019

Setting up a Mac after a few years playing with Python on Windows can be daunting. Here's what I've come up with after a few internet searches: 

### macOS build chain:

* [xcode command line tools](https://developer.apple.com/xcode/), you need these to build stuff:
    ```bash
    xcode-select —-install

    sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_m acOS_10.14.pkg -target /

    echo "export SDKROOT=/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk" >> ~/.bash_profile
    ```

### Python developer tools:

* [homebrew](https://brew.sh/) osx package manager:
    ```
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    ```

* [pyenv](https://github.com/pyenv/pyenv) manages python runtime installation:
    ```
    brew install pyenv
    pyenv install 3.7.4
    pyenv global 3.7.4
    ```

* [direnv](https://github.com/direnv/direnv/blob/master/docs/hook.md) per-folder environment configs:
    ```
    brew install direnv
    echo eval "$(direnv hook bash)" > ~/.bash_profile
    ```

* [pipenv](https://github.com/pypa/pipenv) manage per-project python dependencies by transparently creating virtualenvs:
    ```
    brew install pipenv
    ```

* [pipx](https://github.com/pipxproject/pipx) manages python based cli tools by installing them in ad-hoc virtualenvs and exposing shims (`~/.local/bin`):
    ```bash
    pip3 install --user pipx
    pipx install flake8
    ```

### Editor: 

* [VS Code](https://code.visualstudio.com/)
* [Python extention](https://marketplace.visualstudio.com/items?itemName=ms-python.python):
    * config user settings (code "$HOME/Library/Application Support/Code/User/settings.json") to use pipx global paths:
    ```json
    {
        "python.linting.flake8Path": "~/.local/bin/flake8",
        "python.formatting.blackPath": "~/.local/bin/black"
    }
    ```

* [Pyright extention](https://marketplace.visualstudio.com/items?itemName=ms-pyright.pyright) complement python extension adding typechecking and more:
    * if you prefer using [pyre-check](https://github.com/facebook/pyre-check) [pyre-vscode](https://marketplace.visualstudio.com/items?itemName=fb-pyre-check.pyre-vscode) is also available


### Here's what my `~/.bash_profile` looks like now:

```bash
export PATH="$PATH:~/.local/bin"

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true

# commands to override pip restriction above.
# use `gpip` or `gpip3` to force installation of
# a package in the global python environment
# Never do this! It is just an escape hatch.
gpip(){
  PIP_REQUIRE_VIRTUALENV="" pip "$@"
}
gpip3(){
  PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}

export SDKROOT=/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

eval "$(direnv hook bash)"
```

### Resources:

* [Definitive guide to python on Mac OSX](https://medium.com/@briantorresgil/definitive-guide-to-python-on-mac-osx-65acd8d969d0)
* [Pipenv & Virtual Environments](https://docs.python-guide.org/dev/virtualenvs/)
* [Kenneth Reitz - Pipenv: The Future of Python Dependency Management - PyCon 2018](https://www.youtube.com/watch?v=GBQAKldqgZs&t=2s)
