# Minimum requirements
All TYPO3 Step-by-Step Guides must include the following required sections:

* **Title** — Starts with a verb and reflects the overall learning objective  
* **Conceptual overview** — Follows the title directly (no heading), uses plain language, and stays under \~100 words  
* **Learning objective** — Describes what the learner will achieve by completing the guide  
* **Prerequisites** — Lists required software, tools, environments, and any conceptual knowledge  
* **Task section**  
  * Includes at least one task with numbered steps  
  * Each step begins with a verb and describes one action  
  * Each task includes at least one expected outcome  
* **Summary** — Recaps what has been achieved  
* **Next steps** — Suggests logical follow-on tasks
 
 <br /> 

The following sections are optional but strongly encouraged:

* **Resources** — Links to supporting material  
* **Video** — Embedded video version of the guide (from the official TYPO3 YouTube channel)

 <br />

Use the [template](../10Template/Index.md) and [writing instructions](30UsingTheTemplate.md) to complete each section.

All required sections must be complete and free of placeholders like “TBD.”

Every guide will have room for improvement — that’s expected. That’s why all TYPO3 step-by-step guides include a feedback section to collect reader-reported gaps and issues.

# Definition of done

A step-by-step guide is ready for submission when:

[ ] All required sections are complete — no placeholders.  
[ ] Numbered steps are logical, testable, and lead to the expected outcome  
[ ] Screenshots or code examples are included where appropriate and follow TYPO3 guidelines.  
[ ] Relevant concepts or references are linked where needed  
[ ] Language is clear, concise, and action-oriented  
[ ] The guide has been tested by the author  
[ ] The guide follows [TYPO3 writing conventions and formatting rules](https://docs.typo3.org/m/typo3/docs-how-to-document/main/en-us/Advanced/ContentStyleGuide.html)  
[ ] The guide fits its intended scope. (One learning objective per guide, or a project guide for more complex, multi-step processes.)

# How to link to missing guides

Sometimes, while writing a step-by-step guide, you’ll need to reference a related guide that doesn’t exist yet. This might happen:

* In the **prerequisite section**. For example, a skill or configuration that the learner needs first.
* **During a task**. For example, “Before continuing, make sure you’ve \[Created a custom backend layout\]” — but that guide isn’t written yet.

That’s okay! Missing guides are part of a growing system, and it’s important not to lose your flow or get side-tracked. Here’s how to handle them.

1. **Link to the missing guide anyway.**   
   If the guide doesn’t exist, link to the title it should have as if it does. Use the normal way you'd insert a link using markdown syntax: `[Link text](relative/path-to-guide/)`  <br />
   Add a note in the PR that your guide references non-existent guides.

2. **Add the missing guide to the structure.**   
   Don’t worry about writing the guide yourself — just give it a logical placeholder. See [How to Place Guides in the Structure](50PlaceGuidesInTheStructure.md) for more information.

**Missing guides will be tracked automatically in the future.** In the future, an automated script will help us keep track of missing guides.

We plan to add an automated script that periodically scans for links to step-by-step guides that don’t yet exist—essentially, broken internal links within the repository. These will be flagged for review so they can be confirmed and added to the structure.

We may also collect unplaced guides in a “pending” section at the bottom of the [Step-by-Step Guide registry](../../80GuidesRegistry/Index.md) to be filed manually. This will help us maintain a living, evolving guide library where contributors can spot gaps, reserve titles, and grow the system collaboratively.

# How to find a guide or documentation page to link to

#### Do a search 

* Check the [Step-by-Step Guide registry](../../80GuidesRegistry/Index.md) 
* Use the [TYPO3 Documentation search function](https://docs.typo3.org/search/) - it is powerful and comprehensive. Try a few different terms or phrasing variations.

If your search turns up nothing useful, that may be a good sign that your guide really is needed.

#### See what others have done

Look at step-by-step guides written by other contributors that sit before or alongside yours in the structure. See what documentation pages they link to. This saves you the trouble of searching the docs from scratch.

If your guide builds on or shares a task with a similar guide, chances are it will already have referenced the same concepts, terminology, or documentation pages that you’re looking for. For example, creating pages, adding content elements, accessing page properties, etc.