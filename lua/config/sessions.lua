require("auto-session").setup {
    auto_session_allowed_dirs = { 'dev' },
    auto_session_create_enabled = false,
}
require("telescope").load_extension("session-lens")
