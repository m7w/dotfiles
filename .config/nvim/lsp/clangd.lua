return {
  cmd = {
    "clangd",
    "--background-index",
    "--header-insertion=iwyu",
    "--clang-tidy",
    "--completion-style=detailed",
    "--function-args-placeholders",
    "--fallback-style=llvm",
    -- "--query-driver=/home/max/.platformio/packages/toolchain-xtensa-esp32/bin/xtensa-esp32-elf-gcc",
  },
  format = {
    indentWidth = 4,
  },
}
