# Greetings People 😄 
#### Ths is my DevOps project for a sample website shared from Null Class 

## 🚀 CI/CD with Jenkins

This project uses a Jenkins Declarative Pipeline (`Jenkinsfile`) to automate Docker image builds and pushes to Docker Hub.

### 🧱 Pipeline Stages
1. **Checkout Code** – Clones the GitHub repository.
2. **Build Docker Image** – Builds the image using the project's `Dockerfile`.
3. **Push to Docker Hub** – Authenticates using Jenkins credentials and pushes to the public registry.

### ⚙️ Jenkins Setup
- Install Docker and Docker Pipeline plugins.
- Create a Jenkins credential:
  - **ID:** `dockerhub-credentials`
  - **Type:** Username and Password for Docker Hub
- Create a **Pipeline job** pointing to this GitHub repository.
- Optionally connect GitHub webhook to trigger the pipeline on every commit or pull request.

### 🐳 Docker & Orchestration
- `Dockerfile` builds the static website image (based on Nginx).
- `docker-compose.yml` runs Nginx and Watchtower containers.
- For testing locally:
  ```bash
  docker build -t <your-dockerhub-username>/<your-image-name>:latest .
  docker run -d -p 80:80 <your-dockerhub-username>/<your-image-name>:latest


### 🔧 Configuration Instructions
Before running Terraform or Ansible:
1. Replace placeholder values in the `.tf` and `.ini` files:
   - `key_name`: your AWS EC2 key pair name.
   - `<EC2_PUBLIC_IP>`: the public IP of your EC2 instance.
   - `/path/to/your-key.pem`: path to your private key (do not commit this file).
2. Create dev.tfvars for providing values for the variables in the variables.tf file. 
3. Run `terraform init` and `terraform apply` from the `IaC/` directory.
4. Use the generated EC2 IP in the `ansible/inventory.ini` file before running the playbook.

## 🔐 Security Notice

Sensitive information such as:
- AWS credentials
- EC2 public IPs
- SSH private key paths
- DockerHub credentials

are intentionally excluded from this repository.