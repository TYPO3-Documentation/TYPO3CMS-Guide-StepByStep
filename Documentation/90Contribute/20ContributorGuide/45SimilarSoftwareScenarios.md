# Strategy for similar software scenarios

Sometimes, the task is basically the same — but not quite. Installing TYPO3 on Windows isn’t that different from doing it on Ubuntu. Apache and Nginx both serve pages just fine. But the commands, quirks, and gotchas? They diverge fast.

So how do we write guides that are helpful without repeating ourselves endlessly?

TYPO3 step-by-step guides follow a **single-path principle**, so we create one guide per software scenario. This brings SEO opportunities but does increase the risk of content duplication and maintenance.

## One guide per scenario — optimized for SEO

* **SEO visibility**: Each guide title becomes a unique, keyword-targeted entry point.  
* **Clarity:** One guide, one clear path — no branching or conditional steps.

Example hierarchy:

└── Getting Started  
    └── Installation  
        └── Local Development Environments  
            ├── Install TYPO3 on macOS with DDEV  
            ├── Install TYPO3 on Windows 11 with DDEV  
            └── Install TYPO3 on Ubuntu 22.04 with DDEV

Or:

└── Advanced Implementation  
    └── Deployment and DevOps  
        └── Server Stack Scenarios  
            ├── Install TYPO3 with Apache and MySQL  
            ├── Install TYPO3 with Nginx and MariaDB  
            └── Install TYPO3 with Caddy and PostgreSQL

To boost SEO further, use **long-tail keywords** in the title and conceptual overview. For example: “This guide walks you through how to install TYPO3 CMS on Ubuntu 22.04 using Composer and DDEV — ideal for developers working in a Linux environment.”

We can also **cross-link to related guides**, for example, “Using macOS instead? See our macOS installation guide.”

## Extract shared tasks into atomic guides

Instead of repeating similar chunks across guides, we’ll use **modular content reuse** strategies to minimize duplication.

For example, for “nstall TYPO3 on Windows 11 with DDEV”, we might:

- Create one atomic guide for “Install DDEV on Windows 11”
- Create another for “Run the TYPO3 browser-based installer”
- Link both into the OS-specific guide, which focuses on the Windows-specific context