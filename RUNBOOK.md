---
# RUNBOOK.md

### **Azure Static Website Mini Project — YC-18708 (Kanchan Dixit)**

This runbook describes how to deploy, update, monitor, and troubleshoot the static website hosted on Azure Blob Storage Static Website Hosting.

---

## **1. Environment Details**

* **Resource Group:** `rg-kanchadixit`
* **Storage Account:** `stkanchadixit`
* **Hosting Method:** Azure Blob Static Website
* **Public URL:** `https://stkanchadixit.z13.web.core.windows.net/`
* **Repository:** `https://github.com/kanchandixit/webapp-kanchandixit`

---

## **2. Deployment Procedure**

### **Step 1 — Login**

```bash
az login
```

### **Step 2 — Get Storage Account Key**

```bash
export ST_KEY=$(az storage account keys list \
  --account-name stkanchadixit \
  --resource-group rg-kanchadixit \
  --query "[0].value" -o tsv)
```

### **Step 3 — Enable Static Website**

```bash
az storage blob service-properties update \
  --account-name stkanchadixit \
  --static-website \
  --index-document index.html \
  --404-document 404.html
```

### **Step 4 — Upload Web Files**

```bash
az storage blob upload-batch \
  --account-name stkanchadixit \
  --account-key "$ST_KEY" \
  --source ~/webapp-kanchandixit/app \
  --destination '$web' \
  --overwrite
```

### **Step 5 — Verify Website**

Open:
`https://stkanchadixit.z13.web.core.windows.net/`

---

## **3. Rollback Procedure**

If a deployment breaks the site:

### **Step 1 — Restore Previous File Version**

From GitHub → open previous commit → download old index.html.

### **Step 2 — Re-upload**

```bash
az storage blob upload-batch \
  --account-name stkanchadixit \
  --account-key "$ST_KEY" \
  --source app \
  --destination '$web' \
  --overwrite
```

### **Step 3 — Test Website**

Reload the public URL.

---

## **4. Monitoring & Alerts**

### **Activity Log Alert**

Alert monitors administrative actions.

```bash
az monitor activity-log alert create \
  --name alert-kanchadixit \
  --resource-group rg-kanchadixit \
  --condition "category=Administrative and status=Succeeded" \
  --description "Admin Activity Alert"
```

---

## **5. Security Operations**

### **Generate SAS Token (1-hour expiry)**

```bash
EXPIRY=$(date -u -d "1 hour" '+%Y-%m-%dT%H:%MZ')

az storage account generate-sas \
  --permissions rwl \
  --services b \
  --resource-types sco \
  --expiry $EXPIRY \
  --account-name stkanchadixit \
  -o tsv
```

### **Key Vault**

Key Vault was created but **secret creation is blocked by RBAC restrictions**.
Screenshot included as proof.

---

## **6. Troubleshooting**

### **Website shows 404**

Re-upload:

```bash
az storage blob upload-batch --account-name stkanchadixit --account-key "$ST_KEY" --source app --destination '$web' --overwrite
```

### **Account Key Missing**

Re-export:

```bash
export ST_KEY=$(az storage account keys list --account-name stkanchadixit --resource-group rg-kanchadixit --query "[0].value" -o tsv)
```

### **Cloud Shell Reset**

Reclone:

```bash
git clone https://github.com/kanchandixit/webapp-kanchandixit.git
```

### **Key Vault Forbidden**

Expected due to limited access — use SAS token instead.

---

## **7. Backup & Recovery**

* GitHub repo serves as backup for all web files.
* To recover, reclone the repo and upload to `$web` using upload-batch.

---

## **8. Owner Information**

**Name:** Kanchan Dixit
**Project ID:** YC-18708
**Live URL:** `https://stkanchadixit.z13.web.core.windows.net/`
**Repo:** `https://github.com/kanchandixit/webapp-kanchandixit`

---
