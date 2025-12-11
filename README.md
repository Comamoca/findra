<div align="center">

![Last commit](https://img.shields.io/github/last-commit/Comamoca/findra?style=flat-square)
![Repository Stars](https://img.shields.io/github/stars/Comamoca/findra?style=flat-square)
![Issues](https://img.shields.io/github/issues/Comamoca/findra?style=flat-square)
![Open Issues](https://img.shields.io/github/issues-raw/Comamoca/findra?style=flat-square)
![Bug Issues](https://img.shields.io/github/issues/Comamoca/findra/bug?style=flat-square)

<img src="https://emoji2svg.deno.dev/api/📦" alt="eyecatch" height="100">

# findra

A simple and fast repository management CLI tool written in Gleam.

<br>
<br>


</div>

<div align="center">

</div>

## 🚀 How to use

Initialize the default directory (~/.findra):
```sh
findra init
```

Clone a Git repository or create a directory:
```sh
# Clone a Git repository
findra get https://github.com/user/repo

# Create a new directory
findra get myproject
```

List all managed directories:
```sh
findra list
```

Show the root directory path:
```sh
findra root
```

## ⬇️  Install

### From Releases

Download the latest AppImage from the [releases page](https://github.com/Comamoca/findra/releases):

```sh
# Download and make executable
chmod +x findra.AppImage

# Move to a directory in your PATH
mv findra.AppImage ~/.local/bin/findra
```

### From Source

Requirements:
- Gleam (>= 0.44.0)
- Erlang/OTP

Build from source:

```sh
# Clone the repository
git clone https://github.com/Comamoca/findra
cd findra

# Build the project
gleam build

# Run
gleam run
```

### With Nix

If you have Nix with flakes enabled:

```sh
# Run directly
nix run github:Comamoca/findra

# Or build
nix build
```


## ⛏️   Development

### Prerequisites

- Gleam (>= 0.44.0)
- Erlang/OTP
- Git

### Setup

```sh
# Clone the repository
git clone https://github.com/Comamoca/findra
cd findra

# Install dependencies (automatically handled by Gleam)
gleam build
```

### Running Tests

```sh
gleam test
```

### Development with Nix

If using Nix with flakes:

```sh
# Enter development shell
nix develop

# Build
gleam build

# Run
gleam run
```
## 📝 Todo

- [ ] Add configuration file support (.findrarc)
- [ ] Support for custom directory structures
- [ ] Add command to search repositories
- [ ] Integration with fzf for interactive selection
- [ ] Add update command for repositories

## 📜 License

MIT License (to be added)

### 🧩 Modules

findra uses the following Gleam packages:

- [gleam_stdlib](https://hex.pm/packages/gleam_stdlib) - Gleam standard library
- [simplifile](https://hex.pm/packages/simplifile) - File system operations
- [filepath](https://hex.pm/packages/filepath) - Cross-platform file path handling
- [argv](https://hex.pm/packages/argv) - Command-line argument parsing
- [xdgleam](https://hex.pm/packages/xdgleam) - XDG Base Directory support
- [snag](https://hex.pm/packages/snag) - Error handling
- [shellout](https://hex.pm/packages/shellout) - Shell command execution
- [glap](https://hex.pm/packages/glap) - CLI argument parser
- [gleeunit](https://hex.pm/packages/gleeunit) - Testing framework (dev dependency)

## 👏 Affected projects

This project was inspired by:

- [ghq](https://github.com/x-motemen/ghq) - Remote repository management made easy
- Repository management tools in general that help organize development projects

## 💕 Special Thanks

Special thanks to:

- The [Gleam](https://gleam.run/) team for creating an amazing language
- All the contributors of the Gleam packages used in this project
- The open-source community for inspiration and support
