import filepath
import gleam/io
import gleam/result
import gleam/string
import shellout
import snag
import utils

/// Determines if the source string is a Git URL
fn is_git_url(source: String) -> Bool {
  string.starts_with(source, "http://")
  || string.starts_with(source, "https://")
  || string.starts_with(source, "git@")
}

/// Clones a Git repository to the default directory
fn clone_repository(
  source: String,
  default_dir: String,
) -> Result(Nil, snag.Snag) {
  io.println("Cloning repository: " <> source)

  case
    shellout.command(
      run: "git",
      with: ["clone", source],
      in: default_dir,
      opt: [],
    )
  {
    Ok(_) -> {
      io.println("Successfully cloned to: " <> default_dir)
      Ok(Nil)
    }
    Error(#(exit_code, output)) ->
      Error(snag.new(
        "Failed to clone repository (exit code: "
        <> string.inspect(exit_code)
        <> "): "
        <> output,
      ))
  }
}

/// Creates a new directory in the default directory
fn create_directory(
  source: String,
  default_dir: String,
) -> Result(Nil, snag.Snag) {
  let target_path = filepath.join(default_dir, source)
  io.println(target_path)
  utils.ensure_directory(target_path)
}

pub fn main(source: String) -> Result(Nil, snag.Snag) {
  use default_dir <- result.try(utils.get_default_dir())

  case is_git_url(source) {
    True -> clone_repository(source, default_dir)
    False -> create_directory(source, default_dir)
  }
}
