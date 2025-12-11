import filepath
import gleam/io
import gleam/result
import gleam/string
import shellout
import simplifile
import snag
import utils

pub fn main(source: String) {
  use default_dir <- result.try(
    utils.default_dir()
    |> result.map_error(fn(_) { snag.new("Unable to get default directory") }),
  )

  // Check if source is a Git URL (http://, https://, git@)
  let is_git_url =
    string.starts_with(source, "http://")
    || string.starts_with(source, "https://")
    || string.starts_with(source, "git@")

  case is_git_url {
    True -> {
      // Clone repository
      io.println("Cloning repository: " <> source)

      let result =
        shellout.command(
          run: "git",
          with: ["clone", source],
          in: default_dir,
          opt: [],
        )

      case result {
        Ok(_) -> {
          io.println("Successfully cloned to: " <> default_dir)
          Ok(Nil)
        }
        Error(#(exit_code, output)) -> {
          Error(snag.new(
            "Failed to clone repository (exit code: "
            <> string.inspect(exit_code)
            <> "): "
            <> output,
          ))
        }
      }
    }
    False -> {
      // Create directory
      let target_path = filepath.join(default_dir, source)
      io.println(target_path)

      simplifile.create_directory_all(target_path)
      |> result.map_error(fn(e) {
        snag.new("Failed to create directory: " <> simplifile.describe_error(e))
      })
      |> result.map(fn(_) { Nil })
    }
  }
}
