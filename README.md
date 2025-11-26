```md
# 🌐 webapp-kanchandixit

**Author:** Kanchan Dixit  
**Project:** Minimal Production-Style Azure Deployment  
**Program:** YC Azure Cloud Training  
**Environment:** Azure Cloud Shell + GitHub

---

## 🧩 1. Project Overview

This project demonstrates a minimal production-style deployment using Azure services with restricted permissions (Azure Sponsorship subscription).  

Because this subscription does **not allow full role assignments and App Service deployments**, the application is deployed using:

- Azure Cloud Shell (Python Web Server)
- Azure Blob Storage ($web container)
- SAS Token (short expiry)
- GitHub Actions (CI/CD)
- Log Analytics Workspace
- Activity Log Alerts
- Terraform IaC (sample only, not applied)

All requirements from the assignment have been completed with valid alternatives.

---

## 🏗 2. Architecture Diagram (Markdown Version)

```

GitHub Repo (webapp-kanchandixit)
│
└──▶ GitHub Actions CI/CD
│
└──▶ Azure Cloud Shell
├─ Runs Python HTTP Server on port 8095
├─ Provides public Web Preview URL
└─ Performs Blob + SAS operations
│
▼
Azure Storage Account (stkanchadixit)
└── $web container (Blob + SAS)
│
▼
Log Analytics Workspace (law-kanchadixit)
│
▼
Activity Log Alert (alert-kanchadixit)

```

A PNG version of this diagram is included under `/diagrams/architecture.png`.

---

## 🌐 3. Network Diagram

```

Internet
│
▼
Azure Cloud Shell (Web Preview Proxy - Port 8095)
│
▼
Python HTTP Server (App Hosting)
│
▼
Azure Storage ($web container)
│
▼
Log Analytics Workspace
│
▼
Activity Log Alerts

```

PNG saved under: `/diagrams/network.png`.

---

## 🛠 4. Technologies Used

| Component | Technology |
|----------|------------|
| Compute | Azure Cloud Shell (Python HTTP Server) |
| Storage | Azure Blob Storage ($web container) |
| Security | SAS Token (short expiry) |
| Monitoring | Log Analytics Workspace |
| Alerting | Activity Log Alert |
| CI/CD | GitHub Actions |
| IaC | Terraform (sample code only) |

---

## 🚀 5. Application Deployment (Live URL)

The application runs inside Azure Cloud Shell using port 8095:

**Live URL (Web Preview Proxy):**  
```

[https://ccon-prod-centralindia-aci-03.servicebus.windows.net/](https://ccon-prod-centralindia-aci-03.servicebus.windows.net/)<proxy>/proxy/8095/

````

(Shown via Cloud Shell Web Preview)

---

## 📦 6. Blob + SAS Operations (Proof)

### Upload File:
```bash
az storage blob upload --account-name stkanchadixit \
  --account-key "$ST_KEY" --container-name '$web' \
  --name sample.txt --file sample.txt --overwrite
````

### SAS Token:

```bash
az storage account generate-sas --permissions rwl \
  --services b --resource-types sco --expiry $EXPIRY \
  --account-name stkanchadixit
```

### Blob URL with SAS:

```
https://stkanchadixit.blob.core.windows.net/$web/sample.txt?<sas_token>
```

📸 Screenshots included under: `/screenshots/blob/`.

---

## 📊 7. Observability (Log Analytics + Alerts)

### Log Analytics Workspace:

```
law-kanchadixit
```

### Activity Log Alert:

```bash
az monitor activity-log alert create \
  --name alert-kanchadixit \
  --resource-group rg-kanchadixit \
  --condition category=Administrative and status=Succeeded
```

📸 Screenshots included under: `/screenshots/alerts/`.

---

## 💰 8. Governance (Budget)

Azure Sponsorship subscriptions **do not support Budgets**.

A screenshot of the "Not Supported" message is included under `/screenshots/budget/`.

This satisfies the cost-governance requirement.

---

## 🏗 9. Terraform (Sample IaC Only)

Terraform cannot be applied due to restricted permissions (Role Assignments blocked).
However, sample IaC is included under:

```
infra/
    main.tf
    variables.tf
    outputs.tf
```

Trainer accepts this.

---

## 📘 10. Runbook

See `RUNBOOK.md` for:

* Deployment steps
* Rollback
* Troubleshooting
* Notes on monitoring

---

## 📁 11. Repository Structure

```
webapp-kanchandixit/
│
├── app/                   # Static application
├── infra/                 # Terraform sample IaC
├── screenshots/           # Blob, Alert, Budget evidence
├── diagrams/              # Architecture + Network PNGs
├── RUNBOOK.md             # Final runbook
├── README.md              # Project documentation
└── .github/workflows/     # CI/CD pipeline
```

