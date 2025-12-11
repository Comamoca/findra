import glap/arguments.{Command, Flag, UnnamedArgument}
import glap/parser.{Parser}
import gleam/option

pub fn cli_parser() {
  Parser(
    arguments: [
      Flag("-h", "--help", "Show help information", False, False),
      Command(
        "get",
        "Get a sandbox directory (git clone or create directory)",
        False,
        [
          UnnamedArgument("source", "Git URL or directory name"),
        ],
      ),
      Command("list", "List all sandbox directories", False, []),
      Command("init", "Initialize the default directory", False, []),
      Command("root", "Show the default directory path", False, []),
    ],
    description: "findra - Create sandbox directories quickly",
    settings: option.None,
    help_settings: option.None,
  )
}
