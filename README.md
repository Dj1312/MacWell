# MacWell
🧰💡 Scripts and tools to deploy photonics development environment on Apple Silicon Devices

## Requirements
The only requisitory is to have installed Homebrew.
It can easily be make using the following commands :
- Download Homebrew
```bash
## Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
- Follow the instructions given by Homebrew to add to your path (in my case)
```bash
# Add brew to path
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/xxx/.zprofile # where xxx is the user
eval "$(/opt/homebrew/bin/brew shellenv)"
```

NB: Pay attention to the fact that Homebrew installs itself in /usr/local for macOS Intel, /opt/homebrew for Apple Silicon and /home/linuxbrew/.linuxbrew for Linux as explained [here](https://docs.brew.sh/Installation).