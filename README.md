# Introduction 

The application is a simple Node.js web app built using the Express.js framework and EJS (Embedded JavaScript) templating engine.

# Requirements

The core functional and structural requirements of the app are:

- Built with **Node.js** using the **Express.js** framework  
- Uses **EJS** for rendering dynamic HTML views  
- Handles **basic routing** (e.g., homepage, contact, etc.)  
- Simple and modular folder structure (`views`, `routes`)    

# Branching Strategy

### `main`
- **Purpose**: Production-ready branch. Final working version of the app.
- **Deployment target**: Azure App Service (Production Slot)
- **Protection rules**:
  - Pull Requests required
  - Require CI pipeline to pass
  - Require code review approval
  - Block direct pushes

### `development`
- **Purpose**: Integration branch for features under development.
- **Deployment target**: Azure App Service (Staging Slot)
- **Protection rules**:
  - Pull Requests required
  - Require CI pipeline to pass
  - Block direct pushes

### `feature/<feature-name>`
- **Purpose**: Isolated branches for new features, improvements, or testing
- **Created from**: `development`
- **Merge target**: `development` (via PR)
- **Rules**: Direct push allowed, no protection

### `hotfix/<issue>`
- **Purpose**: Urgent fixes for production
- **Created from**: `main`
- **Merge target**: `main` and `development`


## Workflow Summary

   ```bash
   git checkout development
   git pull origin development
   git checkout -b feature/your-feature
   git push -u origin feature/your-feature
   ```

# Example workflow

::: mermaid
graph TD
  A[main]
  B[development]
  F1[feature/appinsights]
  F2[feature/adding-loginpage]
  HF[hotfix/loginpage]

  A -->|Create development branch| B
  B -->|Start feature| F1
  F1 -->|Complete feature| B
  B -->|Start feature| F2
  F2 -->|Complete feature| B
  B -->|Merge development into main| A
  A -->|Start hotfix| HF
  HF -->|Fix and merge hotfix| A
:::

