# webapp-kanchandixit

Author: Kanchan Dixit
Project: Minimal Production-Style Azure Deployment
Program: YC Azure Cloud Training
Environment: Azure Cloud Shell + GitHub

📌 1. Project Overview

This project demonstrates a minimal production-style deployment using Azure services with restricted permissions.
Due to limitations on my Azure Sponsorship subscription, deployment is performed through:

Azure Cloud Shell

GitHub Actions

Azure Storage (Blob + SAS)

Log Analytics Workspace

Activity Log Alerts

Terraform IaC code is included as a sample, but cannot be applied on this subscription (role assignment not allowed).
This is accepted by trainers.

📌 2. Architecture Diagram
                        ┌──────────────────────────────────────────┐
                        │                GitHub                    │
                        │        Repo: webapp-kanchandixit         │
                        │  - Stores App + Infra + Runbook          │
                        │  - GitHub Actions CI/CD Pipeline         │
                        └──────────────────────────────────────────┘
                                         │
                                         ▼
                     ┌──────────────────────────────────────────┐
                     │           GitHub Actions CI/CD           │
                     │  - Builds code                           │
                     │  - Syncs repo to Cloud Shell             │
                     └──────────────────────────────────────────┘
                                         │
                                         ▼
      ┌──────────────────────────────────────────────────────────────────────────┐
      │                        Azure Cloud Shell                                 │
      │  - Hosts Live App via Python HTTP Server (Port 8095)                    │
      │  - Web Preview public link                                               │
      │  - Blob + SAS operations                                                 │
      └──────────────────────────────────────────────────────────────────────────┘
                                         │
                                         ▼
              ┌────────────────────────────────────────────────────────────┐
              │                   Storage Account: stkanchadixit           │
              │     Containers: $web                                       │
              │     SAS Token for secure blob access                       │
              └────────────────────────────────────────────────────────────┘
                                         │
                                         ▼
       ┌────────────────────────────────────────────────────────────────────────┐
       │                 Log Analytics Workspace: law-kanchadixit              │
       └────────────────────────────────────────────────────────────────────────┘
                                         │
                                         ▼
      ┌──────────────────────────────────────────────────────────────────────────┐
      │                   Activity Log Alert: alert-kanchadixit                   │
      └──────────────────────────────────────────────────────────────────────────┘
                                         │
                                         ▼
          ┌──────────────────────────────────────────────────────────────┐
          │    Cost Management (Budgets NOT Supported in my account)    │
          │         Screenshot included as required proof               │
          └──────────────────────────────────────────────────────────────┘

📌 3. Network Diagram
                        Internet
                            │
                            ▼
         ┌──────────────────────────────────────────┐
         │ Azure Cloud Shell Web Preview (Port 8095)│
         └──────────────────────────────────────────┘
                            │
                            ▼
         ┌──────────────────────────────────────────┐
         │ Python HTTP Server (App Hosting)         │
         └──────────────────────────────────────────┘
                            │
                            ▼
         ┌──────────────────────────────────────────┐
         │ Azure Storage Account (Blob)             │
         │ Container: $web                          │
         └──────────────────────────────────────────┘
                            │
                            ▼
         ┌──────────────────────────────────────────┐
         │ Log Analytics Workspace                  │
         └──────────────────────────────────────────┘
                            │
                            ▼
         ┌──────────────────────────────────────────┐
         │ Activity Log Alerts                      │
         └──────────────────────────────────────────┘

📌 4. Technologies Used
Component	Service
Compute	Azure Cloud Shell (Python HTTP server)
Storage	Azure Blob Storage ($web container)
Security	SAS Token (short expiry)
Observability	Log Analytics Workspace
Alerts	Activity Log Alert
CI/CD	GitHub Actions
IaC	Terraform Sample Code (not applied)
📌 5. App Deployment (Live URL)

The app runs from Cloud Shell:

LIVE URL:

https://ccon-prod-centralindia-aci-03.servicebus.windows.net/<proxy>/proxy/8095/


(Displayed via Web Preview)

📌 6. Blob + SAS Operations (Evidence)
Generate account key:
export ST_KEY=$(az storage account keys list ...)

Upload file:
az storage blob upload --container-name '$web' ...

SAS token:
az storage account generate-sas ...


Screenshots included in /screenshots/blob/.

📌 7. Observability
Log Analytics Workspace:
law-kanchadixit

Activity Log Alert:
alert-kanchadixit
condition: category=Administrative and status=Succeeded


Screenshots included in /screenshots/alerts/.

📌 8. Governance: Budget

Azure Sponsorship subscription does NOT support budgets.
Screenshot of the "Not Supported" screen is included.

📌 9. Terraform (Sample IaC)

Folder: /infra
Includes:

main.tf

variables.tf

outputs.tf

These are samples only (not applied due to subscription restrictions).
Trainer allows this.

📌 10. Runbook

See RUNBOOK.md
Contains:

Deployment steps

Rollback

Troubleshooting

SLA notes

📌 11. Repository Structure
webapp-kanchandixit/
│
├── app/                     # Static app
├── infra/                   # Terraform sample IaC
├── screenshots/             # Blob, Alert, Budget evidence
├── RUNBOOK.md               # Runbook
├── README.md                # Documentation
└── .github/workflows/       # CI/CD pipeline


2. TERRAFORM SAMPLE FOLDER (READY TO UPLOAD)

Create folder:

infra/

infra/main.tf
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-kanchadixit"
  location = "EastUS"
}

infra/variables.tf
variable "location" {
  default = "EastUS"
}

infra/outputs.tf
output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}


This is sample-only IaC, clearly acceptable.

⭐ 3. ARCHITECTURE PNG + NETWORK PNG

You now paste the ASCII diagrams into:

https://draw.io

or
https://excalidraw.com

or
PowerPoint → Save as PNG

Then save those PNGs into:

/diagrams/
   architecture.png
   network.png
