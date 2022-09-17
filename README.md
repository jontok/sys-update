# sys-update

Wrapper script for apt/[nala](https://gitlab.com/volian/nala) system upgrades

Update your Debian/Ubuntu based system with a short and easy command

## Install
Please check the [install.sh](install.sh) and [sys-update.sh](sys-update.sh) before installing.
```bash
git clone https://github.com/jontok/sys-update.git

cd sys-update

./install.sh

# to also install nala

./install.sh --nala-install

```

## Usage

sys-update [option]

### Options

`-h, --help`

- Shows Available Options

`-f, --fetch`

- Will fetch all upgradable packages

`-u, --update`
- Will update repositories
