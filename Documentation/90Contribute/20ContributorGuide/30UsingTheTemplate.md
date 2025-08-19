# Using the template to create a guide

When you create a step-by-step guide or a project guide for TYPO3, you must use the [step-by-step guide template](../10Template/Index.md). Here we explain each section in detail and provide example text to help you.

**📝 [Create a new step-by-step guide using the template](../10Template/Index.md)**

## Contents
- [Titles](#titles)
- [About the Conceptual Overview section](#about-the-conceptual-overview-section)
- [About the Learning Objective section](#about-the-learning-objective-section)
- [About the Prerequisites section](#about-the-prerequisites-section)
- [About the Video section](#about-the-video-section)
- [About the Task section](#about-the-task-section)
  - [Key principles for effective tasks:](#key-principles-for-effective-tasks)
  - [Tips for writing steps](#tips-for-writing-steps)
  - [Task section examples](#task-section-examples)
  - [Tips for when you have too many steps {#tips-for-when-you-have-too-many-steps}](#tips-for-when-you-have-too-many-steps-tips-for-when-you-have-too-many-steps)
  - [Resist the urge to explain everything](#resist-the-urge-to-explain-everything)
- [About the Summary section](#about-the-summary-section)
- [About the Next steps section](#about-the-next-steps-section)
- [About the Resources section](#about-the-resources-section)


### Titles

Titles start with a verb and reflect the overall learning objective.

**Examples**

* Translate your site to a second language
* Set up HTTPS
* Create a password-protected members’ area

### About the Conceptual Overview section

This section has no heading — it follows directly after the title. Provide information about why this guide exists. Explain what the feature is, how the goal will help the user, or why the learning objective is useful. If part of a broader learning path, explain where this guide sits in the learning journey to orient the user. Use plain language and assume no prior knowledge of TYPO3. Try to keep it under 100 words.

**Example 1**
Much of TYPO3’s flexibility comes from its extension API, which lets you add features without changing the Core. You can enable system extensions or install community ones, but when none deliver exactly what you need, you can create your own custom extension.

**Example 2**
A password-protected member’s area on your website is useful to offer exclusive content, host downloadable files, show work in progress to your clients, and build a sense of community. The basic authentication process and the functionality to create user groups are included in TYPO3’s Core. To leverage this functionality, you need a login form plus some restricted content.

### About the Learning objective section

Provide information that explains what the learner will have, or know, or be able to do after completing the guide. For more complex objectives, you can outline the approach, covering the path the tutorial will take to achieve the goal. Show the learner where they’ll be going.

One of the first things people want to know when they begin a tutorial is, "What will I be able to do? What knowledge will I gain by completing this tutorial?" Learning objectives describe the specific skills or knowledge people will be able to demonstrate after completing your tutorial.

Be mindful of scope: tutorials should present one clear learning objective. If your tutorial includes more than one learning objective, you may need to [create a project guide](20WhatAreProjectGuides.md). See the information about project guides for more information

**Example simple**
In this step-by-step guide you will learn how to install and activate an extension.

**Example complex**
In this step-by-step guide, we’ll take the following approach to create a dynamic frontend extension:

* Create the extension structure
* Add a custom data structure
* Activate the extension
* Create the plugin
* Fetch content from the database

### About the Prerequisites section

Use this section to list (and where possible, link to) any tools, technologies, and prior knowledge that the learner needs before starting the guide. This helps readers avoid surprises partway through the tutorial—like realizing they’re missing a required tool, environment, or skill.

If you’re writing a guide that requires learners to have completed one or more specific step-by-step guides beforehand, you don’t need to repeat the prerequisites for those earlier guides — they carry over by default.

Split your prerequisites into two categories:

* **Tools and technology** List all physical and technical requirements needed to complete the task. This might include software (e.g. Composer, DDEV), system setups (e.g. local TYPO3 project), and hardware or environments (e.g. terminal access, browser, operating system).

* **Knowledge and skills** Outline any prior learning, conceptual understanding, or assumed familiarity with TYPO3 or related technologies. This could include PHP basics, TYPO3 backend concepts, or experience using the command line.

**Example**

**Tools and technology**

* A TYPO3 site installed using Composer and DDEV
* Access to the public directory of your project
* A local database (SQLite, MariaDB, or MySQL)

**Knowledge and skills**

* Familiarity using the command line
* Experience setting up a local development environment using DDEV
* Understanding of the TYPO3 installation process and project structure

### About the Video section

This section is optional. Ideally, every step-by-step guide will have an accompanying video. If it’s available, include it in this section. You can only link to videos hosted on the [official TYPO3 YouTube channel](https://www.youtube.com/typo3).

### About the Task section

This section makes up the bulk of the guide. This is where you take the learner through the steps required to complete the tutorial.

They may look easy, but there’s a real art to writing an effective step. Before you start writing, break down your learning objective into logical chunks. Long procedures overwhelm readers, but well-structured chunks allow people to pause, see their progress, and celebrate small successes as they work toward the final goal. You might separate tasks by backend/frontend, by module, by UI/file system interactions, by screen, or by different stages in an overall workflow.

Once you've identified your chunks, give each one a clear name — these will be your headings in the task section. Always start task headings with a verb.

If you're wrestling with too many chunks and find yourself using headings like "Part 1," "Part 2," you're likely writing a project guide — even if it started as a regular step-by-step guide. See the [project guide section](20WhatAreProjectGuides.md) for more information.

#### Key principles for effective tasks:

* Break down processes into logical chunks
* Keep each task focused on a single objective
* Use verb-based headings for each task (e.g., "Configure the Database," not "Database Configuration")
* If you find yourself writing more than \~10 numbered steps per task, see the [tips for dealing with too many steps](#tips-for-when-you-have-too-many-steps).

**Think like a developer**
If you’re stuck figuring out how much to include, ask yourself: *Would I write one function to do all of this?* If not, break it up. Just like code, your guide should follow the [single-responsibility principle](https://en.wikipedia.org/wiki/Single-responsibility_principle).

#### Tips for writing steps

* Each numbered step should describe one action. Provide minimal explanation of actions in the most basic language possible. Use the ELI5 principle (“Explain like I’m five years old”).
* Present information in a logical sequence. For example:
  * ✅ On the File menu, choose Print.
  * ❌ Choose Print from the File menu.
* Use [links](https://docs.typo3.org/permalink/h2document:md-cheat-sheet-links) generously to abstract detail. Link to more detailed explanation, term definitions, supplementary information for context or conceptual material. For example, “We always do x before y because… (link to other material for more detail).”
* Include [code blocks](https://docs.typo3.org/permalink/h2document:md-cheat-sheet-code-blocks) (follow [code example rules](https://docs.typo3.org/permalink/h2document:cgl-code)) and [screenshots](https://docs.typo3.org/permalink/h2document:guidelines-for-images) where appropriate.
* Use [admonitions](https://docs.typo3.org/permalink/h2document:md-cheat-sheet-admonitions) where appropriate: hints, tips, notes, warning, etc.
* Include expected outcomes. This helps learners confirm they are on the right track. Provide continual feedback. Keep up a narrative of expectations to provide feedback to the learner that they are indeed on the right path. Give your learner clear expectations and plenty of clues to help confirm they are on the right track.
  * Show example output or the exact expected output. For example, “The output should look something like; After a few moments, the server responds with; Notice that; Let’s check”.
  * Describe possibly surprising results: “The command will probably return several hundred lines of logs in your terminal.”
  * If you know in advance what the likely signs of going wrong are, consider flagging them: “If the output doesn’t show x, you have probably forgotten to y”.

#### Task section examples

**Example — Regular**

*Step-by-step guide title:* Create a custom page type

*H2* Define the custom page type in TCA

Creating a custom page type allows you to define special layouts and functionality for specific pages in your TYPO3 installation.

1. Add the new page type configuration to your site's `Configuration/TCA/Overrides/pages.php` file. `{Code block.}` Note: We're using `130` as our doktype number. This is a unique identifier that TYPO3 will use to recognize our custom page type.
2. Create the page type icon in `Resources/Public/Icons/` directory and register it in `ext_localconf.php`. `{Code block.}` After saving this file, your new icon will appear in the TYPO3 backend when you refresh.

*H2* Configure the Page Type Template

1. Configure the page type in your TypoScript setup. `{Code block.}`
2. In the backend, click "Clear all caches".

Great! Your new page type will now display in the "Page Types" dropdown. Let’s go and  create a new page based on this page type.

*H2* Create a page based on the new page type

1. In the backend, go to the Pages module and click…

**Example — Project guide: Fully modular**

In this example, each of the numbered steps link to pre-existing step-by-step guides.

*H2* Create a multilingual website

1. [Set up multiple languages](../../20BuildingWebsites/20MultilingualWebsites/10SetUpMultipleLanguages/Index.md)
2. [Translate content into other languages](../../20BuildingWebsites/20MultilingualWebsites/20TranslateContent/Index.md)
3. [Manage language fallbacks](../../20BuildingWebsites/20MultilingualWebsites/30ManageLanguageFallbacks/Index.md)

#### Tips for when you have too many steps

Lengthy tutorials with too many steps are overwhelming. Remember the [single-responsibility principle](https://en.wikipedia.org/wiki/Single-responsibility_principle). There are a few techniques you can use to minimize your step count:

* **Chunking** — Ensure you have broken down your learning objective into logical chunks. Review your structure and see if you can create more focused task sections. Don't be afraid to get really granular with your task headings — smaller, complete units are easier to process.

* **Sub-procedures** — Use second-level steps (a, b, c) for closely related actions within a main step. This can reduce your broader step count and help learners focus on specific sub-tasks. But too many sub-steps is also overwhelming so second-level steps are not always the answer. Example:
  1. Open the Extension Manager.
     1. Navigate to the main menu.
     2. Select "Extensions" from the dropdown.
     3. Click "Get Extensions" in the module frame.
  2. Do the next thing

* **Tables** — When steps involve filling in fields with specific values, rather than using a step per field, you can use one step with a two-column table. This works especially well for configuration screens or form inputs. Example: *Configure the file mount as follows:*

   | Field | Value |
   | :---- | :---- |
   | Label | Member area |
   | Storage | fileadmin |
   | Folder | /members/ |

* **Screenshots** — Rather than using multiple steps to describe a complex screen, you can use a screenshot. For intuitive interfaces, your step might simply be, “Complete the form as shown in the image below.”

* **Code blocks with comments** — Instead of separate steps for each line of code modification, you might be able to use a single code block with clear inline comments explaining each change.

* **Create a short step-by-step guide** — If a complex sub-procedure is reusable across tutorials, consider moving it to a separate step-by-step guide and linking to it instead of including all steps inline.

#### Resist the urge to explain everything

When you're writing task steps, it's easy to get drawn into explaining every detail. But not everything needs to be spelled out — especially if it's already documented elsewhere. Focus on what’s unique to your guide, and lean on links for the rest.

**Show the route, don’t construct every building.** Think of your role like a tour guide. You're showing people the route through existing landmarks (documentation), not constructing the buildings.

Ask yourself: "Is this step specific to the goal, or is it a general skill?". If someone could use that knowledge in completely different contexts, it probably belongs (and already exists!) elsewhere. That’s a sign you can search the documentation for an existing description to link to. For example:

* "Access page properties" → general skill, link out
* "Set the page title to match your campaign name" → specific to your tutorial, keep it

If your guide lists a prerequisite, you can assume the reader already knows that material. For example, if you’ve listed “Basic Site Management” as a prerequisite, you don’t need to explain how to add a new backend user in your task steps — just say “Create a backend user for the editor role” and move on.

> [!TIP]
> If you link to another guide in your task steps, make sure to also add it to your pre-requisites.

### About the Summary section

Write a short statement (1–2 sentences) that summarizes what has just been taught — recap what the reader just did. Reinforce the tangible or practical outcome, and/or restate the benefit or context in TYPO3. Avoid repeating the learning objectives word for word.
Describe (and admire, in a mild way) what your learner has accomplished.

**Examples**
Congratulations! You now know how to install and activate new extensions.

Congratulations, your website is now available in two languages! Your editors can manually translate your content, and your website visitors can switch between languages.

Congratulations — your members-only area is live! Registered users can now log in to access exclusive pages, while TYPO3 handles authentication for you.

### About the Next steps section

List one or more actions the learner is likely to find useful after completing the current material. This could be based on your sense of what the reader might logically do or explore next; or you can refer to some established learning pathways to help identify next steps:

* The [TYPO3 Onboarding Curriculum](https://docs.typo3.org/permalink/t3cec-curriculum:start)
* The syllabus for the different [TYPO3 certifications](https://typo3.com/services/certifications)
* The SkillSets listed in SkillDisplay for various TYPO3 learning journeys

If there are no clear next steps, you can omit this section.

**Example**

Now that you have some experience with extensions, you can continue to add functionality to your site — either to change the backend experience, or to add features to the frontend. When you’re ready, you can look into building your own extension.

* Add a blog to your site
* Change the backend look-and-feel
* Create your first extension

### About the Resources section

This section is optional but highly recommended. Link to material with opportunities for learners to expand their understanding.

Related material might include TYPO3 guides or documentation, web pages, blog posts, community or forum discussions, videos, etc.

**Example**

* How to choose good extensions
* About the TYPO3 Extension Repository
