local util = require("lspconfig/util")

return {
    root_dir = util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt"),
    settings = {
        pylsp = {
            configurationSources = { "pylint" },
            plugins = {
                mypy = {
                    enabled = true,
                    live_mode = true,
                    strict = true,
                },
            },
        },
    },
    capabilities = {
        textDocument = {
            formatting = false
        },
        document_formatting = false
    }
}
