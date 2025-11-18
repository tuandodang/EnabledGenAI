# Prompt Template: Architecture Decision Record (ADR)

## Master Prompt

```
You are an expert software architect. Create a comprehensive Architecture Decision
Record (ADR) following industry best practices.

# Context

Project: [PROJECT_NAME]
Decision Topic: [DECISION_TOPIC]
Date: [DATE]

# Background

[PROVIDE BACKGROUND INFORMATION AND CONTEXT FOR THE DECISION]

# Problem Statement

[CLEARLY STATE THE PROBLEM OR DECISION THAT NEEDS TO BE MADE]

# Constraints

[LIST ANY CONSTRAINTS - Technical, Budget, Timeline, Regulatory]

# Task

Create an ADR following this structure:

## 1. Title
- Clear, descriptive title
- Format: "ADR-[NUMBER]: [Decision Title]"

## 2. Status
- Current status: Proposed | Accepted | Deprecated | Superseded

## 3. Context
- What is the issue we're seeing that is motivating this decision?
- What are the forces at play?
- Business drivers
- Technical drivers

## 4. Decision Drivers
- Key factors influencing this decision
- Priorities (e.g., performance vs cost)
- Stakeholder concerns

## 5. Considered Options
For EACH option provide:
- Description
- Pros (minimum 3)
- Cons (minimum 3)
- Cost estimate (if applicable)
- Implementation effort (Low/Medium/High)
- Risk level (Low/Medium/High)

Provide at least 3 options.

## 6. Decision
- Clear statement of the chosen option
- Justification with specific reasons
- How this aligns with architectural principles

## 7. Consequences

### Positive
- Benefits of this decision
- What improves

### Negative
- Trade-offs accepted
- Technical debt incurred
- What we're giving up

### Neutral
- Changes that are neither positive nor negative

## 8. Implementation

- Implementation steps
- Timeline estimate
- Resource requirements
- Dependencies

## 9. Validation

- How to validate this decision
- Success metrics
- Review timeline

## 10. Related Decisions

- Links to related ADRs
- Decisions this supersedes
- Decisions that depend on this

# Output Format

Provide complete ADR in markdown format, ready to commit to repository.

# Quality Standards

- Be objective and analytical
- Provide concrete evidence for claims
- Consider multiple perspectives
- Be honest about trade-offs
- Include quantitative data where possible
- Use clear, professional language
```

---

## Example Usage

### Quick ADR Prompt

```
Create an ADR for:

**Decision:** [e.g., "Choose database for e-commerce platform"]

**Context:**
- [Background information]
- [Current situation]

**Options to Consider:**
1. [Option 1 - e.g., PostgreSQL]
2. [Option 2 - e.g., MongoDB]
3. [Option 3 - e.g., MySQL]

**Key Requirements:**
- [Requirement 1]
- [Requirement 2]

**Constraints:**
- [Constraint 1]
- [Constraint 2]

Please provide a complete ADR with all sections, comparing all options objectively.
```

---

## Common ADR Topics

### Infrastructure Decisions
- Cloud provider selection (AWS vs Azure vs GCP)
- Container orchestration (Kubernetes vs ECS vs Fargate)
- Database selection (SQL vs NoSQL)
- Caching strategy (Redis vs Memcached)
- CDN selection

### Architecture Pattern Decisions
- Microservices vs Monolith
- Event-driven vs Request-driven
- Synchronous vs Asynchronous communication
- API style (REST vs GraphQL vs gRPC)
- Authentication approach (JWT vs Session)

### Technology Stack Decisions
- Programming language selection
- Framework selection (Spring Boot vs Express vs Django)
- Frontend framework (React vs Vue vs Angular)
- Mobile approach (Native vs React Native vs Flutter)
- Testing framework selection

