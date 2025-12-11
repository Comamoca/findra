import filepath
import gleam/list
import gleam/result
import simplifile
import xdgleam

/// Returns the default findra directory path (~/.findra)
pub fn default_dir() -> Result(String, Nil) {
  use home <- result.try(xdgleam.home())
  Ok(filepath.join(home, ".findra"))
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
