# How to Place Guides in the Registry Structure

This guide is for writers who create step-by-step guides and discover new step-by-step content that does not yet exist in the Guide Registry.

Finding the right place for a new guide is not always easy. You might find that no place in the structure seems to fit well, or you might find multiple places to place the new guide. The guide you’re reading was created for these corner cases to help you make an informed decision.

> [!TIP]
> If you don't yet know where to place your step-by-step guide in the structure, feel free to put the file here, within the `00Incoming` folder. Reviewers will look at your guide and find a place for it before it is merged.

## The guide structure philosophy

The TYPO3 Step-by-Step Guides are structured to benefit beginners while being useful for advanced users as well.

- The main structure is hierarchical for easy and unambiguous navigation
- Topics are sorted from beginner to advanced to support steady progress while allowing readers to select topics of interest
- Guides can be prerequisites to other guides, forming a (simple) knowledge graph.

### Step 1: Pre-classification check

Before attempting to classify a guide, first ensure the guide is truly needed and well-defined. The following checklist will help you with this task:

| To check… | …ask this: | Explanation |
| :---- | :---- | :---- |
| Applicability | Does my content idea classify as a step-by-step guide? | Determine if your content is about specific steps someone can perform to achieve a focused goal. If it is a general skill that can be used in different contexts, [add it to the TYPO3 documentation](https://docs.typo3.org/permalink/h2document:docs-contribute-github-method) and cross-link to it from an existing step-by-step guide. |
| Necessity | Does this guide fill a genuine gap? | Verify if the content is already handled elsewhere, maybe under a topic you wouldn’t think of in the first place. |
| Clarity | Is the scope clearly defined? | Ensure that the guide focuses on one actionable task. Think of the potential target audience(s).  |
| Skill level | What are the prerequisites for this guide? | Check which other guides and/or external knowledge and skills a reader needs to make use of the guide. |
| Knowledge transfer potential | What will readers be able to do after completing it? | Every guide should enable the reader to do a task they aren’t able to do without the knowledge from the guide.  |
| Uniqueness | Could this content be integrated into an existing guide instead as an optional step, explanatory note, or sub-step within an existing task? | On some occasions, potential content for a guide might not be enough to warrant a full guide or it might be very similar to existing content. In that case, it might belong in an existing guide rather than as a guide of its own.  |

### Step 2: Content classification

If your content idea survived the pre-classification check (congratulations!), the next step is to determine where exactly the new content should be placed.

Go through these four sub-steps and think thoroughly through the questions to gain clarity on the best placement of your new guide:

#### Step 2.1: Identify the skill level required

* Beginner: Assumes minimal prior knowledge
* Intermediate: Builds on basic concepts
* Advanced: Requires substantial background knowledge

#### Step 2.2: Map prerequisite knowledge

* What must readers know before starting?
* Which existing guides should they have completed?

#### Step 2.3: Identify logical parent categories

* What broader topic does this belong to?
* Where would readers naturally look for this information?

#### Step 2.4: Consider the learning sequence

* What should readers do immediately before this guide?
* What should they do immediately after?

Now you should have identified a clear place in the step-by-step guide structure to add your new guide to. However, your guide idea might be an edge case where the steps don’t deliver a clear result. In this case, consult the [Common Placement Scenarios and Solutions](#common-placement-scenarios-and-solutions) section for resolving typical classification challenges.

### Step 3: Final validation

Enter this step after you have completed a draft of the new guide. Review the following questions to improve the draft and re-evaluate the proper placement within the structure.

**Quality assurance questions**

1. Does the placement maintain the learning progression?
2. Are the prerequisites clearly stated and available?
3. Does the guide connect logically to the surrounding content?
4. Would a new user naturally find this guide where it's placed?
5. Is the difficulty level appropriate for its position?

We would recommend having someone else go through these questions as part of a peer review process. A fresh perspective from another reviewer can help to spot overlooked details and provide additional insights about the placement.

## Common Placement Scenarios and Solutions

This section provides additional guidance for cases that refuse to get classified through the classification steps. Most likely, your guide idea matches one of the following scenarios:

### Scenario A: "This could fit in multiple places"

The content of your guide appears to be applicable to multiple categories of the guide structure.

**Solution**: Choose the most suitable place based on either of the following:

* The primary use case
* The most common learning path
* The lowest possible skill level

Also reconsider this question from [Step 2.3](#step-23-identify-logical-parent-categories): Where would readers naturally look for this information?

### Scenario B: "This doesn't fit anywhere perfectly"

The new content does not fit well into the given categories or sub-categories.

**Solution**: Evaluate if the content justifies a new category. This would especially be the case if the content can be completed with more missing content for the same category. Otherwise, consider if the guide needs restructuring.

### Scenario C: "This seems too advanced for beginners but too basic for intermediates"

The content doesn’t specifically address the needs of a given skill level, or it spans multiple skill levels.

**Solution**: Verify if your content is really focused on one precise task.

* If it is focused, then you could bridge the gap for beginners by adding an appropriate guide as a prerequisite, to help beginners reach the level of understanding required to make use of your guide.
* If the content turns out to be too broad, aim to split it into beginner-level and intermediate-level content.

### Scenario D: "This is a specialized topic that few people need"

The content doesn’t seem to fit anywhere well because it addresses a very specific problem or a rarely used TYPO3 feature.

**Solution**: Reconsider if the content would make a good step-by-step guide. It might be more appropriate as part of a reference documentation. If you think the content is worth being added to the step-by-step guides, discuss your content idea with the documentation team to determine a placement strategy for this and other niche content.

## Worked Example

Let’s walk through how we might evaluate and place a step-by-step guide that doesn’t have an obvious home: “Enable Open Graph tags for social media sharing”

### At first glance

* Raises multiple classification questions:
  * Is it too narrow to be a standalone guide?
  * Should it be folded into a broader SEO guide?
  * Does it belong in “Building Websites → SEO & Routing” or in an advanced templating or metadata section?
  * Would a beginner know to look there?
* Skill level is debatable — the steps could require working with Fluid templates or TypoScript, which nudges it into intermediate territory.
* Interlinks well — it could connect to guides on meta tags, page properties, Fluid templates, etc.

### Step 1: Pre-classification check

* Applicability: It’s a concrete task with a clear goal and outcome.
* Uniqueness: It overlaps with broader guides like “Configure page metadata for SEO.” Would it duplicate existing steps, or justify its own atomic guide?
* Skill Level: Likely intermediate, due to the need for template or TypoScript edits.

### Step 2: Content classification

* Skill level: Intermediate — some familiarity with Fluid templates or page properties is assumed.
* Prerequisites: Prior experience customizing templates or configuring page settings.
* Logical parent categories:
  * Building Websites → SEO & Routing (focused on outcome)
  * Templates & Theming (focused on how)
* Learning sequence: Might follow “Set a custom page title and meta description”, or lead into “Add Open Graph image previews”.

### Scenario

This guide could easily fall into [Scenario A — multiple placements are possible](#scenario-a-this-could-fit-in-multiple-places).

The deciding factor may be user intent: someone focused on increasing social visibility will look in SEO & Routing, not template customization.

### Final decision

Add the guide under **SEO & Routing**, and link to Fluid or TypoScript references in the steps. This keeps the guide outcome-focused and discoverable by readers with SEO goals.
