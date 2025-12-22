<!DOCTYPE html>
<html lang="en">
<body>

<h1>☁️ Cloud Fun Facts – Full-Stack Serverless AI</h1>

<div class="tech-stack">
  <span class="badge">AWS Lambda</span>
  <span class="badge">API Gateway</span>
  <span class="badge">DynamoDB</span>
  <span class="badge">Amazon Bedrock (Claude 3.5)</span>
  <span class="badge">S3 + CloudFront</span>
  <span class="badge">Terraform</span>
</div>

<p>
  This project is a <strong>complete full-stack serverless application</strong> that generates engaging cloud computing facts. It utilizes <strong>Infrastructure as Code (Terraform)</strong> to provision a scalable, AI-enhanced backend and a secure, globally distributed frontend.
</p>


---

<h2>📐 Architecture Overview</h2>

<ul>
  <li><strong>Frontend:</strong> Static HTML/JS hosted on <strong>Amazon S3</strong> and distributed via <strong>Amazon CloudFront</strong> using Origin Access Control (OAC).</li>
  <li><strong>API Layer:</strong> <strong>Amazon API Gateway (HTTP API)</strong> with CORS enabled for cross-origin frontend requests.</li>
  <li><strong>Compute:</strong> <strong>AWS Lambda</strong> running Python 3.13 on <strong>ARM64 (Graviton2)</strong> for cost-efficiency.</li>
  <li><strong>Database:</strong> <strong>Amazon DynamoDB</strong> (On-Demand) storing a library of curated cloud facts.</li>
  <li><strong>AI Integration:</strong> <strong>Amazon Bedrock (Claude 3.5 Sonnet)</strong> used to transform raw facts into witty, engaging content.</li>
</ul>

---

<h2>🚀 Deployment Instructions</h2>

<p>Ensure you have the <a href="https://www.terraform.io/downloads">Terraform CLI</a> installed and AWS credentials configured.</p>

<pre>
# Initialize and connect to Terraform Cloud
terraform init

# Preview changes
terraform plan

# Deploy infrastructure
terraform apply
</pre>

<div class="highlight">
  <strong>Note:</strong> After deployment, the <code>cloudfront_url</code> output will provide your public website address.
</div>

---

<h2>💰 Cost Optimization (Free Tier Optimized)</h2>

<p>This architecture is specifically designed to remain within the <strong>AWS Free Tier</strong> limits:</p>

<table>
  <thead>
    <tr>
      <th>Service</th>
      <th>Optimization Strategy</th>
      <th>Estimated Cost</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Lambda</strong></td>
      <td>ARM64 architecture & 1M free requests/month.</td>
      <td>$0.00</td>
    </tr>
    <tr>
      <td><strong>CloudWatch</strong></td>
      <td><strong>7-day log retention</strong> policy to prevent storage bloat.</td>
      <td>$0.00</td>
    </tr>
    <tr>
      <td><strong>DynamoDB</strong></td>
      <td>Pay-per-request billing.</td>
      <td>$0.00 (under low volume)</td>
    </tr>
    <tr>
      <td><strong>CloudFront</strong></td>
      <td>1TB of free data transfer per month.</td>
      <td>$0.00</td>
    </tr>
    <tr>
      <td><strong>S3</strong></td>
      <td><strong>Lifecycle rules</strong> to expire old versions after 30 days.</td>
      <td>$0.00</td>
    </tr>
  </tbody>
</table>

---

<h2>🛡️ Security & Scalability</h2>

<ul>
  <li><strong>Least Privilege:</strong> Lambda uses a dedicated IAM role with specific access to DynamoDB and Bedrock.</li>
  <li><strong>Origin Protection:</strong> S3 bucket is 100% private; users can only access content via CloudFront OAC.</li>
  <li><strong>Throttling:</strong> API Gateway is limited to 100 requests/sec to prevent cost spikes from bot abuse.</li>
  <li><strong>HTTPS:</strong> Forced SSL redirection via CloudFront.</li>
</ul>

<div class="warning">
  <strong>Bedrock Access:</strong> Ensure you have manually requested access to <strong>Anthropic Claude</strong> models in your AWS Console (Bedrock > Model Access) before running the Lambda.
</div>

---

<footer>
  Built by ShenLoong with ❤️ | Infrastructure powered by Terraform & AWS
</footer>

</body>
</html>