# TODO

## 🐞 Known Bugs

- [ ] Fix potential timezone discrepancy between PHP runtime and MySQL timestamps in `daily_stock_logs`.
- [ ] Handle division-by-zero errors when calculating "Days until running out" for items with zero consumption rate.

## 🚨 High priority

- [ ] Add Breadcrumbs for smoother navigation across administrative and inventory pages.
- [ ] Implement strict multi-tenant security verification using `$_SESSION['company_id']` across all database queries[cite: 1].
- [ ] Build the daily stock movement logging interface to record gross weights and compute net weights automatically.

## 🛠️ Medium priority

- [ ] Create management interfaces (CRUD) for containers and tare weights (`containers` table)[cite: 1].
- [ ] Create management interfaces (CRUD) for gelato flavors (`flavors` table)[cite: 1].
- [ ] Implement consumption analytics and predictive stock exhaustion metrics (mirroring the monthly Excel tracking sheets).

## 💤 Low priority

- [ ] Add export functionality to generate PDF/Excel monthly stock reports.
- [ ] Implement a dark mode theme toggle using BEM modifier classes in SCSS.

## ✅ Completed

- [x] Establish the relational database schema with foreign keys and cascade delete constraints `companies`, `containers`, `flavors`, `users_login`, `stock_items`, `daily_stock_logs`.
- [x] Apply clean BEM methodology across HTML templates and SCSS stylesheets.
- [x] Implement dynamic language translation dictionaries for inventory status `in_stock`, `display`, `finished`, `discarded`.
- [x] Refactor current stock view to display active items (`in_stock` and `display`) for the logged-in company without date filters.
