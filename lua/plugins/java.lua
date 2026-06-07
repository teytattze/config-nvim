-- JDTLS customizations layered on top of the lang.java extra.
-- The extra already resolves the jdtls launcher, lombok agent, workspace dir, dap and test
-- bundles, so only the project-specific settings from the old config are ported here:
--   * opts.settings        -> config.settings (sent to the server)
--   * opts.jdtls.init_options -> deep-merged into the jdtls init_options
return {
  {
    "mfussenegger/nvim-jdtls",
    opts = {
      settings = {
        java = {
          references = {
            includeDecompiledSources = true,
          },
          format = {
            enable = true,
            settings = {
              url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
              profile = "GoogleStyle",
            },
          },
          completion = {
            favoriteStaticMembers = {
              "org.hamcrest.MatcherAssert.assertThat",
              "org.hamcrest.Matchers.*",
              "org.hamcrest.CoreMatchers.*",
              "org.junit.jupiter.api.Assertions.*",
              "java.util.Objects.requireNonNull",
              "java.util.Objects.requireNonNullElse",
              "org.mockito.Mockito.*",
            },
            filteredTypes = {
              "com.sun.*",
              "io.micrometer.shaded.*",
              "java.awt.*",
              "jdk.*",
              "sun.*",
            },
            importOrder = { "#" },
          },
        },
      },
      jdtls = {
        init_options = {
          settings = {
            java = {
              imports = {
                gradle = {
                  enabled = true,
                  wrapper = {
                    enabled = true,
                    checksums = {
                      {
                        sha256 = "7d3a4ac4de1c32b59bc6a4eb8ecb8e612ccd0cf1ae1e99f66902da64df296172",
                        allowed = true,
                      },
                    },
                  },
                },
              },
            },
          },
        },
      },
    },
  },
}
