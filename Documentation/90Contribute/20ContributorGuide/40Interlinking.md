# Interlinking

- [Links between step-by-step guides and the TYPO3 documentation](#links-between-step-by-step-guides-and-the-typo3-documentation)
  - [From step-by-step guides to the TYPO3 documentation](#from-step-by-step-guides-to-the-typo3-documentation)
  - [From the TYPO3 documentation to step-by-step guides](#from-the-typo3-documentation-to-step-by-step-guides)
- [How to find a guide or documentation page to link to](#how-to-find-a-guide-or-documentation-page-to-link-to)
- [How to link to missing guides](#how-to-link-to-missing-guides)


Guides don’t exist in a vacuum, and linking to and from other content multiplies their usefulness. For step-by-step guides, there are two main document types to interlink with: the encyclopedic TYPO3 documentation, and [SkillDisplay](https://www.skilldisplay.eu/) skills. 

## Links between step-by-step guides and the TYPO3 documentation

Step-by-step guides and encyclopedic documents should link to each other, in both directions.

### From step-by-step guides to the TYPO3 documentation

Step-by-step guides should point to relevant documentation pages for these reasons:

- To let the reader go into details if needed  
- To avoid repeating content that is already available  
- To keep the guides focused on the task

Inside a guide, linking to the documentation can be done in three ways:

   - Within the text, as embedded links  
   - As a callout after a paragraph, such as:

     `For a complete overview of TypoScript options, see the [TypoScript reference].`

   - At the end of the guide, the Resources section can contain accumulated links to the TYPO3 documentation.

### From the TYPO3 documentation to step-by-step guides

The opposite direction, from the documentation to step-by-step guides, is equally important, as it can prevent beginners from choosing the wrong kind of documentation for starting their journey of learning TYPO3. 

If a step-by-step guide exists for a given page of the documentation, this page or section should contain a “guide available” banner:

`Step-by-Step Guide Available`

`Learn how to implement this feature with our step-by-step guide: [Creating Custom Content Elements]`

## How to find a guide or documentation page to link to

** Do a search **

* Check the [Step-by-Step Guide registry](../../80GuidesRegistry/Index.md) 
* Use the [TYPO3 Documentation search function](https://docs.typo3.org/search/) - it is powerful and comprehensive. Try a few different terms or phrasing variations.

If your search turns up nothing useful, that may be a good sign that your guide really is needed.

**See what others have done**

Look at step-by-step guides written by other contributors that sit before or alongside yours in the structure. See what documentation pages they link to. This saves you the trouble of searching the docs from scratch.

If your guide builds on or shares a task with a similar guide, chances are it will already have referenced the same concepts, terminology, or documentation pages that you’re looking for. For example, creating pages, adding content elements, accessing page properties, etc.

## How to link to missing guides

Sometimes, while writing a step-by-step guide, you’ll need to reference a related guide that doesn’t exist yet. This might happen:

* In the **prerequisite section**. For example, a skill or configuration that the learner needs first.
* **During a task**. For example, “Before continuing, make sure you’ve \[Created a custom backend layout\]” — but that guide isn’t written yet.

That’s okay! Missing guides are part of a growing system, and it’s important not to lose your flow or get side-tracked. Here’s how to handle them.

1. **Link to the missing guide anyway.**   
   If the guide doesn’t exist, link to the title it should have as if it does. Use the normal way you'd insert a link using markdown syntax: `[Link text](relative/path-to-guide/)`  <br />
   Add a note in the PR that your guide references non-existent guides.

2. **Add the missing guide to the structure.**   
   Don’t worry about writing the guide yourself — just give it a logical placeholder. See [How to Place Guides in the Structure](../30UnderstandingTheStructure/20PlaceGuidesInTheStructure.md) for more information.

**Missing guides will be tracked automatically in the future.** In the future, an automated script will help us keep track of missing guides.

We plan to add an automated script that periodically scans for links to step-by-step guides that don’t yet exist—essentially, broken internal links within the repository. These will be flagged for review so they can be confirmed and added to the structure.

We may also collect unplaced guides in a “pending” section at the bottom of the [Step-by-Step Guide registry](../../80GuidesRegistry/Index.md) to be filed manually. This will help us maintain a living, evolving guide library where contributors can spot gaps, reserve titles, and grow the system collaboratively.