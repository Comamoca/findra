import gleam/io
import gleam/result
import snag
import utils

pub fn main() -> Result(Nil, snag.Snag) {
  use dir <- result.try(utils.get_default_dir())
  io.println(dir)
  Ok(Nil)
}
