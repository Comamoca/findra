import clip
import clip/arg
import clip/help
import clip/opt.{type Opt}
import command/get
import command/init
import command/list

pub fn sub_command() {
  let subcommands = [
    #(
      "get",
      clip.command({
        use path <- clip.parameter
        get.main(path)
      })
        |> clip.arg(
          arg.new("source_directory")
          |> arg.help("Path to the source directory"),
        )
        |> clip.help(help.simple("get", "Get a sandbox directory")),
    ),
    #(
      "list",
      clip.command({
        use path <- clip.parameter
        list.main(path)
      })
        |> clip.arg(
          arg.new("source_directory")
          |> arg.help("Path to the source directory"),
        )
        |> clip.help(help.simple("list", "List all sandbox directories")),
    ),
    #(
      "init",
      clip.command({
        use path <- clip.parameter
        init.main(path)
      })
        |> clip.arg(
          arg.new("repository_path")
          |> arg.help("Repository URL or path to initialize from"),
        )
        |> clip.help(help.simple(
          "init",
          "Initialize a new sandbox directory from a repository",
        )),
    ),
  ]

  clip.subcommands(subcommands)
  |> clip.help(help.simple("findra", "Create sandbox directory to quickly."))
}
