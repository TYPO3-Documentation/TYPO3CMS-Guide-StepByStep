# Add Content Elements to a Page

 **Tested in:** [TYPO3v13](/Tags/TYPO3v13.md) **Categories:** [Beginner](/Tags/Beginner.md) [ContentElements](/Tags/ContentElements.md) [Backend](/Tags/Backend.md) [Editing](/Tags/Editing.md) [Configuration](/Tags/Configuration.md) **Author:** [@ninaaline](https://my.typo3.org/u/ninaaline)

Once you have created pages on your TYPO3 website, the next step is to fill them with content. TYPO3 uses content elements to build page content in a flexible and modular way. Content elements can be text blocks, images, headers, lists, or more complex components like forms or videos.

This guide shows you how to add content elements to a page using the TYPO3 Backend's **Page** module.

## Learning Objective

In this step-by-step guide, you will add content elements to a page in TYPO3 and explore the different types of content elements available.

## Prerequisites

### Tools and technology

* A web browser
* A computer with a local TYPO3 installation or access to a TYPO3 instance
* A TYPO3 Backend user with editor or administrator privileges
* At least one existing page where you want to add content (see [Create a Page with Drag and Drop](/10GettingStarted/30ContentCreation/10CreateAndOrganizePages/CreateAPageWithDragAndDrop.md))

### Knowledge and skills

* You know how to [Log In to the TYPO3 Backend](/10GettingStarted/20BasicConfiguration/10BackendBasics/LogInToTheTypo3Backend.md)

## Open the Page Module

1. Log in to the TYPO3 Backend.
2. Open the **Page** module from the left-hand menu.

   ![TYPO3 sidebar menu displaying the Page module icon highlighted.](Images/AddContentElements/PageModule.png)

3. In the page tree on the left, click on the page where you want to add content.

## Add a Content Element

1. In the main content area, locate the area where you want to add your content element. You will see a **+ Content** button or a similar placeholder.

   ![The TYPO3 Page module showing the content area with a "+ Content" button.](Images/AddContentElements/AddContentButton.png)

2. Click on the **+ Content** button. This opens the **New Content Element Wizard**, which displays all available content element types organized by category.

   ![The New Content Element Wizard showing different categories and content element types.](Images/AddContentElements/ContentElementWizard.png)

3. Browse through the available categories:
   * **Typical Page Content** – Standard elements like text, text with images, lists, and tables
   * **Form Elements** – Contact forms and other form-related components
   * **Lists** - Elements that display categorized content or pages from your site structure
   * **Menu** - Navigation elements like page menus, sitemaps, and section indexes
   * **Special Elements** – Advanced elements like HTML code, menu sections, or dividers
4. Select a content element type by clicking on it. For this guide, we will select **Regular Text Element** from the **Typical Page Content** category.

## Configure the Content Element

1. After selecting a content element type, TYPO3 opens the content element editor.

   ![The content element editor showing fields for header, type, and text content.](Images/AddContentElements/ContentElementEditor.png)

2. Fill in the fields:
   * **Header** – Enter a headline for your content element (optional)
   * **Text** – Enter your content in the Rich Text Editor (RTE). You can format text, add links, or insert images using the editor toolbar.
3. Optionally, configure additional settings in the tabs at the top:
   * **Appearance** – Control the layout and styling of the element
   * **Access** – Set visibility and access restrictions
   * **Language** – Manage translations for multilingual sites
   * **Categories** – Assign the element to content categories
4. At the top of the form, click **Save** to save your content element.
5. At the top of the form, click **Close** to return to the Page module.

After saving, your new content element appears in the Page module's content area.

![The Page module displaying the newly created content element in the content area.](Images/AddContentElements/ContentElementAdded.png)

## View the Content Element on a Website

1. To view your content element on the frontend, click the **View webpage** button in the top toolbar or navigate to your website in a new browser tab.

   ![The frontend of the TYPO3 website displaying the newly added content element.](Images/AddContentElements/FrontendView.png)

> [!NOTE]
> If your changes do not appear immediately on the frontend, you may need to clear the frontend cache. See [Clearing the Frontend Cache in the TYPO3 Backend](/10GettingStarted/20BasicConfiguration/10BackendBasics/ClearingFrontendCacheInTypo3Backend.md).

## Summary

You have successfully added a content element to a page in TYPO3. You opened the Page module, selected a content element type from the New Content Element Wizard, configured the element, and viewed it on a website.

## Next Steps

Now that you've added content to your page, you might like to:

* *Work with the Rich Text Editor* [(CREATE)](https://github.com/TYPO3-Documentation/TYPO3CMS-Guide-StepByStep/new/contrib/Documentation/00Incoming?filename=WorkWithTheRichTextEditor.md&value=Copy%20content%20the%20template%20from%3A%20https%3A%2F%2Fraw.githubusercontent.com%2FTYPO3-Documentation%2FTYPO3CMS-Guide-StepByStep%2Frefs%2Fheads%2Fcontrib%2FDocumentation%2F90Contribute%2F10Template%2FIndex.md "Create this missing step-by-step guide") to format your text content
* *Manage Media Assets* [(CREATE)](https://github.com/TYPO3-Documentation/TYPO3CMS-Guide-StepByStep/new/contrib/Documentation/00Incoming?filename=ManageMediaAssets.md&value=Copy%20content%20the%20template%20from%3A%20https%3A%2F%2Fraw.githubusercontent.com%2FTYPO3-Documentation%2FTYPO3CMS-Guide-StepByStep%2Frefs%2Fheads%2Fcontrib%2FDocumentation%2F90Contribute%2F10Template%2FIndex.md "Create this missing step-by-step guide") to add images and other media to your content
* *Create Custom Content Elements* [(CREATE)](https://github.com/TYPO3-Documentation/TYPO3CMS-Guide-StepByStep/new/contrib/Documentation/00Incoming?filename=CreateCustomContentElements.md&value=Copy%20content%20the%20template%20from%3A%20https%3A%2F%2Fraw.githubusercontent.com%2FTYPO3-Documentation%2FTYPO3CMS-Guide-StepByStep%2Frefs%2Fheads%2Fcontrib%2FDocumentation%2F90Contribute%2F10Template%2FIndex.md "Create this missing step-by-step guide") for more advanced layouts

## Resources

* [Working with Content Elements in the TYPO3 Editors Tutorial](https://docs.typo3.org/permalink/t3editors:content-working)
* [Content Elements Reference](https://docs.typo3.org/permalink/t3coreapi:content-elements)
