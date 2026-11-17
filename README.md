# kavn-helpdesk-system

A Freshdesk-inspired helpdesk ticketing system built with C#, ASP.NET Core Web API, and SQL Server.

**Status:** In development. This is a personal project.

## Features

**Built:**

- Relational database with 9 tables: roles, users, categories, priorities, statuses, tickets, ticket comments, ticket history, and SLA policies
- Re-runnable SQL scripts with seed and sample data
- `GET /api/tickets`: list tickets with status, priority, category, creator, and assignee names
- `POST /api/tickets`: creates a ticket and its first history record in one transaction
- Input validation, with clear error messages for bad requests
- Stored procedures for reading and creating tickets

**Planned:**

- Login with JWT and role-based access (Admin, Lead, Agent, Customer)
- Ticket assignment and reassignment, status changes, and comments
- SLA tracking and escalation
- Web frontend
- Automated tests, Docker, and CI/CD with GitHub Actions
- Deployment to free-tier cloud hosting

## Tech Stack

- **Backend:** C#, ASP.NET Core Web API, .NET 10
- **Database:** Microsoft SQL Server, T-SQL, SQL Stored Procedures
- **Data Access:** Dapper, Microsoft.Data.SqlClient
- **Tools:** Visual Studio, SQL Server Management Studio, Git, GitHub

## Project Structure

- `database/`: SQL scripts, run in numbered folder order
    - `00_Setup`: creates the database
    - `01_Tables`: table definitions
    - `03_StoredProcedures`: stored procedures
    - `04_SeedData`: lookup data and sample data
- `src/Helpdesk/Helpdesk.Api/`: the ASP.NET Core Web API
    - `Controllers`: API endpoints
    - `DTOs`: the shapes of data the API sends and receives
    - `Entities`: classes that mirror database tables

## Getting Started

### Prerequisites

- .NET 10 SDK
- SQL Server (LocalDB, which comes with Visual Studio, is enough)
- SQL Server Management Studio, or any tool that can run T-SQL scripts

### Database setup

Run the scripts in `database/` in order, with SSMS connected to `(localdb)\MSSQLLocalDB`:

1. `00_Setup/001_CreateDatabase.sql`
2. Every file in `01_Tables`, in numbered order
3. Every file in `03_StoredProcedures`, in numbered order
4. Every file in `04_SeedData`, in numbered order

The seed scripts and stored procedures can be run again safely. The table scripts are meant to run once, on a new database.

The seed scripts include sample users (one per role) and sample tickets, so the API returns data right away.

### Run the API

1. Open `src/Helpdesk/Helpdesk.slnx` in Visual Studio, or use the terminal.
2. The connection string is in `src/Helpdesk/Helpdesk.Api/appsettings.json`. It uses Windows Authentication against `(localdb)\MSSQLLocalDB`, so no password is needed. Change it if your SQL Server is different.
3. Run the API:

   ```
   cd src/Helpdesk/Helpdesk.Api
   dotnet run --launch-profile https
   ```

4. The API listens on `https://localhost:7283`.

### API Endpoints

| Method | Route | Description |
|---|---|---|
| GET | `/api/tickets` | List all tickets |
| POST | `/api/tickets` | Create a ticket (title, description, categoryId, priorityId) |

Sample requests are in `src/Helpdesk/Helpdesk.Api/Helpdesk.Api.http`.

The creator of a new ticket is temporarily fixed to user 4 (Maria Customer) until login is built.

## License

Released under the MIT License. See the `LICENSE` file.