import filepath
import gleam/result
import snag
import utils
import xdgleam

pub fn main(source_directory: String) {
  use home <- result.try(xdgleam.home() |> snag.map_error(utils.describe_error))

  echo filepath.join(home, source_directory)
    |> filepath.join("*")

  Ok(Nil)
}
