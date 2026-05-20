# ── Current System — Top 10 Classifications (Adult Donors ≥18) ────
current_top10 <- tibble::tribble(
  ~Classification, ~Candidates,                                                              ~Distance,
  1,  "Adult Status 1 or Pediatric Status 1A; Primary Blood Type Match",   "500 NM",
  2,  "Adult Status 1 or Pediatric Status 1A; Secondary Blood Type Match", "500 NM",
  3,  "Adult Status 2; Primary Blood Type Match",                          "500 NM",
  4,  "Adult Status 2; Secondary Blood Type Match",                        "500 NM",
  5,  "Adult Status 3 or Pediatric Status 1B; Primary Blood Type Match",   "250 NM",
  6,  "Adult Status 3 or Pediatric Status 1B; Secondary Blood Type Match", "250 NM",
  7,  "Adult Status 1 or Pediatric Status 1A; Primary Blood Type Match",   "1000 NM",
  8,  "Adult Status 1 or Pediatric Status 1A; Secondary Blood Type Match", "1000 NM",
  9,  "Adult Status 2; Primary Blood Type Match",                          "1000 NM",
  10, "Adult Status 2; Secondary Blood Type Match",                        "1000 NM"
)

# ── 4-Status Counterfactual — Top 10 Classifications ─────────────
# New Status 1 (ECMO/MV): stays at class_prefix (same as current 1A)
# New Status 2 (other 1A): class_prefix + 200 → competes with Adult Status 2
# Status 1B and Status 2: unchanged
cf_top10 <- tibble::tribble(
  ~Classification, ~Candidates,                                                                          ~Distance,
  1,  "Adult Status 1 or Pediatric New Status 1 (ECMO/MV); Primary Blood Type Match",   "500 NM",
  2,  "Adult Status 1 or Pediatric New Status 1 (ECMO/MV); Secondary Blood Type Match", "500 NM",
  3,  "Adult Status 2 or Pediatric New Status 2 (Other 1A); Primary Blood Type Match",  "500 NM",
  4,  "Adult Status 2 or Pediatric New Status 2 (Other 1A); Secondary Blood Type Match","500 NM",
  5,  "Adult Status 3 or Pediatric Status 1B; Primary Blood Type Match",                "250 NM",
  6,  "Adult Status 3 or Pediatric Status 1B; Secondary Blood Type Match",              "250 NM",
  7,  "Adult Status 1 or Pediatric New Status 1 (ECMO/MV); Primary Blood Type Match",   "1000 NM",
  8,  "Adult Status 1 or Pediatric New Status 1 (ECMO/MV); Secondary Blood Type Match", "1000 NM",
  9,  "Adult Status 2 or Pediatric New Status 2 (Other 1A); Primary Blood Type Match",  "1000 NM",
  10, "Adult Status 2 or Pediatric New Status 2 (Other 1A); Secondary Blood Type Match","1000 NM"
)

# ── Render current system ─────────────────────────────────────────
current_top10 %>%
  gt() %>%
  tab_header(
    title    = "Current Allocation Sequence: Adult Donors (≥18 years)",
    #subtitle = "Top 10 classifications shown"
  ) %>%
  cols_label(
    Classification = "Classification",
    Candidates     = "Candidates",
    Distance       = "Distance"
  ) %>%
  tab_spanner(
    label   = "Candidate Criteria",
    columns = c(Candidates, Distance)
  ) %>%
  tab_style(
    style     = cell_fill(color = "#fde8e8"),
    locations = cells_body(
      rows = grepl("Status 1A", Candidates)
    )
  ) %>%
  tab_style(
    style     = cell_fill(color = "#fef3e2"),
    locations = cells_body(
      rows = grepl("Status 1B", Candidates)
    )
  ) %>%
  tab_style(
    style     = cell_text(weight = "bold"),
    locations = cells_column_labels()
  ) %>%
  tab_style(
    style     = cell_text(weight = "bold"),
    locations = cells_column_spanners()
  ) %>%
  tab_style(
    style     = cell_text(align = "center"),
    locations = cells_body(columns = c(Classification, Distance))
  ) %>%
  cols_width(
    Classification ~ px(120),
    Candidates     ~ px(500),
    Distance       ~ px(150)
  ) %>%
  opt_table_font(font = "Arial") %>%
  tab_options(
    table.font.size            = px(12),
    heading.title.font.size    = px(14),
    heading.subtitle.font.size = px(12),
    column_labels.font.weight  = "bold"
  )

# ── Render counterfactual ─────────────────────────────────────────
cf_top10 %>%
  gt() %>%
  tab_header(
    title    = "4-Status Counterfactual Allocation Sequence: Adult Donors (≥18 years)",
    #subtitle = "Top 10 classifications shown"
  ) %>%
  cols_label(
    Classification = "Classification",
    Candidates     = "Candidates",
    Distance       = "Distance"
  ) %>%
  tab_spanner(
    label   = "Candidate Criteria",
    columns = c(Candidates, Distance)
  ) %>%
  tab_style(
    style     = cell_fill(color = "#f5c6c6"),
    locations = cells_body(
      rows = grepl("New Status 1", Candidates)
    )
  ) %>%
  tab_style(
    style     = cell_fill(color = "#fde8e8"),
    locations = cells_body(
      rows = grepl("New Status 2", Candidates)
    )
  ) %>%
  tab_style(
    style     = cell_fill(color = "#fef3e2"),
    locations = cells_body(
      rows = grepl("Status 1B", Candidates)
    )
  ) %>%
  tab_style(
    style     = cell_text(weight = "bold"),
    locations = cells_column_labels()
  ) %>%
  tab_style(
    style     = cell_text(weight = "bold"),
    locations = cells_column_spanners()
  ) %>%
  tab_style(
    style     = cell_text(align = "center"),
    locations = cells_body(columns = c(Classification, Distance))
  ) %>%
  cols_width(
    Classification ~ px(120),
    Candidates     ~ px(500),
    Distance       ~ px(150)
  ) %>%
  opt_table_font(font = "Arial") %>%
  tab_options(
    table.font.size            = px(12),
    heading.title.font.size    = px(14),
    heading.subtitle.font.size = px(12),
    column_labels.font.weight  = "bold"
  )





cat("Match runs included:\n")
cat("  Total:", n_distinct(ptr_ped_runs$MATCH_ID_CODE), "\n")

cat("\nWith pediatric 1A candidate:\n")
cat("  Match runs:", n_distinct(ptr_ped_runs$MATCH_ID_CODE[
  ptr_ped_runs$is_ped_1a]), "\n")

cat("\nPediatric 1A candidate observations:\n")
cat("  Total rows (ped 1A):",
    sum(ptr_ped_runs$is_ped_1a), "\n")
cat("  Unique candidates:",
    n_distinct(ptr_ped_runs$WL_ID_CODE[
      ptr_ped_runs$is_ped_1a]), "\n")

cat("\nDate range:\n")
ptr_ped_runs %>%
  summarise(
    min_date = min(as.Date(MATCH_SUBMIT_DT),
                   na.rm = TRUE),
    max_date = max(as.Date(MATCH_SUBMIT_DT),
                   na.rm = TRUE)
  ) %>% print()

cat("\nOutcome_long rows:\n")
cat("  Total:", nrow(outcome_long), "\n")
cat("  Current System:", sum(outcome_long$System ==
                               "Current System"), "\n")
cat("  Counterfactual:", sum(outcome_long$System ==
                               "4-Status Counterfactual"), "\n")
cat("  Events (deaths within 180d):",
    sum(outcome_long$event[
      outcome_long$System == "Current System"]), "\n")
