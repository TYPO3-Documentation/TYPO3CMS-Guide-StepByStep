## Primary Structure of the Step-by-Step Guides

The [primary structure](../../80GuidesRegistry/Index.md) of the step-by-step guides is a hierarchical, progression-based approach, with the most beginner-friendly content at the beginning and advancing towards advanced topics. It serves as a superset of all specialized learning paths. It facilitates maintenance of guides and learning paths. As such, it is not directly intended to be the preferred entry point for readers looking for particular learning paths. 

**Contents**
- [Secondary structures: learning paths](#secondary-structures-earning-paths)
  - [Task-based learning paths](#task-based-learning-paths)
    - [Quick site setup](#quick-site-setup)
    - [Building a corporate website](#building-a-corporate-website)
    - [Building a web application](#building-a-web-application)
  - [Role-based learning paths](#role-based-learning-paths)
    - [Editor path](#editor-path)
    - [Integrator path](#integrator-path)
    - [Developer path](#developer-path)
    - [Admin path](#admin-path)
- [How to relate secondary structures to the primary structure](#how-to-relate-secondary-structures-to-the-primary-structure)

## Secondary structures: learning paths

Learning should be tailored to a particular role or project. 

While the primary structure represents a progression through topics, from beginner to advanced, it isn’t the preferred way of learning TYPO3 because it contains topics for multiple audiences. 

Specific tasks or roles require focused learning paths. A learning path is a subset of the primary structure’s step-by-step guides. Irrelevant guides are omitted, while the sort order can usually remain the same, as learning paths ideally start with beginner-level topics and move on to advanced topics.

Learning paths fall into one of two categories: **task-based** and **role-based**.

### Task-based learning paths

Beginners often look for a guided way of solving a particular task, such as getting started with a basic website or building a web application. Below are three examples of such task-based learning paths. Note that all of them were created from the primary structure by taking out irrelevant guides; no further adjustments (such as reordering the guides, adding guides that don’t exist in the primary structure, or choosing a different hierarchy) have been applied.

#### Quick site setup

<pre>
`TYPO3 Step-by-Step Guides/`  
`├── Getting Started/`  
`│   ├── Installation/`  
`│   │   ├── Install TYPO3 with Composer`  
`│   ├── Basic Configuration/`  
`│   │   ├── First-time Backend Setup`  
`│   │   ├── Set Up a Site Configuration`  
`│   └── Site Packages/`  
`│       ├── Use the Bootstrap Package`  
`├── Building Websites/`  
`│   ├── Content Management/`  
`│   │   ├── Set Up Page Types`  
`│   ├── Extensions/`  
`│   │   ├── Find and Install Extensions`
</pre>

#### Building a corporate website

<pre>
`TYPO3 Step-by-Step Guides/`  
`├── Getting Started/`  
`│   ├── Installation/`  
`│   │   ├── Install TYPO3 with Composer`  
`│   │   ├── Install TYPO3 without Composer`  
`│   │   ├── Set up TYPO3 with DDEV`  
`│   ├── Basic Configuration/`  
`│   │   ├── First-time Backend Setup`  
`│   └── Site Packages/`  
`│       ├── Create a Basic Site Package`  
`│       └── Implement Your Design`  
`├── Building Websites/`  
`│   ├── Content Management/`  
`│   │   ├── Set Up Page Types`  
`│   │   ├── Create Custom Content Elements`  
`│   │   ├── Configure the Backend Layout`  
`│   │   └── Manage Backend User Permissions`  
`│   ├── Multilingual Websites/`  
`│   │   ├── Set Up Multiple Languages`  
`│   │   ├── Translate Content`  
`│   │   ├── Manage Language Fallbacks`  
`│   │   └── Work with Translation Services`  
`├── Advanced Implementation/`  
`│   ├── Performance Optimization/`  
`│   │   ├── Configure Caching`  
`│   │   ├── Set Up a CDN`  
`│   │   ├── Optimize Database`  
`│   │   └── Implement Static Site Generation`  
`└── Maintenance and Security/`  
    `├── Regular Maintenance/`  
    `│   ├── Backup and Restore Procedures`  
    `│   ├── Update TYPO3 Core`  
    `│   ├── Update Extensions`  
    `│   └── Database Maintenance Tasks`  
    `├── Security/`  
    `│   ├── Implement Security Best Practices`  
    `│   ├── Set Up HTTPS`  
    `│   ├── Manage User Authentication`  
    `│   └── Security Incident Response`
</pre>

#### Building a web application

<pre>
`TYPO3 Step-by-Step Guides/`  
`├── Getting Started/`  
`│   ├── Installation/`  
`│   │   ├── Install TYPO3 with Composer`  
`│   │   ├── Install TYPO3 without Composer`  
`│   │   ├── Set up TYPO3 with DDEV`  
`│   ├── Basic Configuration/`  
`│   │   ├── First-time Backend Setup`  
`├── Building Websites/`  
`│   ├── Extensions/`  
`│   │   ├── Find and Install Extensions`  
`│   │   ├── Configure Common Extensions`  
`│   │   ├── Customize Extension Templates`  
`│   │   └── Troubleshoot Extension Issues`  
`├── Advanced Implementation/`  
`│   ├── Extension Development/`  
`│   │   ├── Create a Basic Extension`  
`│   │   ├── Develop with Extbase and Fluid`  
`│   │   ├── Build Non-Extbase Extensions`  
`│   │   └── Create Extension APIs`  
`│   ├── System Integration/`  
`│   │   ├── Connect to External Services`  
`│   │   ├── Implement Single Sign-On`  
`│   │   ├── Set Up REST APIs`  
`│   │   └── Integrate with Third-party Systems`  
`│   └── Deployment and DevOps/`  
`│       ├── Set Up CI/CD Pipelines`  
`│       ├── Implement Git Workflows`  
`│       ├── Containerize with Docker`  
`│       └── Kubernetes Deployment`  
`└── Maintenance and Security/`  
    `├── Regular Maintenance/`  
    `│   ├── Backup and Restore Procedures`  
    `│   ├── Update TYPO3 Core`  
    `│   ├── Update Extensions`  
    `│   └── Database Maintenance Tasks`  
    `├── Security/`  
    `│   ├── Implement Security Best Practices`  
    `│   ├── Set Up HTTPS`  
    `│   ├── Manage User Authentication`  
    `│   └── Security Incident Response`  
    `├── Monitoring/`  
    `│   ├── Set Up Application Monitoring`  
    `│   ├── Configure Log Management`  
    `│   ├── Implement Alerts`  
    `│   └── Performance Monitoring`  
    `└── Troubleshooting/`  
        `├── Debug Common Issues`  
        `├── Use the Admin Panel`  
        `├── Work with Exception Logs`  
        `└── Get Community Support`
</pre>

### Role-based learning paths

Users who want to take on a particular role in their TYPO3 team can take a role-based learning path. Standard roles include editors, integrators, developers, and administrators. These these learning paths are a filtered subset of the primary structure without further restructuring. 

#### Editor path

<pre>
`TYPO3 Step-by-Step Guides/`  
`├── Getting Started/`  
`│   ├── Basic Configuration/`  
`│   │   ├── First-time Backend Setup`  
`│   │   ├── Create Your First Pages`  
`│   ├── Content Creation/`  
`│   │   ├── Create and Organize Pages`  
`│   │   ├── Add Various Content Elements`  
`│   │   ├── Work with the Rich Text Editor`  
`│   │   └── Manage Media Assets`  
`├── Building Websites/`  
`│   ├── Content Management/`  
`│   │   └── Manage Backend User Permissions`  
`│   ├── Multilingual Websites/`  
`│   │   ├── Translate Content`  
`│   │   ├── Manage Language Fallbacks`  
`│   │   └── Work with Translation Services`
</pre>

#### Integrator path

<pre>
`TYPO3 Step-by-Step Guides/`  
`├── Getting Started/`  
`│   ├── Installation/`  
`│   │   ├── Install TYPO3 with Composer`  
`│   │   ├── Install TYPO3 without Composer`  
`│   │   ├── Set up TYPO3 with DDEV`  
`│   │   └── Upgrade an Existing TYPO3 Installation`  
`│   ├── Basic Configuration/`  
`│   │   ├── First-time Backend Setup`  
`│   │   ├── Create Your First Pages`  
`│   │   ├── Set Up a Site Configuration`  
`│   │   └── Implement Site Sets (v13+)`  
`│   ├── Content Creation/`  
`│   │   ├── Create and Organize Pages`  
`│   │   ├── Add Various Content Elements`  
`│   │   ├── Work with the Rich Text Editor`  
`│   │   └── Manage Media Assets`  
`│   └── Site Packages/`  
`│       ├── Create a Basic Site Package`  
`│       ├── Use the Bootstrap Package`  
`│       ├── Customize Templates`  
`│       └── Implement Your Design`  
`├── Building Websites/`  
`│   ├── Content Management/`  
`│   │   ├── Set Up Page Types`  
`│   │   ├── Create Custom Content Elements`  
`│   │   ├── Configure the Backend Layout`  
`│   │   └── Manage Backend User Permissions`  
`│   ├── Multilingual Websites/`  
`│   │   ├── Set Up Multiple Languages`  
`│   │   ├── Translate Content`  
`│   │   ├── Manage Language Fallbacks`  
`│   │   └── Work with Translation Services`  
`│   ├── Extensions/`  
`│   │   ├── Find and Install Extensions`  
`│   │   ├── Configure Common Extensions`  
`│   └── Frontend Development/`  
`│       ├── Understand Fluid Templates`  
`│       ├── Create Responsive Layouts`  
`│       ├── Implement Frontend User Registration`  
`│       └── Add Custom JavaScript and CSS`  
`└── Maintenance and Security/`  
    `├── Regular Maintenance/`  
    `│   ├── Backup and Restore Procedures`  
    `│   ├── Update TYPO3 Core`  
    `│   ├── Update Extensions`  
    `│   └── Database Maintenance Tasks`  
    `├── Security/`  
    `│   ├── Implement Security Best Practices`
</pre>

#### Developer path

<pre>
`TYPO3 Step-by-Step Guides/`  
`├── Advanced Implementation/`  
`│   ├── Extension Development/`  
`│   │   ├── Create a Basic Extension`  
`│   │   ├── Develop with Extbase and Fluid`  
`│   │   ├── Build Non-Extbase Extensions`  
`│   │   └── Create Extension APIs`  
`│   ├── System Integration/`  
`│   │   ├── Connect to External Services`  
`│   │   ├── Implement Single Sign-On`  
`│   │   ├── Set Up REST APIs`  
`│   │   └── Integrate with Third-party Systems`  
`│   ├── Performance Optimization/`  
`│   │   ├── Configure Caching`  
`│   │   ├── Optimize Database`  
`│   │   └── Implement Static Site Generation`  
`└── Maintenance and Security/`  
    `└── Troubleshooting/`  
        `├── Debug Common Issues`  
        `├── Use the Admin Panel`  
        `├── Work with Exception Logs`  
        `└── Get Community Support`
</pre>

#### Admin path 

<pre>
`TYPO3 Step-by-Step Guides/`  
`├── Getting Started/`  
`│   ├── Installation/`  
`│   │   ├── Install TYPO3 with Composer`  
`│   │   ├── Install TYPO3 without Composer`  
`│   │   ├── Set up TYPO3 with DDEV`  
`│   │   └── Upgrade an Existing TYPO3 Installation`  
`│   ├── Basic Configuration/`  
`│   │   ├── First-time Backend Setup`  
`│   │   ├── Set Up a Site Configuration`  
`│   │   └── Implement Site Sets (v13+)`  
`├── Building Websites/`  
`│   ├── Content Management/`  
`│   │   ├── Set Up Page Types`  
`│   │   ├── Create Custom Content Elements`  
`│   │   ├── Configure the Backend Layout`  
`│   │   └── Manage Backend User Permissions`  
`│   ├── Multilingual Websites/`  
`│   │   ├── Set Up Multiple Languages`  
`│   ├── Extensions/`  
`│   │   ├── Find and Install Extensions`  
`│   │   ├── Configure Common Extensions`  
`│   │   ├── Customize Extension Templates`  
`│   │   └── Troubleshoot Extension Issues`  
`├── Advanced Implementation/`  
`│   ├── Performance Optimization/`  
`│   │   ├── Configure Caching`  
`│   │   ├── Set Up a CDN`  
`│   └── Deployment and DevOps/`  
`│       ├── Set Up CI/CD Pipelines`  
`│       ├── Implement Git Workflows`  
`│       ├── Containerize with Docker`  
`│       └── Kubernetes Deployment`  
`└── Maintenance and Security/`  
    `├── Regular Maintenance/`  
    `│   ├── Backup and Restore Procedures`  
    `│   ├── Update TYPO3 Core`  
    `│   ├── Update Extensions`  
    `│   └── Database Maintenance Tasks`  
    `├── Security/`  
    `│   ├── Implement Security Best Practices`  
    `│   ├── Set Up HTTPS`  
    `│   ├── Manage User Authentication`  
    `│   └── Security Incident Response`  
    `├── Monitoring/`  
    `│   ├── Set Up Application Monitoring`  
    `│   ├── Configure Log Management`  
    `│   ├── Implement Alerts`  
    `│   └── Performance Monitoring`  
    `└── Troubleshooting/`  
        `├── Debug Common Issues`  
        `├── Use the Admin Panel`  
        `├── Work with Exception Logs`  
        `└── Get Community Support`
</pre>

## How to relate secondary structures to the primary structure

Readers can access any guide without choosing a learning path first. To give them a hint about the guide’s context, each guide should contain a visual guidance about available learning paths. 

For example:

This guide is part of the following learning paths:

- Editor path
- Integrator path
- Quick site setup
