locals {
  auto_shutdown_common_tags = merge(
    var.common_tags,
    {
      "startupMode"  = "always",
      "autoShutdown" = "true",
    }
  )
}