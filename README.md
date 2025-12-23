<div>
  <h1>☁️ Cloud Fun Facts Generator</h1>
  <p>
    An AI-powered serverless application built with Terraform, AWS Lambda, and Amazon Bedrock.
    <br />
    <a href="#about-the-project"><strong>Explore the docs »</strong></a>
  </p>
</div>

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about-the-project">About The Project</a></li>
    <li><a href="#built-with">Built With</a></li>
    <li><a href="#architecture">Architecture</a></li>
    <li><a href="#getting-started">Getting Started</a></li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#cost-optimization">Cost Optimization</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

<h2 id="about-the-project">About The Project</h2>
<p>
  A full-stack, AI-enhanced serverless application designed to bridge the gap between isolated tutorials and real-world architecture. This project demonstrates a production-ready flow where Terraform manages a high-performance backend and a secure frontend.
</p>
<div align="right"><a href="#readme-top">↑ Back to Top</a></div>

<h2 id="built-with">Built With</h2>
<ul>
  <li><strong>Terraform Cloud</strong> - Infrastructure Provisioning & State Management</li>
  <li><strong>AWS Lambda (Python 3.13)</strong> - Serverless Logic</li>
  <li><strong>AWS API Gateway</strong> - Secure HTTP Endpoints</li>
  <li><strong>Amazon DynamoDB</strong> - NoSQL Fact Storage</li>
  <li><strong>Amazon Bedrock (Claude 3.5)</strong> - AI Content Transformation</li>
  <li><strong>Amazon S3 & CloudFront</strong></li>
</ul>
<div align="right"><a href="#readme-top">↑ Back to Top</a></div>

<h2 id="architecture">Architecture</h2>
<p align="center">
  <img src="Diagram/architecture.jpg" alt="Architecture Diagram" width="800">
</p>
<p>
  The application follows a modern serverless flow:
  <br>
  <code>User Browser</code> ➔ <code>CloudFront</code> ➔ <code>S3 (Frontend)</code>
  <br>
  <code>User Browser</code> ➔ <code>API Gateway</code> ➔ <code>Lambda</code> ➔ <code>DynamoDB (Fetch)</code> ➔ <code>Bedrock AI (Transform)</code>
</p>
<div align="right"><a href="#readme-top">↑ Back to Top</a></div>

<h2 id="getting-started">Getting Started</h2>
<h3>Prerequisites</h3>
<ul>
  <li>AWS Account with Bedrock Claude 3.5 model access enabled.</li>
  <li>Terraform CLI (v1.5.0+) installed locally.</li>
  <li>Terraform Cloud account for remote state management.</li>
</ul>
<div align="right"><a href="#readme-top">↑ Back to Top</a></div>

<h3>Installation</h3>
<ol>
  <li>Clone the repo</li>
  <li>Initialize Terraform: <code>terraform init</code></li>
  <li>Deploy to AWS: <code>terraform apply</code></li>
</ol>
<div align="right"><a href="#readme-top">↑ Back to Top</a></div>

<h2 id="usage">Usage & Testing</h2>
<p>Once deployment is complete, Terraform provides two key outputs:</p>
<ul>
  <li><strong>Web Interface:</strong> Access the live site at the <code>cloudfront_url</code> (e.g., <code>https://d11a5c37xehwja.cloudfront.net</code>).</li>
  <li><strong>REST API:</strong> Test the raw backend directly at the <code>api_invoke_url</code>:
    <br><code>curl https://g1kcof6nl1.execute-api.ap-southeast-1.amazonaws.com/funfact</code>
  </li>
</ul>
<div align="right"><a href="#readme-top">↑ Back to Top</a></div>

<h2 id="roadmap">Project Roadmap</h2>
<ul>
  <li>[x] <strong>Basic Version:</strong> Core logic with Lambda + API Gateway integration.</li>
  <li>[x] <strong>Database Version:</strong> Persistence layer using DynamoDB to store and scale facts.</li>
  <li>[x] <strong>GenAI Version:</strong> Integration with Amazon Bedrock to make facts witty and engaging.</li>
  <li>[x] <strong>Frontend Distribution:</strong> Static site hosting via S3 with CloudFront (OAC) for global speed and security.</li>
</ul>
<div align="right"><a href="#readme-top">↑ Back to Top</a></div>

<h2 id="cost-optimization">Cost Optimization (Free Tier)</h2>
<p>This project is architected to run at <strong>$0/month</strong> for standard testing volumes:</p>
<ul>
  <li><strong>Lambda:</strong> Using <strong>ARM64</strong> architecture for better price-performance.</li>
  <li><strong>Storage:</strong> S3 lifecycle rules to automatically clean up old files after 30 days.</li>
  <li><strong>Logging:</strong> 7-day retention on CloudWatch logs to prevent storage costs.</li>
  <li><strong>Throttling:</strong> API limits (100 req/s) to prevent unexpected usage spikes.</li>
</ul>
<div align="right"><a href="#readme-top">↑ Back to Top</a></div>

<h2 id="contact">Contact</h2>
<p>Tan Si Kai - <a href="https://linkedin.com/in/si-kai-tan">LinkedIn</a></p>
<p>Project Link: <a href="https://https://github.com/ShenLoong99/AWS-Cloud-Fun-Facts-Generator">Cloud Fun Facts</a></p>
<div align="right"><a href="#readme-top">↑ Back to Top</a></div>