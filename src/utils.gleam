import filepath
import gleam/list
import gleam/result
import simplifile
import snag
import xdgleam

/// Returns the default findra directory path (~/.findra)
pub fn default_dir() -> Result(String, Nil) {
  use home <- result.try(xdgleam.home())
  Ok(filepath.join(home, ".findra"))
}

/// Gets the default directory or returns a Snag error
pub fn get_default_dir() -> Result(String, snag.Snag) {
  default_dir()
  |> result.map_error(fn(_) { snag.new("Unable to get default directory") })
}

/// Checks if a directory exists and returns a Result
pub fn directory_exists(path: String) -> Result(Bool, snag.Snag) {
  simplifile.is_directory(path)
  |> result.map_error(fn(e) {
    snag.new("Failed to check directory: " <> simplifile.describe_error(e))
  })
}

/// Creates a directory if it doesn't exist
pub fn ensure_directory(path: String) -> Result(Nil, snag.Snag) {
  case simplifile.is_directory(path) {
    Ok(True) -> Ok(Nil)
    _ ->
      simplifile.create_directory_all(path)
      |> result.map_error(fn(e) {
        snag.new("Failed to create directory: " <> simplifile.describe_error(e))
      })
  }
}

/// Extracts all subdirectories from the given directory path
/// Returns a Result containing list of directory paths
pub fn extract_directories(
  current: String,
) -> Result(List(String), simplifile.FileError) {
  use files <- result.try(simplifile.read_directory(current))

  files
  |> list.map(fn(filename) { filepath.join(current, filename) })
  |> list.filter_map(fn(path) {
    case simplifile.is_directory(path) {
      Ok(True) -> Ok(path)
      _ -> Error(Nil)
    }
  })
  |> Ok
}
