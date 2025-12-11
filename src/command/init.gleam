import gleam/io
import gleam/result
import snag
import utils

pub fn main() -> Result(Nil, snag.Snag) {
  use default_dir <- result.try(utils.get_default_dir())

  // Check if directory already exists
  case utils.directory_exists(default_dir) {
    Ok(True) -> {
      io.println("Directory already exists: " <> default_dir)
      Ok(Nil)
    }
    _ -> {
      io.println("Creating directory: " <> default_dir)
      use _ <- result.try(utils.ensure_directory(default_dir))
      io.println("Initialized successfully!")
      Ok(Nil)
    }
  }
}
