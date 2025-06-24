
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$(brew --prefix python@3.12)/libexec/bin:$PATH"


# Load SSH agent configuration
source /Users/theol/.ssh/ssh-agent-config

### Source Proception Toolchains: (auto-installed by `install-toolchain.sh`)
source /Users/theol/Documents/github/proception-toolchain/common.sh
source_all_common_configs > /dev/null
### [END of Proception Toolchain]

