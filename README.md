<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Cloud Fun Facts – Serverless API (Terraform)</title>
  <style>
    body {
      font-family: Arial, Helvetica, sans-serif;
      line-height: 1.6;
      max-width: 960px;
      margin: auto;
      padding: 40px;
      color: #222;
      background-color: #ffffff;
    }

    h1, h2, h3 {
      color: #0f62fe;
    }

    code {
      background-color: #f4f4f4;
      padding: 4px 6px;
      border-radius: 4px;
      font-size: 0.95em;
    }

    pre {
      background-color: #f4f4f4;
      padding: 16px;
      border-radius: 6px;
      overflow-x: auto;
    }

    ul {
      margin-left: 20px;
    }

    .highlight {
      background: #e8f0fe;
      padding: 16px;
      border-left: 5px solid #0f62fe;
      margin: 24px 0;
    }

    .warning {
      background: #fff3cd;
      padding: 16px;
      border-left: 5px solid #ff9800;
      margin: 24px 0;
    }

    footer {
      margin-top: 60px;
      font-size: 0.9em;
      color: #555;
      text-align: center;
    }
  </style>
</head>

<body>

<h1>☁️ Cloud Fun Facts – Serverless API (Terraform IaC)</h1>

<p>
This project demonstrates a <strong>fully serverless cloud API</strong> built using
<strong>AWS Lambda</strong>, <strong>API Gateway (HTTP API)</strong>, and
<strong>Terraform Infrastructure as Code</strong>.
</p>

<p>
The API returns a random cloud-related fun fact via a public HTTP endpoint and is designed
to stay <strong>within AWS Free Tier limits for as long as possible</strong>.
</p>

---

<h2>📐 Architecture Overview</h2>

<ul>
  <li><strong>AWS Lambda</strong> – Executes Python code to return random cloud facts</li>
  <li><strong>API Gateway (HTTP API)</strong> – Public HTTP endpoint (<code>GET /funfact</code>)</li>
  <li><strong>IAM Role</strong> – Least-privilege execution role for Lambda</li>
  <li><strong>CloudWatch Logs</strong> – Basic execution logging</li>
</ul>

<p>
All resources are provisioned using <strong>Terraform</strong> and deployed in
<strong>ap-southeast-1 (Singapore)</strong>.
</p>

---

<h2>🚀 Deployment</h2>

<pre>
terraform init
terraform plan
terraform apply
</pre>

<p>
After deployment, Terraform outputs the public API endpoint.  
Test it using:
</p>

<pre>
curl &lt;api_endpoint&gt;/funfact
</pre>

---

<h2>💰 Cost Analysis (ap-southeast-1)</h2>

<div class="highlight">
<strong>Summary:</strong> Under normal usage, this project runs at <strong>$0/month</strong>.
</div>

<h3>1️⃣ AWS Lambda</h3>

<ul>
  <li>Free Tier (always available):</li>
  <ul>
    <li>1,000,000 requests / month</li>
    <li>400,000 GB-seconds compute</li>
  </ul>
</ul>

<p>
With a 128 MB function running ~10–20 ms per request, Lambda can handle
<strong>millions of requests per month</strong> without incurring cost.
</p>

<strong>Expected cost:</strong> $0.00

---

<h3>2️⃣ API Gateway (HTTP API)</h3>

<ul>
  <li>Free Tier: 1,000,000 requests / month for 12 months</li>
  <li>After Free Tier: ~<strong>$1 per million requests</strong></li>
</ul>

<table border="1" cellpadding="8" cellspacing="0">
  <tr>
    <th>Requests / Month</th>
    <th>Estimated Cost</th>
  </tr>
  <tr>
    <td>1M</td>
    <td>$0</td>
  </tr>
  <tr>
    <td>10M</td>
    <td>~$9</td>
  </tr>
  <tr>
    <td>100M</td>
    <td>~$99</td>
  </tr>
</table>

<p>
API Gateway is the <strong>first service likely to incur cost</strong> under heavy traffic.
</p>

---

<h3>3️⃣ CloudWatch Logs</h3>

<ul>
  <li>Free Tier: 5 GB ingestion + 5 GB storage per month</li>
  <li>Average logs per request: ~2–3 KB</li>
</ul>

<p>
Even at 1 million requests per month, log usage remains within the free tier.
</p>

<strong>Expected cost:</strong> $0.00

---

<h3>4️⃣ IAM</h3>

<p>
IAM roles and policies are <strong>free of charge</strong>.
</p>

---

<h2>⏳ How Long Can This Run?</h2>

<ul>
  <li><strong>AWS Lambda:</strong> Free tier forever</li>
  <li><strong>IAM:</strong> Free forever</li>
  <li><strong>CloudWatch Logs:</strong> Free within limits</li>
  <li><strong>API Gateway:</strong> 12 months free tier</li>
</ul>

<div class="highlight">
This project can run <strong>indefinitely</strong>.  
After the API Gateway free tier expires, costs remain extremely low
(~$1 per million requests).
</div>

---

<h2>🛡️ Cost Protection Recommendations</h2>

<ul>
  <li>Add API Gateway throttling</li>
  <li>Create an AWS Budget (e.g. $5/month)</li>
  <li>Optionally add AWS WAF for bot protection</li>
</ul>

<div class="warning">
<strong>Important:</strong> Public endpoints should always have rate limiting in production.
</div>

---

<h2>🎯 Why This Project Matters</h2>

<ul>
  <li>100% serverless</li>
  <li>Terraform Associate exam aligned</li>
  <li>Free-tier safe</li>
  <li>Scalable foundation for DynamoDB, GenAI, and frontend integration</li>
</ul>

---

<footer>
  Built with ❤️ using AWS Lambda, API Gateway, and Terraform
</footer>

</body>
</html>
