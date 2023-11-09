locals {
  project_tags = {
    contact      = "nov06@jjtech.com"
    application  = "payments"
    project      = "jjtech"
    environment  = "${terraform.workspace}"
    creationTime = formatdate("DD-MM-YY_hh-mm", timestamp())
    # creationTime = timestamp()

  }
}