<a id="readme-top"></a>
<div>
   <h1>🤖 AWS Lex AI-Translator Bot</h1>
   <p align="center"> <img src="assets/aws-lex-chatbot-cover.png" alt="aws-lex-chatbot-cover" width="800">
   </p>
   <p> The <strong>AWS Lex AI-Translator</strong> is a sophisticated serverless solution that leverages natural language understanding (NLU) to translate user phrases into multiple languages instantly. By combining <strong>Amazon Lex V2</strong> for conversation management and <strong>Amazon Translate</strong> for high-fidelity linguistics, this project demonstrates a production-ready "Hybrid" IaC workflow. <br /> <a href="#about-the-project"><strong>Explore the docs »</strong></a> </p>
</div>
<details>
   <summary>Table of Contents</summary>
   <ol>
      <li><a href="#about-the-project">About The Project</a></li>
      <li><a href="#built-with">Built With</a></li>
      <li><a href="#use-cases">Use Cases</a></li>
      <li><a href="#architecture">Architecture</a></li>
      <li><a href="#getting-started">Getting Started</a></li>
      <li><a href="#usage">Usage & Testing</a></li>
      <li><a href="#roadmap">Roadmap</a></li>
      <li><a href="#cost-optimization">Cost Optimization</a></li>
      <li><a href="#contact">Contact</a></li>
   </ol>
</details>
<h2 id="about-the-project">About The Project</h2>
<p> This project showcases an advanced <strong>Serverless AWS architecture</strong> managed through <strong>Infrastructure as Code (IaC)</strong>. Unlike standard automation, this project utilizes a professional "Hybrid" deployment model: critical infrastructure (IAM, Lambda, Logging) is managed via <strong>Terraform</strong>, while the high-iteration Conversational Design (Intents, Slots, Utterances) is refined within the <strong>AWS Lex V2 Console</strong> for rapid testing. </p>
<div align="right"><a href="#readme-top">↑ Back to Top</a></div>
<h2 id="built-with">Built With</h2>
<p> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/terraform/terraform-original.svg" alt="terraform" width="45" height="45" style="margin: 10px;"/> <img src="https://raw.githubusercontent.com/weibeld/aws-icons-svg/main/q1-2022/Architecture-Service-Icons_01312022/Arch_Machine-Learning/48/Arch_Amazon-Lex_48.svg" alt="lex" width="45" height="45" style="margin: 10px;"/> <img src="https://raw.githubusercontent.com/weibeld/aws-icons-svg/main/q1-2022/Architecture-Service-Icons_01312022/Arch_Machine-Learning/48/Arch_Amazon-Translate_48.svg" alt="translate" width="45" height="45" style="margin: 10px;"/> <img src="https://raw.githubusercontent.com/weibeld/aws-icons-svg/main/q1-2022/Architecture-Service-Icons_01312022/Arch_Compute/48/Arch_AWS-Lambda_48.svg" alt="lambda" width="45" height="45" style="margin: 10px;"/> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/python/python-original.svg" alt="python" width="45" height="45" style="margin: 10px;"/> </p>
<ul>
   <li><strong>Terraform:</strong> Deploys the backend "engine," including IAM roles, Lambda triggers, and CloudWatch log groups.</li>
   <li><strong>Amazon Lex V2:</strong> Manages the conversational flow and extracts "phrase" and "target_language" slots from user input.</li>
   <li><strong>Amazon Translate:</strong> Provides the core translation logic with automatic source language detection.</li>
   <li><strong>AWS Lambda:</strong> A Python-based fulfillment engine that bridges Lex and Translate.</li>
   <li><strong>CloudWatch Logs:</strong> Explicitly managed in Terraform to ensure full observability and clean removal upon destruction.</li>
</ul>
<div align="right"><a href="#readme-top">↑ Back to Top</a></div>
<h2 id="use-cases">Use Cases</h2>
<ul>
   <li><strong>Global Business Operations:</strong> Facilitates seamless communication between companies and their international clients by bridging language gaps in real-time.</li>
   <li><strong>Travel & Tourism:</strong> Assists travelers in interacting with locals in foreign countries, enabling clearer communication for everyday needs.</li>
</ul>
<h3>Why Not Existing Translation Apps?</h3>
<ul>
   <li><strong>Industry-Specific Vocabulary:</strong> Amazon Lex (via Amazon Translate) allows for customization to handle technical terms, industry jargon, and domain-specific language that standard apps often mistranslate.</li>
   <li><strong>Tailored Services:</strong> Businesses can define their own terminology and rules—such as keeping brand names untranslated—to ensure the output remains contextual and accurate to their brand.</li>
