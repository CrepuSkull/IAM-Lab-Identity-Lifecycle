# IAM-Lab: Identity Lifecycle Automation

Laboratoire d’architecture IAM conforme aux référentiels **ISO/IEC 27001:2022** (A.9) et **NIST SP 800-53** (AC-2, AC-6), conçu selon la méthode **TOGAF ADM**.

##  Vision métier (Phase A)
Automatiser le provisioning/déprovisioning des identités à partir d’une source RH fiable, tout en appliquant :
- Le **principe du moindre privilège**
- Une stratégie **RBAC** (Role-Based Access Control)
- Une **traçabilité complète** des opérations d’identité

##  Structure du projet
- `data/` : Sources RH (CSV)
- `scripts/` : Logique de transformation (PowerShell)
- `output/` : Résultats (fichiers LDIF)
- `docs/` : Documentation architecturale TOGAF

##  Prochaine étape
Génération d’un fichier `employees.csv` représentant la source de vérité métier (Phase B – Architecture Métier).
