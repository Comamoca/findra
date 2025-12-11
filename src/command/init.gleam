import gleam/io
import gleam/result
import simplifile
import snag
import utils

pub fn main() {
  use default_dir <- result.try(
    utils.default_dir()
    |> result.map_error(fn(_) { snag.new("Unable to get default directory") }),
  )

  // Check if default_dir exists
  let dir_exists = case simplifile.is_directory(default_dir) {
    Ok(True) -> True
    _ -> False
  }

  // Create directory if it doesn't exist
  use _ <- result.try(case dir_exists {
    True -> {
      io.println("Directory already exists: " <> default_dir)
      Ok(Nil)
    }
    False -> {
      io.println("Creating directory: " <> default_dir)
      simplifile.create_directory_all(default_dir)
      |> result.map_error(fn(e) {
        snag.new("Failed to create directory: " <> simplifile.describe_error(e))
      })
    }
  })

  io.println("Initialized successfully!")

  Ok(Nil)
}
