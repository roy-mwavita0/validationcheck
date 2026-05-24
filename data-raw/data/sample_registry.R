library(tibble)

sample_registry <- tibble(

  registry_id = c(
    "BII001",
    "BII002",
    "BII003",
    "BII004",
    "BII005"
  ),

  county = c(
    "Kilifi",
    "Mombasa",
    "Kisumu",
    "Nairobi",
    "Turkana"
  ),

  age = c(
    16,
    19,
    27,
    13,
    22
  ),

  birth_certificate_number = c(
    "BC1001",
    "BC1002",
    "BC1001",
    NA,
    "BC1005"
  ),

  hiv_status = c(
    "NEGATIVE",
    "POSITIVE",
    "POSITIVE",
    "NEGATIVE",
    "UNKNOWN"
  ),

  program_status = c(
    "ACTIVE",
    "ACTIVE",
    "ACTIVE",
    "EXITED",
    "ACTIVE"
  )
)
