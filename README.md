```
# 🌐 Azure Static Website Deployment

### **YC–18708 — Kanchan Dixit**

This project demonstrates a **minimal production-style deployment** of a static web application on Microsoft Azure using essential cloud services such as Storage Accounts, Blob Static Website Hosting, SAS tokens, Alerts, Governance, and GitHub for version control.

The goal is to showcase practical cloud skills in a simple, efficient, and submission-ready project structure.

---

## 🚀 Project Overview

This project hosts a **static HTML website** on **Azure Blob Storage (Static Website Hosting)**.
The website is publicly accessible and deployed manually using Azure CLI (due to limited subscription permissions), while the GitHub repository contains Infrastructure-as-Code structure, app files, CI/CD workflow, and documentation.

---

## ✅ Key Features

### **1. Static Website on Azure Storage**

* Hosted using **Azure Blob Static Website ($web container)**
* Permanent public endpoint
* Updated advanced UI webpage

Live URL:
👉 **[https://stkanchadixit.z13.web.core.windows.net/](https://stkanchadixit.z13.web.core.windows.net/)**

---

### **2. Infrastructure as Code (Terraform Sample)**

* Terraform folder (`infra/`) included in GitHub
* Contains Resource Group example (trainer requirement)
* *Note:* Terraform apply not executed due to limited permissions

---

### **3. Azure Security Setup**

* Storage Account Access Key usage
* SAS token with limited expiry (read/write/list)
* Key Vault provisioning attempted (limited role access)
* Proof provided in screenshots

---

### **4. Observability**

* Activity Log Alert created: monitors delete/update administrative events
* Log Analytics workspace limited — alternative proof provided

---

### **5. Governance**

* Tags applied: `owner = kanchandixit`
* Budget creation attempted (not permitted; error screenshot added)

---

### **6. CI/CD Workflow (GitHub Actions)**

* `.github/workflows/deploy.yml` included
* Pipeline structure included for assessment (deployment restricted by access)

---

## 📂 Repository Structure

```
webapp-kanchandixit/
│
├── app/
│   ├── index.html         # Advanced UI static webpage
│   └── 404.html           # Custom error page
│
├── infra/
│   └── main.tf            # Terraform sample (trainer requirement)
│
├── .github/
│   └── workflows/
│       └── deploy.yml     # Sample CI/CD workflow
│
├── screenshots/           # (Optional) Blob, alert, SAS, UI proofs
│
├── README.md              # Main project documentation
└── RUNBOOK.md             # Operational guide (optional)
```

---

## 🛠️ Deployment Commands (Executed in Cloud Shell)

### **1. Create app folder**

```bash
mkdir -p ~/webapp-kanchandixit/app
```

### **2. Upload website to Azure**

```bash
az storage blob upload-batch \
  --account-name stkanchadixit \
  --account-key "$ST_KEY" \
  --source ~/webapp-kanchandixit/app \
  --destination '$web' \
  --overwrite
```

### **3. Enable static website**

```bash
az storage blob service-properties update \
  --account-name stkanchadixit \
  --static-website \
  --index-document index.html \
  --404-document 404.html
```

---

## 📸 Screenshots Included

(Optional but helpful for trainer)

* Blob upload
* SAS token
* Static website URL
* Alert creation
* Budget error
* Key vault access attempt
* Live website UI

---

## ▶ Runbook (Summary)

1. **Deploy:**

   * Upload via Azure CLI to `$web`
   * Update html → reupload

2. **Rollback:**

   * Replace previous stable version in app folder
   * Re-upload to `$web`

3. **Troubleshooting:**

   * 404 error → missing index.html
   * Access denied → regenerate `$ST_KEY`
   * Cloud Shell reset → reclone GitHub repo
```
