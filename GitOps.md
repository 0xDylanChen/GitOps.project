# 🚀 DevOps Zero-Cost GitOps Portfolio Checklist

  

這是你的畢業考專案執行清單。目標：**本機建置全套自動化 GitOps 流水線**。

  

## Phase 1: 環境準備 (Local Infrastructure)

- [x] **安裝基礎工具**

    - [x] Install [Docker Desktop](https://www.docker.com/products/docker-desktop/) (or OrbStack/Rancher)

    - [x] Install [Minikube](https://minikube.sigs.k8s.io/docs/start/) (Kubernetes Cluster)

    - [x] Install [kubectl](https://kubernetes.io/docs/tasks/tools/) (K8s CLI)

    - [x] Install [ArgoCD CLI](https://argo-cd.readthedocs.io/en/stable/cli_installation/) (Optional but recommended)

- [x] **啟動 K8s Cluster**

    - [x] Run `minikube start`

    - [x] Verify with `kubectl get nodes` (Should see 'Ready')

  

## Phase 2: 應用程式開發 (The App)

- [x] **Python API**

    - [x] Create `app.py` (FastAPI)

    - [x] Implement Redis connection (Async Read/Write)

- [x] **Containerization**

    - [x] Write `Dockerfile` (Multi-stage build)

    - [x] Build & Test locally: `docker build -t devops-portfolio-api:v0 .`

- [x] **Push to Registry**

    - [x] Create Repo on [Docker Hub](https://hub.docker.com/)

    - [x] Push image: `luck667986/devops-portfolio-api:v0`

  

## Phase 3: 基礎設施即代碼 (IaC & Manifests)

- [x] **K8s Manifests (YAML)**

    - [x] Create `k8s/deployment.yaml` (App Deployment)

    - [x] Create `k8s/service.yaml` (Expose App)

    - [x] Create `k8s/redis.yaml` (Redis Deployment + Service)

- [x] **Manual Test**

    - [x] `kubectl apply -f k8s/`

    - [x] `minikube service devops-portfolio-service` (Verify access in browser)

  

## Phase 4: GitOps 自動化 (The Magic)

- [x] **Install ArgoCD**

    - [x] Install ArgoCD in Minikube:

      ```bash

      kubectl create namespace argocd

      kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

      ```

    - [x] Access UI: `kubectl port-forward svc/argocd-server -n argocd 8080:443`

- [x] **Setup GitOps Pipeline**

    - [x] Put your K8s YAMLs into a GitHub Repo (e.g., `my-devops-project-config`)

    - [x] Connect ArgoCD to this GitHub Repo

    - [x] Enable "Auto Sync"

- [ ] **CI Pipeline (GitHub Actions)**

    - [ ] Create `.github/workflows/ci.yaml`

    - [ ] Task: On git push -> Build Docker Image -> Push to Docker Hub

    - [ ] (Advanced) Task: Update `k8s/deployment.yaml` image tag in the Config Repo

  

## Phase 5: 驗證與截圖 (Portfolio)

- [ ] **Verify End-to-End**

    - [ ] Change `app.py` background color or text

    - [ ] Git Push

    - [ ] Watch GitHub Actions build (Green)

    - [ ] Watch ArgoCD sync (Green)

    - [ ] Check Local Website (Updated!)

- [ ] **Documentation**

    - [ ] Write `README.md` with:

        - [ ] System Architecture Diagram

        - [ ] Screenshots of ArgoCD & GitHub Actions

        - [ ] Explanation of "Why GitOps?"