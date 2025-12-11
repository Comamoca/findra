import filepath
import gleam/io
import gleam/list
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
  use dir_exists <- result.try(
    simplifile.is_directory(default_dir)
    |> result.map_error(fn(e) {
      snag.new("Failed to check directory: " <> simplifile.describe_error(e))
    }),
  )

  case dir_exists {
    False -> {
      io.println("Directory does not exist: " <> default_dir)
      io.println("Run 'init' command first to create it.")
      Ok(Nil)
    }
    True -> {
      // Extract directories using utils.extract_directories
      use directories <- result.try(
        utils.extract_directories(default_dir)
        |> result.map_error(fn(e) {
          snag.new("Failed to read directory: " <> simplifile.describe_error(e))
        }),
      )

      case list.is_empty(directories) {
        True -> {
          io.println("No directories found in: " <> default_dir)
          Ok(Nil)
        }
        False -> {
          list.each(directories, fn(dir) { io.println(filepath.base_name(dir)) })
          Ok(Nil)
        }
      }
    }
  }
}
