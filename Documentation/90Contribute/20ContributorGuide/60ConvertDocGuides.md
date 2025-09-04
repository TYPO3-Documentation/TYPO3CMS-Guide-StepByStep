# Convert Guides in the Documentation to Step-by-Step Guides

# What is this guide about?

*TL;DR: This guide helps to create new step-by-step guides from existing how-to guides in the documentation.*

TYPO3 step-by-step guides help beginners and advanced users quickly learn how to perform tasks they aren’t familiar with. (If you haven’t contributed a step-by-step guide yet, see the [TYPO3 Step-by-Step Contributor Guide](https://docs.typo3.org/m/typo3/guide-step-by-step/main/en-us/90Contribute/Index.html) for more information.)

When adding new content to an existing body of knowledge, overlaps are unavoidable. Before the step-by-step guides were introduced, the TYPO3 documentation already had several guides available via the “All documentation” menu on the documentation home page:

* Getting Started Tutorial  
* Site Package Tutorial  
* Administration (Install, Update)  
* Extension Development  
* Frontend Localization Guide  
* Editors Guide

These guides contain actionable (how-to) content, as well as explanations of TYPO3 features (tools, UIs, and more). We want to turn the actionable parts into the [step-by-step guide format](https://docs.typo3.org/m/typo3/guide-step-by-step/main/en-us/90Contribute/10Template/Index.html) to achieve these benefits:

1. The guides will have a standardized format that provides consistency and helps learners focus on the tasks.   
2. The guides can be integrated into *learning paths* that consist of a series of step-by-step guides targeted towards specific audiences. Learning paths help beginners to achieve bigger goals by addressing a series of smaller goals. 

In this guide, you’ll learn the steps for gently transforming an existing guide into one or more step-by-step guides.

# Guide migration workflow

Transferring existing guides over to the new step-by-step guide structures—both the internal and external structure—involves four steps:

1. Review an existing guide to see if and where it fits  
2. Create one or more step-by-step guides in the guide structure  
3. Write the guide(s)  
4. Remove the legacy content from the documentation and link to the new step-by-step guide

## 1\. Review an existing guide

The existing guides don’t follow a consistent structure—some are explanations, some are how-to guides, some cover a single goal, others multiple.

Step-by-step guides, by contrast, are uniform: each covers exactly one goal. To bridge this gap, we provide the **Guide Conversion Map**.

With this map, you can determine whether a guide is eligible for conversion, whether it maps to one or more step-by-step guides, and where it belongs in the new structure. 

## 2\. Create one or more step-by-step guides

Create the guide(s) in the location you identified with the conversion map. For more information, see [How to Place Guides in the Registry Structure](https://docs.typo3.org/m/typo3/guide-step-by-step/main/en-us/90Contribute/30UnderstandingTheStructure/20PlaceGuidesInTheStructure.html).

## 3\. Write the guides

Now draft each guide you created. For details on writing standards and best practices, refer to the [TYPO3 Step-By-Step Contributor Guide](https://docs.typo3.org/m/typo3/guide-step-by-step/main/en-us/90Contribute/20ContributorGuide/Index.html).

The rest of this guide focuses on step 1 and the tool we created to help you move guides over while keeping track of the work (and feel a sense of accomplishment and control). 

## 4\. Remove the legacy content

Once the new step-by-step guide(s) are complete, use the [Edit on GitHub process](https://docs.typo3.org/m/typo3/docs-how-to-document/main/en-us/Howto/EditOnGithub.html#docs-contribute-github-method) to remove any outdated content from the documentation, and insert a link to direct readers to the new step-by-step guide(s). For example:

**Step-by-Step Guide Available**  
Learn how to implement this feature with our step-by-step guide: \[Creating Custom Content Elements\].

# Meet the Guide Conversion Map

The list of existing guides at the beginning of this document looks small (just six items), but each contains numerous documents to process. The [Map Of Guides Convertible To The Step-by-step Format]() is an interactive spreadsheet that helps to organize the documents and keep track of the conversion process. 

Here is a screenshot of the map:

![Screenshot of map spreadsheet][Documentation/90Contribute/20ContributorGuide/Images/MapScreenshot.png]

Getting familiar with someone else's spreadsheet can be challenging. The following information helps you to get a smooth start. 

The far-left column shows the top-level guide. The third column (“Guide Title”) lists individual subpages of each guide hierarchically (note the indenting). 

These two columns are your starting point. For each guide, you will gradually fill the rest of the columns with information that helps you or another contributor convert the guide into one or more step-by-step guides.

# How to review and categorize an existing guide

When you start working with the map, you will see some rows already filled. Search for rows with these settings:

- **Status:** “-”  
- **Action:** “-” 

These rows contain possible candidates for conversion. 

Now, go through these rows and look at the “Guide Title” column to find a title that you’re familiar with, you want to have converted, or that otherwise looks like a good candidate.

As an example, we’ll pick “Creating a site package”:

![Screenshot of selecting a row to work on][Documentation/90Contribute/20ContributorGuide/Images/MapChooseCandidateRow.png]

Click the link to open the original document. 

Read through it to determine:

- if it is actionable  
- how many goals or variants of a task it includes

In this example, the guide is actionable and lists two ways of achieving the intended result: Manual creation and using the Site Package Builder. For the manual creation process, it links to another guide (the TYPO3 site package tutorial), so it effectively contains a single goal and one way of achieving it. Good\! 

Now, take a look at the step-by-step guide repository and verify if the topic is already covered.   
Then go ahead and update the map:

1. Select a **Category**: “Site packages” would be a natural fit. If you cannot seem to find an appropriate category, see the [TYPO3 Step-by-Step How to Place Guides in the Structure](https://docs.typo3.org/m/typo3/guide-step-by-step/main/en-us/90Contribute/30UnderstandingTheStructure/20PlaceGuidesInTheStructure.html) guide that contains detailed instructions and tips for optimal categorization.  
2. Set the **Status** to “Not started”.  
3. Set the **Action** to “Convert”.   
4. Set the **Number of Goals** to 1\.

The rest of the columns are optional for the beginning; Fill them if you have the information at hand or leave them for later. The [Column reference section](#column-reference) below describes all columns you can fill.

Now, the row should look like this:

![Screenshot of completed row][Documentation/90Contribute/20ContributorGuide/Images/MapFilledOutRow.png]

Such a filled-out column sets the informational basis for writing a step-by-step guide. Anyone who picks up the tasks to write that guide can start with a good amount of information to write the guide, add it to learning paths or SkillDisplay skills, and more. 

# Next steps in the guide creation process

## Drafting

From this point on, you or another contributor can pick a filled column with Status “Not started” and start writing a guide. 

- Create a new step-by-step guide in the repository and add a link to the guide to the **Link to Step-by-Step Guide** column.   
- Set the **Status** to **“In draft”** while working on the guide.

Once the draft is finished, change the **Status** to **“In the Git repo”.** In the repository, file a pull request (PR) to have the draft reviewed. From now on, the document’s further processing is tracked within the Git repository on GitHub.

## Reviewing

If you act as a reviewer,  use the GitHub workflow to review documents. Authors file pull requests when a draft is ready for review. Use the standard PR review process to review and approve the draft. Collaborate with the author until the guide is complete and ready for publishing.  

## Publishing

Do the necessary steps to publish the guide, then set the **Status** to **“Published”**. 

# Column reference {#column-reference}

| Column | Description |
| :---- | :---- |
| Source (Top-level Guide) | The top-level guide containing the guide. |
| Category | The category the new step-by-step guide will belong to.  |
| Guide Title (with links) | A hierarchical list of guide titles, with links to the original guides in the TYPO3 documentation. Note the indentation that reflects the structure within the top-level guide. |
| Indent Level | IGNORE. A technical column to control the indentation level of the guide title. (Should be hidden) |
| Status | Set this column to indicate the progress status, from Not Started to Published. |
| Action | The conversion action to take: Convert, Split up, Include in another guide, or Ignore (because either it is not a how-to guide or a step-by-step guide already exists) |
| Number of Goals | Set this to the number of individual goals the guide contains. |
| SkillDisplay Skills | List one or more skills in SkillDisplay that this guide is related to. |
| Learning Path(s) | What learning path(s) could this guide fit into? |
| Link to Step-by-Step Guide | A link to the step-by-step guide once it’s created |
| Remarks | Add any remarks for processing |