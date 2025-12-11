import gleam/io
import gleam/result
import snag
import utils

pub fn main(repository: String) {
  use default_dir <- result.try(
    utils.default_dir() |> snag.map_error(utils.describe_error),
  )
  // use repo_dir <- result.try(
  //   simplifile.is_directory(default_dir)
  //   |> snag.map_error(utils.describe_error)
  //   |> snag.context("Unable to read $HOME"),
  // )

  io.println(repository)

  Ok(Nil)
}