### DevOps Decisions
- CI/CD tool selection (Jenkins vs GitHub Actions vs GitLab CI)
- IaC tool selection (Terraform vs CloudFormation vs Pulumi)
- Monitoring solution (Datadog vs New Relic vs CloudWatch)
- Log aggregation (ELK vs Splunk vs CloudWatch Logs)

---

## Example ADR Output

```markdown
# ADR-001: Database Selection for E-Commerce Platform

## Status
**Proposed** - Pending stakeholder review

## Context

We are building a new e-commerce platform that will handle:
- 100K concurrent users
- 10K orders per day
- Product catalog of 100K items
- Complex inventory management
- Real-time pricing and promotions
- Order tracking and history
- Customer reviews and ratings

We need a database that can:
- Handle high read/write throughput
- Support ACID transactions for orders
- Provide fast product search
- Scale horizontally
- Maintain data consistency

## Decision Drivers

1. **Performance:** Sub-100ms query response time for product searches
2. **Scalability:** Must scale to 10x current load
3. **Consistency:** ACID guarantees for financial transactions
4. **Cost:** Optimize for operational costs at scale
5. **Team Expertise:** Team has more SQL experience
6. **Ecosystem:** Rich tooling and library support

## Considered Options

### Option 1: PostgreSQL

**Description:** Open-source relational database with advanced features

**Pros:**
- Strong ACID guarantees for transactions
- Excellent JSON support for flexible schemas
- Advanced indexing (B-tree, GiST, GIN)
- Full-text search capabilities
- Mature ecosystem and tooling
- Team expertise already exists
- Cost-effective (open source)
- Proven at scale (Instagram, Uber)

**Cons:**
- Vertical scaling limits (requires sharding for massive scale)
- More complex replication setup than some alternatives
- Requires more operational expertise for optimization

**Cost:** $500-1000/month (AWS RDS Multi-AZ)
**Implementation Effort:** Low (team familiar)
**Risk Level:** Low

### Option 2: MongoDB

**Description:** Document-oriented NoSQL database

**Pros:**
- Flexible schema for varying product types
- Built-in horizontal scaling (sharding)
- Fast for high write throughput
- Good for catalog data with varying attributes
- Developer-friendly JSON-like documents

**Cons:**
- Weaker consistency guarantees (eventual consistency)
- Less suitable for financial transactions
- Team has limited MongoDB experience
- More expensive at scale
- No native JOIN support
- Occasional data anomalies reported

**Cost:** $800-1500/month (MongoDB Atlas)
**Implementation Effort:** Medium (learning curve)
**Risk Level:** Medium

### Option 3: Amazon Aurora PostgreSQL

**Description:** AWS-managed PostgreSQL-compatible database

**Pros:**
- PostgreSQL compatibility (familiar)
- Better scalability than vanilla PostgreSQL
- Automated backups and failover
- Read replicas for scaling reads
- Fully managed (less ops overhead)
- High availability built-in
- Performance improvements over PostgreSQL

**Cons:**
- Higher cost than self-managed PostgreSQL
- AWS vendor lock-in
- Some PostgreSQL extensions not supported
- Migration to other clouds difficult

**Cost:** $1200-2000/month (production setup)
**Implementation Effort:** Low (PostgreSQL compatible)
**Risk Level:** Low

### Option 4: MySQL

**Description:** Popular open-source relational database

**Pros:**
- ACID transactions
- Wide industry adoption
- Good performance for read-heavy workloads
- Mature ecosystem
- Lower resource usage than PostgreSQL

**Cons:**
- Less advanced features than PostgreSQL
- Weaker JSON support
- Less sophisticated query optimizer
- Team prefers PostgreSQL
- Limited full-text search

**Cost:** $400-900/month (AWS RDS Multi-AZ)
**Implementation Effort:** Low
**Risk Level:** Low

## Decision

**We will use Amazon Aurora PostgreSQL** for the following reasons:

1. **Best of Both Worlds:** Combines PostgreSQL's robust features with cloud-native scalability
2. **Transaction Safety:** ACID guarantees essential for order processing and payments
3. **Team Expertise:** Leverages existing PostgreSQL knowledge
4. **Scalability:** Aurora's architecture handles our growth projections
5. **Operational Efficiency:** Managed service reduces DevOps overhead
6. **Performance:** Aurora's improvements benefit our read-heavy workload
7. **Risk Mitigation:** Proven technology with low learning curve

The additional cost (~$700/month vs self-managed) is justified by:
- Reduced DevOps time (estimated 20 hours/month saved = $4K/month)
- Better uptime SLA (99.95% vs 99.9%)
- Faster scaling capabilities
- Lower risk of data loss

## Consequences

### Positive
- Team can start development immediately (no learning curve)
- Strong data consistency for critical transactions
- Excellent query capabilities for complex reporting
- Reduced operational overhead with managed service
- High availability out of the box
- Easy to add read replicas for scaling

### Negative
- AWS vendor lock-in (migration to other clouds more difficult)
- Higher infrastructure cost than open-source PostgreSQL
- Some PostgreSQL extensions may not be available
- Less flexibility in low-level database configuration

### Neutral
- Standard SQL interface (familiar to team)
- Requires normal PostgreSQL optimization practices
- Monitoring through AWS CloudWatch

## Implementation

### Phase 1: Setup (Week 1)
1. Provision Aurora PostgreSQL cluster in us-east-1
2. Configure security groups and VPC
3. Set up read replicas (2x for high availability)
4. Configure automated backups (30-day retention)
5. Set up CloudWatch monitoring and alarms

### Phase 2: Development (Weeks 2-4)
1. Design database schema
2. Create migration scripts (Flyway)
3. Implement data access layer
4. Set up connection pooling (HikariCP)

### Phase 3: Testing (Week 5)
1. Load testing with production-like data
2. Failover testing
3. Performance optimization
4. Query tuning

### Timeline
- Total: 5 weeks
- Resources: 1 DevOps engineer, 2 backend developers

### Dependencies
- AWS account with appropriate permissions
- VPC and networking configuration
- Backup strategy defined

## Validation

### Success Metrics
- Query response time < 100ms (p95)
- Transaction throughput > 1000 TPS
- Uptime > 99.95%
- Failover time < 60 seconds
- Cost within budget ($2000/month)

### Review Timeline
- **3 months:** Review performance metrics and costs
- **6 months:** Evaluate scaling capabilities under load
- **12 months:** Assess total cost of ownership vs alternatives

### Rollback Plan
If critical issues arise:
1. Export data to PostgreSQL RDS (compatible)
2. Switch connection strings
3. Estimated rollback time: 4 hours

## Related Decisions
- ADR-002: Caching strategy (depends on database choice)
- ADR-003: Read replica scaling policy
- ADR-010: Backup and disaster recovery strategy

## References
- [Aurora PostgreSQL Performance](https://aws.amazon.com/rds/aurora/performance/)
- [PostgreSQL vs MongoDB Benchmarks](https://example.com)
- Internal: Load testing results (Q4 2024)

---

**Author:** John Doe, Lead Architect
**Date:** 2024-11-18
**Reviewers:** CTO, Engineering Manager, DevOps Lead
**Approval Date:** Pending
```

---

## Tips for Creating ADRs

1. **Be Objective:** Don't bias toward your preferred option
2. **Use Data:** Include benchmarks, cost estimates, metrics
3. **Consider Consequences:** Think long-term, not just immediate
4. **Be Honest:** Acknowledge trade-offs and limitations
5. **Include Stakeholders:** Get input from affected teams
6. **Keep Updated:** Mark as superseded when decisions change
7. **Link Related:** Create a web of related decisions

---

## Version

- **Template Version:** 1.0
- **Last Updated:** 2024-11-18
- **Compatible With:** Claude Sonnet 4.5
