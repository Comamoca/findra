import gleam/list
import gleeunit
import gleeunit/should
import simplifile
import utils

pub fn main() -> Nil {
  gleeunit.main()
}

// Utils module tests

pub fn default_dir_test() {
  let result = utils.default_dir()
  result |> should.be_ok
}

pub fn get_default_dir_test() {
  let result = utils.get_default_dir()
  result |> should.be_ok
}

pub fn directory_exists_test() {
  // Test with a directory that should exist (root)
  let result = utils.directory_exists("/tmp")
  result |> should.be_ok
  result |> should.equal(Ok(True))

  // Test with a directory that should not exist
  let result2 = utils.directory_exists("/this/should/not/exist/at/all")
  case result2 {
    Ok(False) -> Nil
    Error(_) -> Nil
    Ok(True) -> panic as "Directory should not exist"
  }
}

pub fn ensure_directory_test() {
  let test_dir = "/tmp/findra_ensure_test"

  // Clean up if exists
  let _ = simplifile.delete(test_dir)

  // Create directory
  let result = utils.ensure_directory(test_dir)
  result |> should.be_ok

  // Verify it exists
  utils.directory_exists(test_dir)
  |> should.equal(Ok(True))

  // Try to ensure it again (should succeed without error)
  let result2 = utils.ensure_directory(test_dir)
  result2 |> should.be_ok

  // Cleanup
  let assert Ok(_) = simplifile.delete(test_dir)
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

pub fn extract_directories_empty_test() {
  // Create a temporary test directory with no subdirectories
  let test_dir = "/tmp/findra_empty_test"
  let assert Ok(_) = simplifile.create_directory_all(test_dir)
  let assert Ok(_) = simplifile.write(test_dir <> "/file.txt", "test")

  let assert Ok(directories) = utils.extract_directories(test_dir)

  // Should return empty list
  directories
  |> list.length
  |> should.equal(0)

  // Cleanup
  let assert Ok(_) = simplifile.delete(test_dir)
}
