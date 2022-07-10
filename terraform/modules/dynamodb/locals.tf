# ---------------------------------------------------------------------------
# Amazon DynamoDB locals
# ---------------------------------------------------------------------------

locals {

  table = {
    users = {
      key  = "user-id"
      name = "users-table"
    }
    appointments = {
      key  = "appointment-id"
      name = "appointments-table"
    }

  }
}