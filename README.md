## Staging/production deployment

### First-time setup

#### 1. Create a GitHub repository and push the initial commit

#### 2. Initialize terraform

From the `terraform` directory, initalize terraform with the following command, which should only be run once (unless the provider/module versions change):

```bash
cd terraform
terraform init
```

#### 3. Create GitHub token and add it to terraform cloud

Create a GitHub token

"Variables" tab, "Add variable", select "Environment variable", with `GITHUB_TOKEN` as key and the token as value.

#### 3. Import the repository into terraform state

```bash
terraform import -var-file=staging.tfvars module.base.github_repository.repo another-doge-test
```

#### 4. Plan and apply

Plan the changes:

```bash
terraform plan -var-file=staging.tfvars
```

review them, and apply:

```bash
terraform apply -var-file=staging.tfvars
```

#### 5. Provide environment secrets

##### Staging

Go to the "Settings" tab in the repository, then "Environments" on the left menu, and there go to "New environment" and name it `staging`. From the page of the created environment, go to "Add secret" and create two secrets with the names and values as follows:

* `DROPLET_IPV4`: with the IP address of the droplet created by `terraform apply` as value, which can be obtained as in `terraform output droplet_ipv4` (remember to ommit the quotes when providing the secret value).
* `TFVARS`: with the base64-encoded `staging.tfvars` as value, which can be obtained as in `base64 staging.tfvars`.

#### 6. Branch protection rules

The following branch protection rules must be set in GitHub.

* `Require a pull request before merging`
* `Require status checks to pass before merging` with `Require branches to be up to date before merging`
* optional `Require linear history`

### Deployment

The actual deployment strategy follows a git-ops workflow.
