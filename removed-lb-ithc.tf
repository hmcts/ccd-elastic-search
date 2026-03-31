# Temporary removed block for ITHC load balancer state cleanup.
# This is intended to stop Terraform refreshing missing LB resources that still exist in state.
# Remove this file when re-enabling LB creation/management for ITHC.

removed {
  from = module.load_balancers
}
