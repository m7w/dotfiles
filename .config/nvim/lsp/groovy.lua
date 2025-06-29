return {
  root_markers = { "Jenkinsfile", "build.gradle", "settings.gradle" },
  cmd = {
    vim.fn.exepath("groovy-language-server"),
  },
}
