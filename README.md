# Music Analytics on the Chinook Database

> **Side‑Project · August 2024**
> Exploratory SQL analysis of a fictional digital music store using the open‑source **Chinook** sample database.

---

## 📑 Table of Contents

1. [Project Goals](#project-goals)
2. [About the Chinook Database](#about-the-chinook-database)
3. [Repository Structure](#repository-structure)
4. [Getting Started](#getting-started)
5. [Running the Analyses](#running-the-analyses)
6. [Query‑by‑Query Breakdown](#query-by-query-breakdown)
7. [Sample Insights](#sample-insights)
8. [Next Steps](#next-steps)
9. [Contributing](#contributing)
10. [License](#license)

---

## Project Goals

This mini‑project answers **key business questions** for a music‑store CEO, covering:

| Domain                               | Key Questions                                                                   |
| ------------------------------------ | ------------------------------------------------------------------------------- |
| **Sales**                            | *Which albums, tracks and genres drive revenue?*                                |
| *What is the average invoice total?* |                                                                                 |
| **Customer Behaviour**               | *Who are the top spenders? How many customers make repeat purchases?*           |
| **Inventory / Catalog**              | *Which genres dominate the catalog? Which album contains the most tracks?*      |
| **Geography**                        | *Which countries/cities generate the most revenue and host the most customers?* |

The answers are produced purely with **ANSI‑SQL** against the Chinook schema—no external BI tools required.

---

## About the Chinook Database

*Chinook* is a popular sample database (an alternative to Northwind) that models a digital media store.  The schema contains **11 core tables**:

```
Artist ─┐                 Invoice     InvoiceLine
        └─ Album ─ Track ─┤  │             │
Genre ────────────────────┘  │             │
Customer ─────────────── Invoice ─────────┘
Employee, MediaType, Playlist, PlaylistTrack  ➟ (auxiliary tables)
```

The dataset ships in multiple formats (SQLite, MySQL, Postgres, SQL Server).  This project assumes **SQLite 3** for maximum portability, but any flavour will work if you tweak the connection string.

---

## Repository Structure

```
├── CustomerBehavior.sql        # Repeat‑purchase & spend analysis
├── GeographicAnalysis.sql      # Revenue by country/city
├── InventoryCatalogAnalysis.sql# Catalog composition & top composers
├── SalesAnalysis.sql           # Revenue & bestseller breakdowns
└── README_Chinook.md           # (this file)
```

> **Note** – Each script is **idempotent** and begins with `USE Chinook;` so you can run them in any order.

---

## Getting Started

### 1. Clone & enter the repo

```bash
git clone https://github.com/xlumzee/MusicAnalyticsChinook.git
cd MusicAnalyticsChinook
```

### 2. Install SQLite 3 (if you don't already have it)

* **macOS** – `brew install sqlite3`
* **Ubuntu** – `sudo apt-get install sqlite3`
* **Windows** – download the pre‑compiled binary from [https://www.sqlite.org/download.html](https://www.sqlite.org/download.html)

### 3. Download the Chinook database file

```bash
curl -L -o Chinook.sqlite \
  https://raw.githubusercontent.com/lerocha/chinook-database/master/ChinookDatabase/DataSources/Chinook_Sqlite.sqlite
```

(Any other `.db` or `.sql` variant works too.)

### 4. Launch the SQLite CLI (or your favourite client)

```bash
sqlite3 Chinook.sqlite
```

You should see a prompt like `SQLite version 3.46.0 2025-05-18  ...`.

---

## Running the Analyses

Inside the SQLite shell:

```sql
.read SalesAnalysis.sql               -- revenue deep‑dive
.read CustomerBehavior.sql            -- top customers & repeat buyers
.read InventoryCatalogAnalysis.sql    -- catalog composition
.read GeographicAnalysis.sql          -- revenue by geo
```

> **Tip –** Prefix the `.read` command with the full path if you are not in the repo root.

Alternatively, execute from the command line without entering the shell:

```bash
sqlite3 Chinook.sqlite < SalesAnalysis.sql > sales_report.txt
```

---

## Query‑by‑Query Breakdown

Below is a lightning overview of what each script does.

### 1. `SalesAnalysis.sql`

| # | Description                                               | Output Column(s)              |
| - | --------------------------------------------------------- | ----------------------------- |
| 1 | Total revenue across the store                            | `TotalRevenue`                |
| 2 | Albums generating > \$10                                  | `Album_Title`, `Total_Sales`  |
| 3 | Revenue by genre                                          | `Name`, `Total_Sales_Revenue` |
| 4 | Average revenue per invoice                               | `AverageRevenuePerInvoice`    |
| 5 | Top‑5 best‑selling tracks **per genre** (window function) | `Genre`, `Track`, `Revenue`   |

### 2. `CustomerBehavior.sql`

| # | Question                         | Output                                            |
| - | -------------------------------- | ------------------------------------------------- |
| 1 | Top‑5 customers by invoice total | `First Name`, `Last Name`, `Total Purchases`      |
| 2 | Customers with >1 invoice        | `Customer ID`, `Invoice Count`                    |
| 3 | Customers who spent > \$40       | `First Name`, `Last Name`, `Total Purchases`      |
| 4 | Tracks purchased per customer    | `First Name`, `Last Name`, `TotalTracksPurchased` |

### 3. `InventoryCatalogAnalysis.sql`

Covers catalog richness and artist contribution.

| Focus           | Example Metric                       |
| --------------- | ------------------------------------ |
| Genre depth     | Track count per genre                |
| Album depth     | Track count per album (ordered desc) |
| Artist breadth  | Album count per artist               |
| Composer output | Top‑5 composers by number of tracks  |

### 4. `GeographicAnalysis.sql`

| # | Metric                         | Columns                     |
| - | ------------------------------ | --------------------------- |
| 1 | Revenue by country             | `Country`, `TotalRevenue`   |
| 2 | Avg invoice amount per country | `Country`, `AvgInvoiceAmt`  |
| 3 | Customer concentration by city | `City`, `NumberOfCustomers` |

---

## Sample Insights

Running all four scripts yields, for instance:

* **Top Revenue Genre** – *Rock* generates \~1.4× the revenue of the next genre (Metal).
* **Best Album** – *AC/DC – Back in Black* earns \$13.86, making it the only album > \$10.
* **Repeat Customers** – 48 out of 59 customers (81%) place multiple invoices.
* **Revenue Geography** – The USA leads with \$523, followed by Canada (\~\$303).

> **Disclaimer** – Values reflect the default Chinook sample data (\~9 MB) and will differ if you use a modified dump.

---

## Next Steps

1. **Visualise** the outputs with a notebook (e.g. load into Pandas).
2. Build a **dbt** project to version‑control transformations.
3. Create a **dashboard** (Metabase / Superset) for non‑technical stakeholders.
4. Port queries to **PostgreSQL** and compare execution plans.

---

## Contributing

Feel free to open issues or PRs—especially if you:

* Find a more efficient query plan
* Spot a typo or inconsistent formatting
* Want to add new analytical dimensions (e.g. playlist usage)

---

## License

Distributed under the **MIT License**.  See `LICENSE` for more info.
