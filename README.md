# Database Testing with Spring Boot and GitHub Actions

## Project Overview
This project demonstrates how to run automated database tests using **Spring Boot**, **PostgreSQL**, and **GitHub Actions**.  
The system validates data integrity and schema rules with both **JUnit tests** and **custom shell scripts** executed inside Docker containers.  

The goal is to provide a simple, reproducible, and scalable way to verify database logic in CI/CD pipelines.

---

## Features
- **Execution of shell script–based tests** directly from Java (core functionality)  
- **Spring Boot** integration to manage configuration and environment setup  
- **PostgreSQL** as the target database for testing  
- **JUnit Tests** included as a demonstration of future migration possibilities away from shell scripts  
- **Docker Compose** orchestration (app + database) for easy reproducibility  
- **GitHub Actions CI** with:  
  - Automatic test execution on every push and pull request  
  - Downloadable **JUnit test reports** as Artifacts  
  - Inline **visual test results** in GitHub Actions UI  

---

## Checking CI Status in GitHub Actions
You can check test results directly in the GitHub repository:

1. Go to the **Actions** tab in the repo.  
2. Select the latest workflow run (triggered by push, pull request, or manual start).  
3. Inside the job details you will find:  
   - **Visual JUnit test results** (passed/failed tests)  
   - **Artifacts** section — you can download the detailed test report in XML format  

This allows both developers and non-technical stakeholders to easily track the health of the database tests.

---

## Continuous Integration
The project uses **GitHub Actions** with the following triggers:
- **On push** to `main` or `dev` branches  
- **On pull requests** targeting `main` or `dev`  
- **Manual trigger** (`workflow_dispatch`)  

This ensures that every change is automatically tested before being merged.  

---

## How to Run Locally
To run the project and execute tests on your machine:

```bash
# 1. Clone the repository
git clone https://github.com/AlexanderHantel/db-test-java.git
cd db-test-java

# 2. Start containers (Postgres + app)
docker-compose up --build --abort-on-container-exit

# 3. View logs
docker-compose logs -f app

# 4. Stop and clean up containers
docker-compose down -v