</ul>
<div align="right"><a href="#readme-top">↑ Back to Top</a></div>
<h2 id="architecture">Architecture</h2>
<p> The architecture is built for high availability and least-privilege security: </p>
<ol>
   <li><strong>Interaction:</strong> The user speaks or types a phrase into the Lex V2 interface.</li>
   <li><strong>NLU Extraction:</strong> Lex identifies the <code>TranslateIntent</code> and collects required slots (phrase and language).</li>
   <li><strong>Fulfillment:</strong> Lex triggers the <code>LexTranslationHandler</code> Lambda function.</li>
   <li><strong>Translation API:</strong> Lambda calls Amazon Translate with <code>SourceLanguageCode="auto"</code> for seamless detection.</li>
   <li><strong>Response:</strong> The translated text is wrapped in a Lex-compliant JSON structure and returned to the user.</li>
</ol>
<div align="right"><a href="#readme-top">↑ Back to Top</a></div>
<h2 id="getting-started">Getting Started</h2>
<h3>1. Prerequisites</h3>
<ul>
   <li><strong>Terraform CLI (v1.0+) / Terraform Cloud(optional)</strong> for IaC deployment.</li>
   <li><strong>AWS CLI</strong> configured with appropriate credentials.</li>
   <li><strong>Python 3.9+</strong> for Lambda development.</li>
</ul>
<h3>2. Installation & Deployment</h3>
<ol>
   <li>Clone the repository.</li>
   <li>
      Initialize the environment: 
      <pre>terraform init</pre>
   </li>
   <li>
      Apply the backend infrastructure: 
      <pre>terraform apply</pre>
   </li>
</ol>
<h3>2. Configure Lex V2 Console</h3>
<p>Follow these steps to build the conversational layer: </p>
<h4>Create Bot: </h4>
<ol>
  <li>In the <strong>Amazon Lex V2 Console</strong>, click <strong>Create bot</strong>.</li>
  <li>Creation method: Select <code>Create</code> (which is the <strong>manual/traditional</strong> path).</li>
  <li>Bot configuration: Name it <code>TranslationBot</code>.</li>
  <li>IAM permissions: Select <code>Create a role with basic Amazon Lex permissions</code>.</li>
  <li><strong>Children’s Online Privacy Protection Act (COPPA):</strong> Select <code>No</code> (assuming this is for a portfolio/demo).</li>
  <li><strong>Idle session timeout:</strong> Keep the default (5 minutes).</li>
  <li><strong>Select Language:</strong> Choose English (US) (or your preferred primary language).</li>
  <li><strong>Voice interaction:</strong> Choose <code>None</code> (since we are focusing on text-based translation for this project).</li>
  <li>Click Done.</li>
</ol>

<h4>Create a Custom "Language" Slot: </h4>
<ol>
  <li>In the Lex Console left-hand menu, click <strong>Slot types</strong>.</li>
  <li>Click <strong>Add slot type</strong> -> <strong>Add blank slot type</strong>.</li>
  <li>Name it <code>SupportedLanguages</code>.</li>
  <li>
    Add values like:
    <ul>
      <li><code>Spanish</code> (Value: <code>es</code>)</li>
      <li><code>French</code> (Value: <code>fr</code>)</li>
      <li><code>German</code> (Value: <code>de</code>)</li>
      <li><code>Chinese</code> (Value: <code>zh</code>)</li>
      <li><code>Japanese</code> (Value: <code>ja</code>)</li>
    </ul>
  </li>
  <li>Important: In the <code>Slot value resolution</code> section, select <code>Restrict to slot values</code>. This ensures the user must pick a language your code can handle.</li>
  <li>Click Done.</li>
</ol>
<img src="assets/aws-console-slot-type-config-page.png" alt="aws-console-slot-type-config-page" width="400" />

<h4>Create Intent & Define Slots: </h4>
<ol>
  <li><strong>Create Intent:</strong> Add a new intent named <code>TranslateIntent</code>.</li>
  <li>
    <strong>Sample Utterances:</strong> Type and add these:
    <pre>Translate something for me</pre>
    <pre>I need a translation</pre>
    <pre>Can you translate a phrase?</pre>
  </li>
  <li>
    Slots (The Data Points): Scroll down to the "Slots" section and create:
    <ol>
      <li>
        <strong>Slot 1:</strong>
        <ol>
          <li>Name: <code>phrase</code></li>
          <li>Slot type: <code>AMAZON.FreeFormInput</code></li>
          <li>Prompt: <code>What text would you like to translate?</code></li>
        </ol>
      </li>
      <li>
        <strong>Slot 2:</strong>
        <ol>
          <li>Name: <code>target_language</code></li>
          <li>Slot type: <code>SupportedLanguages</code></li>
          <li>Prompt: <code>What language should I translate it to? (es. fr, da, zh, ja)</code></li>
        </ol>
      </li>
    </ol>
  </li>
  <li>Save Intent</li>
</ol>

