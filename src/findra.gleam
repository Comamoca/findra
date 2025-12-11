import argv
import command/get
import command/init
import command/list as list_cmd
import command/root
import glap/cliargs
import glap/parser
import gleam/io
import gleam/list
import gleam/string
import option as opt

/// Dispatches a parsed command to the appropriate handler
fn dispatch_command(parsed: cliargs.CLIArgs) -> Nil {
  // Check for help flag first
  case cliargs.get_cliarg(parsed, "--help") {
    Ok(_) -> {
      parser.show_help(opt.cli_parser())
      Nil
    }
    _ -> execute_command(parsed)
  }
}

/// Executes the appropriate command based on parsed arguments
fn execute_command(parsed: cliargs.CLIArgs) -> Nil {
  case cliargs.get_cliarg(parsed, "get") {
    Ok(cliargs.Command("get", _, subargs)) -> handle_get_command(subargs)
    _ ->
      case cliargs.get_cliarg(parsed, "list") {
        Ok(cliargs.Command("list", _, _)) -> {
          let _ = list_cmd.main()
          Nil
        }
        _ ->
          case cliargs.get_cliarg(parsed, "init") {
            Ok(cliargs.Command("init", _, _)) -> {
              let _ = init.main()
              Nil
            }
            _ ->
              case cliargs.get_cliarg(parsed, "root") {
                Ok(cliargs.Command("root", _, _)) -> {
                  let _ = root.main()
                  Nil
                }
                _ -> {
                  // No command matched, show help
                  parser.show_help(opt.cli_parser())
                  Nil
                }
              }
          }
      }
  }
}

/// Handles the 'get' command with source argument validation
fn handle_get_command(subargs: cliargs.CLIArgs) -> Nil {
  case cliargs.get_cliarg(subargs, "source") {
    Ok(cliargs.UnnamedArgument(_, source)) -> {
      let _ = get.main(source)
      Nil
    }
    _ -> {
      io.println_error("Error: 'get' command requires a source argument")
      Nil
    }
  }
}

/// Handles parse errors by displaying error message and help
fn handle_parse_error(error) -> Nil {
  io.println_error("Parse error: " <> string.inspect(error))
  io.println("\n")
  parser.show_help(opt.cli_parser())
  Nil
}

pub fn main() {
  let parser_config = opt.cli_parser()
  let args = argv.load().arguments

  // Show help if no arguments provided
  case list.is_empty(args) {
    True -> {
      parser.show_help(parser_config)
      Nil
    }
    False -> {
      case parser.parse(parser_config, args) {
        Ok(parsed) -> dispatch_command(parsed)
        Error(e) -> handle_parse_error(e)
      }
    }
  }
}
