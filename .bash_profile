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
