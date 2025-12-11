import filepath
import gleam/list
import gleam/result
import simplifile
import xdgleam

pub fn default_dir() {
  use home <- result.try(xdgleam.home())
  Ok(filepath.join(home, ".findra"))
}

pub fn describe_error(error) {
  case error {
    _ -> ""
  }
}

pub fn extract_directories(current: String) {
  let assert Ok(files) = simplifile.read_directory(current)

  list.map(files, fn(filename) { filepath.join(current, filename) })
  |> list.filter_map(fn(path) {
    case simplifile.is_directory(path) {
      Error(_) -> Error(Nil)
      Ok(_) -> Ok(path)
    }
  })
}
