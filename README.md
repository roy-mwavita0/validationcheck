# validationcheck

An R package for automated data quality validation and reporting.

## Installation

```r
remotes::install_github("roy-mwavita0/validationcheck")
```

## Example

```r
library(validationcheck)
library(magrittr)

report <- validate_data(sample_registry) %>%

  add_validation(
    label = "Age Above 24",
    columns = "age",
    rule = "Age should not exceed 24 years",
    check = greater_than(24)
  )

get_report(report)

<img width="1837" height="537" alt="Screenshot 2026-05-24 150640" src="https://github.com/user-attachments/assets/6d859090-8196-473c-aae8-fea07c8305f3" />

```
