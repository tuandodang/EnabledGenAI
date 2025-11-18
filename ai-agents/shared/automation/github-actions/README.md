# GitHub Actions Automation

This directory contains GitHub Actions workflows for automating AI-powered code review and CI/CD pipelines for ASP.NET Core projects.

---

## 📁 Files

| File | Purpose | Trigger |
|------|---------|---------|
| `ci-cd-pipeline.yml` | Complete CI/CD pipeline | Push/PR to main/develop |
| `ai-code-review.yml` | AI-powered code review | Pull requests |

---

## 🚀 Setup Instructions

### 1. Copy Workflows to Your Repository

```bash
# Create workflows directory
mkdir -p .github/workflows

# Copy workflow files
cp ai-agents/shared/automation/github-actions/ci-cd-pipeline.yml .github/workflows/
cp ai-agents/shared/automation/github-actions/ai-code-review.yml .github/workflows/
```

### 2. Configure Repository Secrets

Navigate to: **GitHub Repository → Settings → Secrets and variables → Actions**

Add these secrets:

#### Required Secrets

| Secret Name | Description | How to Get |
|-------------|-------------|------------|
| `ANTHROPIC_API_KEY` | Claude AI API key | https://console.anthropic.com/account/keys |
| `AZURE_WEBAPP_PUBLISH_PROFILE_DEV` | Azure publish profile (dev) | Azure Portal → App Service → Get publish profile |
| `AZURE_WEBAPP_PUBLISH_PROFILE_PROD` | Azure publish profile (prod) | Azure Portal → App Service → Get publish profile |
| `CONTAINER_REGISTRY` | Container registry URL | e.g., `myregistry.azurecr.io` |
| `REGISTRY_USERNAME` | Container registry username | Azure Container Registry settings |
| `REGISTRY_PASSWORD` | Container registry password | Azure Container Registry settings |

#### Optional Secrets

| Secret Name | Description | Required For |
|-------------|-------------|--------------|
| `SNYK_TOKEN` | Snyk security scanning | Security scan job |
| `SLACK_WEBHOOK` | Slack notifications | Notification job |
| `SONAR_TOKEN` | SonarQube analysis | Code quality (if using SonarQube) |

### 3. Set Up Anthropic API Key

#### Get API Key:

```bash
# 1. Sign up at https://console.anthropic.com
# 2. Navigate to Account Settings → API Keys
# 3. Create new API key
# 4. Copy the key (starts with 'sk-ant-...')
```

#### Add to GitHub:

```bash
# Repository → Settings → Secrets → New repository secret
Name: ANTHROPIC_API_KEY
Value: sk-ant-your-api-key-here
```

**Cost:** ~$0.10-$0.50 per review (Claude Sonnet 4.5)

### 4. Configure Branch Protection

**Settings → Branches → Add rule**

Branch name pattern: `main`

Enable:
- ✅ Require status checks to pass before merging
  - Status checks: `build-and-test`, `code-quality`, `security-scan`
- ✅ Require pull request reviews before merging
  - Required approving reviews: 1
- ✅ Require conversation resolution before merging
- ✅ Include administrators

---

## 🔄 Workflow Details

### CI/CD Pipeline (`ci-cd-pipeline.yml`)

#### Jobs:

1. **build-and-test**
   - Builds solution
   - Runs unit tests
   - Collects code coverage
   - Uploads coverage to Codecov
   - Fails if coverage <85%

2. **code-quality**
   - Runs .NET analyzers
   - Runs ReSharper InspectCode
   - Uploads quality reports

3. **security-scan**
   - Runs Snyk vulnerability scan
   - Runs OWASP Dependency Check
   - Fails on high severity issues

4. **docker-build**
   - Builds Docker image
   - Pushes to container registry
   - Tags with branch name and SHA

5. **deploy-dev**
   - Deploys to Azure App Service (dev)
   - Runs smoke tests
   - Triggered on `develop` branch

6. **deploy-prod**
   - Deploys to staging slot
   - Runs smoke tests
   - Swaps to production
   - Triggered on `main` branch

7. **notify**
   - Sends Slack notification
   - Includes status, branch, commit info

#### Trigger:

```yaml
on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]
```

#### Example Usage:

```bash
# Create feature branch
git checkout -b feature/add-product-api

# Make changes and commit
git add .
git commit -m "Add product API endpoints"

# Push to trigger PR workflow
git push origin feature/add-product-api

# Create PR → Triggers build-and-test, code-quality, security-scan

# Merge to develop → Triggers full pipeline + deploy-dev

# Merge to main → Triggers full pipeline + deploy-prod
```

---

### AI Code Review (`ai-code-review.yml`)

#### How It Works:

