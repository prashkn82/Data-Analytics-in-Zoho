# Validation Workflow — ETL & Migration (Zoho: CRM, Books, Desk, Analytics)

Version: 1.1  
Last updated: 2026-07-05  
Author: Data Engineering / Migration Team

## 1. Purpose & Scope
This document defines a repeatable, auditable Validation Workflow used during extraction, transformation, and migration (ETL) from legacy systems into Zoho CRM, Books, Desk, and Analytics. It ensures data is accurate, complete, standardized, and reconciled before migration.

Scope:
- Source systems → Staging → Transformation → Target (Zoho)
- CRM, Books, Desk, Analytics modules
- Validation phases, acceptance criteria, remediation steps, and reporting

## 2. Roles & Responsibilities
- Data Owner (Business): defines business rules and approves exceptions.
- Data Engineer: implements validation checks, automates reports, fixes detectable issues.
- ETL Lead: coordinates validation runs and migration gating.
- QA/Analyst: reviews reports, performs manual validation samples.
- Stakeholders (Ops, Finance, Support): final approval for migration.

## 3. High-level Workflow
1. Raw Data Integrity Validation  
2. Structural Validation  
3. Format & Standardization Validation  
4. Business Rule Validation  
5. Referential Integrity Validation  
6. Cross‑Module Validation & Reconciliation  
7. Exception Logging & Reporting  
8. Final Approval & Sign‑off

Each phase produces artifacts and explicit acceptance criteria. Automation is recommended for repeatability.

## 4. Validation Phases (Detailed)

### Phase 1 — Raw Data Integrity Validation
Objective: Verify the extracted data matches source extracts and is uncorrupted.

Checks:
- Row count comparison: legacy vs staging (by table/partition)
- Column completeness: expected columns present
- Null value detection (critical columns)
- Corrupted record detection (binary/encoding issues)
- Encoding normalization (ensure UTF-8)

Sample SQL:
- Row count: SELECT 'customers' AS tbl, COUNT(*) FROM staging.customers;
- Column presence: compare information_schema.columns for expected vs actual

Outputs:
- raw_integrity_report.csv (counts, mismatches)
- missing_or_corrupted_records.csv

Acceptance:
- No missing rows for tables flagged as critical OR documented reconciliation tolerance agreed with Data Owner.

Automation tips:
- Use checksums (e.g., md5 on concatenated key fields) for byte-level differences.

---

### Phase 2 — Structural Validation
Objective: Confirm staging & transformed schemas match target expectations.

Checks:
- Field existence and types (string, integer, date, decimal)
- Length limits (phone, SKU)
- Mandatory field presence (NOT NULL constraints)

Outputs:
- structural_validation_report.csv
- schema_mismatch_list.docx

Acceptance:
- All required fields present and coerced to compatible types or documented mapping applied.

Automation:
- Use schema compare tools (dbt schema tests, Great Expectations, custom scripts).

---

### Phase 3 — Format & Standardization Validation
Objective: Ensure consistent formats required by Zoho targets.

Checks & Examples:
- Email regex: ^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$
- Phone: digits only, E.164 normalization where applicable
- Dates: ISO 8601 (YYYY-MM-DD or YYYY-MM-DDTHH:MM:SSZ)
- Case rules: Uppercase names (if required), lowercase emails
- Monetary decimals: two-decimal precision, currency code present

Outputs:
- format_error_report.csv
- standardization_summary.md

Acceptance:
- Critical format errors = 0 (or exceptions approved). Non-critical normalized automatically when safe.

Automation:
- Implement regex-based unit tests and transformation rules (e.g., normalize_phone(), normalize_email()).

---

### Phase 4 — Business Rule Validation
Objective: Enforce domain rules and business logic.

Checks:
- Valid deal stages (list from business)
- Valid ticket statuses
- Invoice amounts > 0
- Valid payment methods (mapped to Zoho values)
- Product category normalization
- Boolean flag normalization (true/false vs 1/0/NULL)

Outputs:
- business_rule_violations.csv
- corrected_values_log.csv (auto-corrected items)

Acceptance:
- No violation for rules marked “blocking.” Other issues must be resolved or accepted by Data Owner.

Automation:
- Centralize business rules in a rules engine or configuration file to keep checks maintainable.

---

### Phase 5 — Referential Integrity Validation
Objective: Ensure relationships exist and are consistent across modules.

Checks:
- Orders → Customers (order.customer_id exists in customers)
- OrderItems → Products
- Tickets → Contacts
- Invoices → Deals
- Payments → Invoices

Sample SQL (or pseudocode):
- SELECT o.id FROM staging.orders o LEFT JOIN staging.customers c ON o.customer_id = c.id WHERE c.id IS NULL;

Outputs:
- orphan_records_report.csv
- relationship_reconstruction_report.csv

