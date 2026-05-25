# validationcheck

`validationcheck` is an R package for automated data quality validation, monitoring, and reporting.

The package helps analysts, Monitoring & Evaluation (M&E) teams, researchers, and program implementers identify data quality issues using simple validation rules and generate interactive validation reports.

The package supports:

- numeric validation
- missing value checks
- duplicate detection
- date validation
- categorical validation
- text validation
- cross-field validation
- interactive reporting
- failed record extraction

---

# Installation

Install the development version from GitHub:

```r
install.packages("remotes")

remotes::install_github(
  "roy-mwavita0/validationcheck"
)
```

---

# Load Package

```r
library(validationcheck)
library(magrittr)
```

---

# Validation Workflow

The validation workflow follows 3 simple steps:

1. Initialize validation agent
2. Add validation rules
3. Generate report

---

# Example

```r
report <- validate_data(sample_registry) %>%

  add_validation(

    label = "Age Above 24",

    columns = "age",

    rule =
      "Participant age should not exceed 24 years",

    check = greater_than(24)
  ) %>%

  add_validation(

    label = "Missing Sex",

    columns = "sex",

    rule =
      "Sex should not be missing",

    check = is_missing()
  )

get_report(report)
```

---

# Interactive Validation Report

The package generates an interactive validation report with:

- validation summaries
- pass/fail status
- failure rates
- severity classification
- expandable failed records

<img width="1837" height="537" alt="Screenshot 2026-05-24 150640" src="https://github.com/user-attachments/assets/6d859090-8196-473c-aae8-fea07c8305f3" />

---

# Validation Structure

Each validation rule contains:

```r
add_validation(

  label = "Validation Name",

  columns = "column_name",

  rule = "Description of validation rule",

  check = validator_function()
)
```

---

# Available Validators

## Numeric Validators

| Function | Purpose |
|---|---|
| `greater_than(x)` | values > x |
| `less_than(x)` | values < x |
| `greater_equal(x)` | values >= x |
| `less_equal(x)` | values <= x |
| `equal_to(x)` | values not equal to x |
| `not_equal(x)` | values equal to forbidden value |
| `range_between(min, max)` | values outside range |
| `is_positive()` | values <= 0 |
| `is_negative()` | values >= 0 |

---

## Missingness Validators

| Function | Purpose |
|---|---|
| `is_missing()` | missing values |
| `not_missing()` | required fields |

---

## Duplicate Validators

| Function | Purpose |
|---|---|
| `duplicates()` | duplicated values |
| `unique_values()` | enforce uniqueness |

---

## Character Validators

| Function | Purpose |
|---|---|
| `include(values)` | values not in allowed list |
| `exclude(values)` | values in forbidden list |
| `contains(text)` | missing required text |
| `starts_with(text)` | invalid prefix |
| `ends_with(text)` | invalid suffix |
| `matches_regex(pattern)` | regex validation |

---

## Date Validators

| Function | Purpose |
|---|---|
| `before_date(date)` | invalid future dates |
| `after_date(date)` | invalid earlier dates |
| `between_dates(start, end)` | dates outside range |
| `future_date()` | dates not in future |
| `past_date()` | dates in future |

---

## Cross-field Validators

| Function | Purpose |
|---|---|
| `compare_columns(col1, col2)` | compare two columns |
| `date_before(col1, col2)` | chronological checks |
| `conditional_required()` | conditional missing checks |

---

# Multiple Column Validation

Validators can also work across multiple columns.

```r
report <- validate_data(sample_registry) %>%

  add_validation(

    label = "Dates Before 2024",

    columns = c(
      "date_enrolled",
      "date_exited"
    ),

    rule =
      "Dates should occur after 2024-01-01",

    check = after_date("2024-01-01")
  )
```

---

# Extract Failed Records

Extract failed rows from a specific validation.

```r
get_failed(
  report,
  "Age Above 24"
)
```

---

# Severity Classification

Severity is automatically assigned based on failure rate.

| Failure Rate | Severity |
|---|---|
| 0% - 2% | GOOD |
| >2% - 20% | WARNING |
| >20% | CRITICAL |

---

# Intended Use Cases

`validationcheck` is useful for:

- Monitoring & Evaluation (M&E)
- OVC programming
- Health data validation
- Survey quality checks
- Research data cleaning
- KoboToolbox exports
- REDCap validation
- DHIS2 data quality checks
- Routine data audits

---

# Author

Roy Mwavita

Monitoring, Evaluation, Accountability and Learning (MEAL) Specialist

---

# License

MIT License


