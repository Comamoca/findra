import gleam/io
import snag
import utils

pub fn main() {
  case utils.default_dir() {
    Ok(dir) -> {
      io.println(dir)
      Ok(Nil)
    }
    Error(_) -> {
      Error(snag.new("Unable to get default directory"))
    }
  }
}
