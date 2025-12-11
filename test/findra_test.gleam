import gleam/list
import gleeunit
import gleeunit/should
import simplifile
import utils

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn default_dir_test() {
  let result = utils.default_dir()
  result |> should.be_ok
}

pub fn extract_directories_test() {
  // Create a temporary test directory
  let test_dir = "/tmp/findra_test"
  let assert Ok(_) = simplifile.create_directory_all(test_dir)
  let assert Ok(_) = simplifile.create_directory_all(test_dir <> "/subdir1")
  let assert Ok(_) = simplifile.create_directory_all(test_dir <> "/subdir2")
  let assert Ok(_) = simplifile.write(test_dir <> "/file.txt", "test")

  let assert Ok(directories) = utils.extract_directories(test_dir)

  // Should only return directories, not files
  // Note: order may vary, so we check length and contents
  directories
  |> list.length
  |> should.equal(2)

  directories
  |> list.contains(test_dir <> "/subdir1")
  |> should.be_true

  directories
  |> list.contains(test_dir <> "/subdir2")
  |> should.be_true

  // Cleanup
  let assert Ok(_) = simplifile.delete(test_dir)
}