Acceptance:
- Orphans = 0 for critical relations OR orphans logged and resolved by ETL rules (linking by alternate key or manual reconciliation).

Automation:
- Use foreign-key check tests; if mapping keys differ, include matching heuristics (email, phone) with confidence scores.

---

### Phase 6 — Cross‑Module Validation & Reconciliation
Objective: Verify consistency across CRM, Books, Desk, and Analytics.

Checks:
- Customer ID consistency across modules (master customer ID)
- Product SKU consistency
- Deal → Invoice → Payment chain completeness
- Ticket → Contact → Customer chain
- Aggregated totals: Analytics totals vs CRM/Books/Desk totals (tolerance-based)

Outputs:
- cross_module_consistency_report.csv
- reconciliation_summary.xlsx

Acceptance:
- Reconciliation variances within agreed tolerance (e.g., <0.1% or business-agreed thresholds). Anything beyond requires approval.

Automation:
- Scheduled reconciliation jobs; log variances and trigger investigation tickets automatically.

---

### Phase 7 — Exception Logging & Reporting
Objective: Collect and present errors, warnings, and remediation actions.

Standard logs:
- etl_error_log (blocking)
- etl_warning_log (non-blocking)
- etl_skipped_records (records skipped during load)
- etl_repair_actions (auto-repairs performed)

Required fields (log schema):
- timestamp, module, table, pk_value, severity (ERROR/WARNING/INFO), check_name, description, suggested_action, ticket_id (if created)

Outputs:
- exception_summary.md
- corrective_action_list.csv

Automation:
- Centralize logs to ELK/Datadog/Splunk or a monitoring dashboard with alerting for ERROR-level thresholds.

---

### Phase 8 — Final Approval & Sign‑Off
Objective: Confirm readiness for migration.

Steps:
1. Review all validation reports.
2. Review reconciliation and KPI dashboards.
3. Stakeholder approval: Ops, Finance, Support (signatures).
4. Migration readiness confirmation.

Sign-off artifacts:
- signed_validation_checklist.pdf
- approval_certificate_for_migration_execution.pdf

Gating rule:
- Block migration if any “blocking” ERROR remains unresolved.

## 5. Metrics & Acceptance Criteria
- Data Quality Score (per entity): (1 - (critical_errors / total_checks)) * 100
- Critical errors allowed: 0 (unless explicitly approved)
- Reconciliation tolerance: e.g., <0.1% variance for financial totals (tunable)
- Test coverage: 100% of mandatory fields checked

## 6. Remediation & Escalation Flow
1. Auto-fix where deterministic (formatting, normalization).
2. Generate remediation tickets for manual review (include sample records).
3. Data Owner/Business reviews exceptions and approves corrections or accepts risk.
4. Re-run validation after fixes; log deltas.

## 7. Reporting & Deliverables
- Per-run artifacts (date-stamped):
  - raw_integrity_report.csv
  - structural_validation_report.csv
  - format_error_report.csv
  - business_rule_violations.csv
  - orphan_records_report.csv
  - cross_module_consistency_report.csv
  - exception_summary.md
  - signed_validation_checklist.pdf

- Dashboard:
  - KPI: Counts, errors by severity, DQ score, reconciliation deltas, trend over time.

## 8. Tools & Automation Recommendations
- Orchestration: Airflow, Prefect
- Testing & Validation: Great Expectations, dbt tests, custom SQL
- ETL: dbt / Python scripts / cloud ETL (Fivetran/Matillion) as appropriate
- Monitoring & Logs: ELK stack, Datadog
- Tickets: JIRA/GitHub Issues integration for exceptions

## 9. Examples / Quick-check SQL snippets
- Row count:
  SELECT 'customers' AS table_name, COUNT(*) FROM staging.customers;
- FK orphan detection:
  SELECT o.id FROM staging.orders o WHERE NOT EXISTS (SELECT 1 FROM staging.customers c WHERE c.id = o.customer_id);
- Duplicate primary key:
  SELECT id, COUNT(*) FROM staging.customers GROUP BY id HAVING COUNT(*) > 1;
- Email validation:
  SELECT id, email FROM staging.contacts WHERE NOT (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');

## 10. Sign-off checklist (minimal)
- [ ] Raw integrity check passed
- [ ] Structural validation passed
- [ ] Format & standardization passed or auto-corrected
- [ ] Business rules passed or approved exceptions
- [ ] Referential integrity passed or remediated
- [ ] Cross-module reconciliation within tolerance
- [ ] Exception logs reviewed & tickets created for manual items
- [ ] Stakeholder approvals attached

## 11. Appendix
- Glossary (Customer ID = canonical customer identifier; SKU = product stock-keeping unit)
- Contact list for Data Owner, ETL Lead, and QA
- Change log
