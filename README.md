# findra

[![Package Version](https://img.shields.io/hexpm/v/findra)](https://hex.pm/packages/findra)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/findra/)

A CLI tool for creating and managing sandbox directories, inspired by try-cli. Quickly create temporary workspaces for experimenting with code, cloning repositories, or organizing project prototypes.

## Features

- **get** - Clone Git repositories or create directories in your sandbox
- **list** - Display all sandbox directories
- **init** - Initialize the default sandbox directory (~/.findra)
- **root** - Show the default sandbox directory path

## Installation

### Binary Releases (Recommended)

Download the latest AppImage from [GitHub Releases](https://github.com/Comamoca/findra/releases):

```bash
# Download the AppImage (replace VERSION with actual version)
wget https://github.com/Comamoca/findra/releases/latest/download/findra-VERSION-linux-amd64.AppImage

# Make it executable
chmod +x findra-VERSION-linux-amd64.AppImage

# Run it
./findra-VERSION-linux-amd64.AppImage --help
```

Available platforms:
- **Linux x86_64**: `findra-*-linux-amd64.AppImage`
- **Linux ARM64**: `findra-*-linux-arm64.AppImage`

### From Source (Gleam)

```sh
gleam add findra@1
```

Or build from source:

```sh
gleam build
```

### From Source (Nix)

```sh
# Build with Nix
nix build

# Or run directly
nix run
```

## Usage

### Initialize the sandbox directory

```sh
gleam run -- init
```

This creates the default directory at `~/.findra`.

### Create or clone into the sandbox

Clone a Git repository:

```sh
gleam run -- get https://github.com/user/repo
```

Create a named directory:

```sh
gleam run -- get my-project
```

### List all sandbox directories

```sh
gleam run -- list
```

### Show the sandbox root path

```sh
gleam run -- root
```

### Get help

```sh
gleam run -- --help
```

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
gleam format  # Format code
```

### Running Tests

The project includes comprehensive tests covering:
- Utility functions (directory operations, path handling)
- Error handling and edge cases
- Empty directory handling
- Idempotent operations

Run the test suite:

```sh
gleam test
```

## Architecture

The codebase is organized into modules:

- `src/findra.gleam` - Main entry point with command dispatch logic
- `src/option.gleam` - CLI argument parser configuration
- `src/utils.gleam` - Shared utility functions for directory operations
- `src/command/` - Individual command implementations
  - `get.gleam` - Clone or create directories
  - `list.gleam` - List sandbox directories
  - `init.gleam` - Initialize the sandbox
  - `root.gleam` - Show sandbox root path

## Contributing

Contributions are welcome! The codebase follows these principles:

- Clear separation of concerns with modular design
- Consistent error handling using Result types
- Comprehensive test coverage
- Documentation for all public functions

Further documentation can be found at <https://hexdocs.pm/findra>.