1. **Triggers on PR** (opened, updated, reopened)
2. **Extracts changed files** (C# files only)
3. **Runs static analysis** (.NET analyzers)
4. **Calls Claude AI** with code review prompt
5. **Analyzes response** for critical/high/medium issues
6. **Posts comment** on PR with review
7. **Adds labels** based on severity
8. **Creates status check** (pass/fail)

#### Review Categories:

| Icon | Category | Action |
|------|----------|--------|
| 🔴 | Critical Issues | Request changes |
| 🟠 | High Priority | Comment |
| 🟡 | Medium Priority | Comment |
| 💡 | Suggestions | Info only |
| ✅ | Positive Observations | Encouragement |

#### Example PR Comment:

```markdown
## 🤖 AI Code Review

**Build Status:** ✅ Success
**Files Changed:** 8
**Reviewed by:** Claude Sonnet 4.5

---

## 🔴 Critical Issues (Fix immediately)

1. **ProductService.cs:45** - Potential SQL injection vulnerability
   - Using string concatenation for query. Use parameterized queries.

2. **ProductController.cs:78** - Missing input validation
   - No validation on `CreateProductRequest`. Add FluentValidation.

## 🟠 High Priority (Should fix)

1. **ProductRepository.cs:120** - N+1 query problem
   - Use `.Include(p => p.Category)` to avoid multiple queries.

2. **ProductService.cs:89** - Missing error handling
   - No try-catch around database operation.

## 🟡 Medium Priority (Consider fixing)

1. **ProductService.cs:34** - Method too long (52 lines)
   - Consider extracting validation logic to separate method.

## 💡 Suggestions

1. Consider using Result<T> pattern instead of throwing exceptions
2. Add XML comments for Swagger documentation

## ✅ Positive Observations

- Good use of async/await throughout
- Proper dependency injection setup
- Clear naming conventions

## Summary

**Recommendation:** REQUEST CHANGES

Fix critical security issues before merging. Otherwise, good structure and follows clean architecture principles.

---

<sub>💡 This is an automated review. Please also conduct manual code review.</sub>
```

#### Configuration:

Customize review prompt in `ai-code-review.yml` around line 150:

```python
prompt = f"""You are an expert C# code reviewer...

Focus on:
- YOUR CUSTOM FOCUS AREAS
- YOUR TEAM STANDARDS
- YOUR SPECIFIC REQUIREMENTS

[rest of prompt]
"""
```

---

## 💰 Cost Estimation

### Anthropic API (Claude Sonnet 4.5)

| Metric | Cost |
|--------|------|
| Input | $3 / million tokens |
| Output | $15 / million tokens |

**Per review estimate:**
- Small PR (5 files, 500 lines): ~10k tokens → **$0.10**
- Medium PR (15 files, 1500 lines): ~30k tokens → **$0.30**
- Large PR (30 files, 3000 lines): ~60k tokens → **$0.60**

**Monthly estimate:**
- 100 PRs/month (avg medium): **$30/month**
- 200 PRs/month (avg medium): **$60/month**

**Note:** Way cheaper than human code review time!

---

## 🔧 Customization

### Modify AI Review Focus

Edit `ai-code-review.yml`, find the prompt section:

```python
prompt = f"""You are an expert C# code reviewer specializing in ASP.NET Core applications.

Please review the following code changes and provide:

[ADD YOUR CUSTOM INSTRUCTIONS HERE]

Focus on:
- [YOUR FOCUS AREA 1]
- [YOUR FOCUS AREA 2]
- [YOUR FOCUS AREA 3]
```

### Add Custom Static Analysis

```yaml
- name: Run custom analysis
  run: |
    # Add your custom static analysis tools
    dotnet tool install --global your-custom-tool
    your-custom-tool analyze ./src
```

### Change Coverage Threshold

```yaml
- name: Check code coverage threshold
  run: |
    # Change 85 to your desired threshold
    if (( $(echo "$coverage_percent < 85" | bc -l) )); then
      echo "❌ Code coverage below threshold"
      exit 1
    fi
```

---

## 📊 Metrics & Monitoring

### View Workflow Runs

```
Repository → Actions → Select workflow → View runs
```

### Download Artifacts

```
Workflow run → Artifacts section → Download
```

Artifacts include:
- Test results (`.trx` files)
- Coverage reports (`.opencover.xml`)
- ReSharper reports
- OWASP reports
- AI review outputs

### Monitor Costs

Anthropic Console → Usage → View API usage

---

## 🐛 Troubleshooting

### AI Review Not Running

**Check:**
1. `ANTHROPIC_API_KEY` secret is set
2. Python dependencies installed correctly
3. API key is valid (not expired)

**Debug:**
```bash
# Check workflow logs
Actions → ai-code-review → View logs

# Look for errors in "Run AI Code Review" step
```

### Coverage Check Failing

**Fix:**
```yaml
# Temporarily disable coverage check
- name: Check code coverage threshold
  run: |
    echo "Coverage check disabled"
  continue-on-error: true
```

### Build Failing

**Check:**
```bash
# Run locally first
dotnet build
dotnet test

# Fix issues, then push
```

---

## 📚 Additional Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Anthropic API Documentation](https://docs.anthropic.com/claude/reference/getting-started)
- [.NET DevOps Best Practices](https://docs.microsoft.com/en-us/dotnet/devops/)
- [Azure DevOps Integration](https://docs.microsoft.com/en-us/azure/devops/)

---

## ✅ Quick Start Checklist

- [ ] Copy workflows to `.github/workflows/`
- [ ] Set up `ANTHROPIC_API_KEY` secret
- [ ] Set up Azure secrets (if deploying)
- [ ] Configure branch protection rules
- [ ] Test with a small PR
- [ ] Review AI feedback quality
- [ ] Adjust prompts if needed
- [ ] Monitor costs in Anthropic console
- [ ] Share with team

---

**Questions?** Check the troubleshooting guide or open an issue.