<h4>Link Lambda: </h4>
<ol>
  <li>On the left sidebar, go to <strong>Deployment -> Aliases</strong>.</li>
  <li>Select <strong>TestBotAlias</strong>, then your language (e.g., <strong>English (US)</strong>).</li>
  <li>
    Under <strong>Source</strong>, select your Lambda function (<code>LexTranslationHandler</code>) and the version (<code>$LATEST</code>).<br>
    <img src="assets/aws-console-link-lambda.png" alt="aws-console-slot-type-config-page" width="400" />
  </li>
  <li>
    <strong>Enable Fulfillment:</strong> Go back to your <code>TranslateIntent</code> editor. Scroll to <strong>Fulfillment</strong>, click <strong>Advanced options</strong>, and check <code>Use a Lambda function for fulfillment</code>.<br>
    <img src="assets/aws-console-fulfillment.png" alt="aws-console-slot-type-config-page" width="400" />
  </li>
</ol>

<div align="right"><a href="#readme-top">↑ Back to Top</a></div>
<h2 id="usage">Usage & Testing</h2>
<h3>Boundary Test (Slot Elicitation): </h3>
<ol>
   <li>
      <strong>Trigger the Intent (Turn 1):</strong> 
      <ul>
         <li><strong>User Types:</strong> <code>"I want to translate something"</code> or just <code>"Translate"</code></li>
         <li><strong>What to look for:</strong> The bot should identify the <code>TranslateIntent</code>. Since the phrase and <code>target_language</code> slots are empty, Lex should look at your slot configuration and trigger the first required prompt</li>
      </ul>
   </li>
   <li>
      <strong>The First Elicitation (Turn 2):</strong> 
      <ul>
         <li><strong>Bot Responds:</strong> <code>"What text would you like me to translate?"</code> (or whatever prompt you set for the <code>phrase</code> slot).</li>
         <li><strong>User Types:</strong> <code> "The weather is beautiful today."</code></li>
         <li><strong>What to look for:</strong> Lex should capture this entire string as the <code>phrase</code> value and internally move to the next missing slot.</li>
      </ul>
      <img src="assets/chatbot-test-output-1.png" alt="aws-console-slot-type-config-page" width="400" />
   </li>
   <li>
      <strong>The Second Elicitation (Turn 3):</strong> 
      <ul>
         <li><strong>Bot Responds:</strong> <code>"What language should I translate it to?"</code></li>
         <li><strong>User Types:</strong> <code>"User Types"</code> or <code>es</code></li>
         li><strong>What to look for:</strong> Once this last piece of data is collected, Lex should finally trigger the Fulfillment (calling your Lambda function).</li>
      </ul>
      <img src="assets/chatbot-test-output-2.png" alt="aws-console-slot-type-config-page" width="400" />
   </li>
   <li>
      <strong>The Fulfillment (Final Turn):</strong> 
      <ul>
         <li><strong>Bot Responds:</strong> <code>"Here is the translation: El tiempo es hermoso hoy."</code></li>
      </ul>
   </li>
</ol>
<h3>Other Testing Checklist: </h3>
<ol>
   <li>
      <strong>Multiple Language Test:</strong> 
      <ul>
         <li>Test at least three different target languages (e.g., Spanish <code>es</code>, French <code>fr</code>, and Japanese <code>ja</code>)</li>
         <li><strong>Check:</strong> Does the Lambda return a unique, correct translation for each?</li>
      </ul>
   </li>
   <li>
      <strong>Fallback Intent Check:</strong> 
      <ul>
         <li>Type something gibberish like <em>"asdfghjkl"</em></li>
         <li><strong>Check:</strong> Does the bot trigger the <code>FallbackIntent</code> instead of crashing? This confirms your "Intent Recognition" is working correctly.</li>
      </ul>
   </li>
</ol>
<div align="right"><a href="#readme-top">↑ Back to Top</a></div>
<h2 id="roadmap">Roadmap</h2>
<ul>
   <li>[x] Provision IAM roles and least-privilege policies via Terraform.</li>
   <li>[x] Deploy Python Lambda with <code>boto3</code> Translate integration.</li>
   <li>[x] Implement automatic source language detection using Amazon Comprehend permissions.</li>
   <li>[x] Configure Lex V2 Slot Elicitation for "phrase" and "target_language".</li>
</ul>
<div align="right"><a href="#readme-top">↑ Back to Top</a></div>
<h2 id="cost-optimization">Cost Optimization</h2>
<ul>
   <li><strong>Resource Limits:</strong> Lambda is restricted to 128MB memory and a 10s timeout to prevent runaway billing.</li>
   <li><strong>Log Retention:</strong> CloudWatch logs are set to a 7-day retention period rather than "Never Expire" to minimize storage costs.</li>
   <li><strong>Explicit Cleanup:</strong> Every resource, including auto-generated log groups, is tracked by Terraform to ensure $0 residual cost after <code>terraform destroy</code>.</li>
</ul>
<div align="right"><a href="#readme-top">↑ Back to Top</a></div>
<h2 id="contact">Contact</h2>
<p>Tan Si Kai - <a href="https://linkedin.com/in/si-kai-tan">LinkedIn</a></p>
<p>Project Link: <a href="https://github.com/ShenLoong99/my-terraform-aws-projects-2025/tree/main/AWS-lex-translator">AWS Lex AI-Translator Repo</a></p>
<div align="right"><a href="#readme-top">↑ Back to Top</a></div>