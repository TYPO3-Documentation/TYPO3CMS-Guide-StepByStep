# Create Custom Content Elements

<!-- #TYPO3v14 #Advanced #ContentElements #Backend #Editing @delfynn2kx -->

TYPO3 organizes the content of a page in blocks, called content elements. Custom content elements allow you to extend TYPO3 with your own reusable content types. They are useful when the default content elements do not meet your project's requirements.

Create a custom content element when:

* You need reusable structured content
* You want consistent layouts
* You need additional fields beyond the default ones

## Learning objective

In this step-by-step guide you will learn how to:

* Register a custom content element
* Add custom fields using TCA
* Configure TypoScript
* Customize the content element template

## Prerequisites

### Tools and technology

* TYPO3 v14 installation
* Access to the TYPO3 backend
* A sitepackage extension

### Knowledge and skills

* Basic knowledge of the TYPO3 backend
* Basic understanding of TypoScript
* Basic knowledge of Fluid templates

## Add TCA configuration

Define the fields for your custom content element, for example:

* Title
* Type
* Text

Expected outcome:

* The new content element type is available in the backend.
* The custom fields are displayed in the editing form.

## Add TypoScript

Register the new content element in TypoScript so that the frontend knows how to render it.

Expected outcome:

* TYPO3 renders the content element in the frontend.

## Create a Fluid template for the new content element

Create the Fluid template that defines the frontend output of the content element, as described in [Create the Fluid templates](https://docs.typo3.org/m/typo3/tutorial-sitepackage/main/en-us/FluidTemplates/FromTheScratch.html#create-the-fluid-templates).

Expected outcome:

* The content element is displayed with your own markup.

## Add the icon and label

Define an icon and a label so the content element appears correctly in the backend.

Expected outcome:

* The content element is listed with its own icon and label in the "New content element" wizard.

## Summary

Congratulations! You have learned the basic steps required to create a custom content element in TYPO3. You can now extend TYPO3 with your own reusable content types.

## Next steps

Now that you have learned how to create custom content elements, you might like to:

* [Customize a content element template](../20BuildingWebsites/10ContentManagement/20CreateCustomContentElements/CustomizeAContentElementTemplate.md)

## Resources

* [TYPO3 TCA Reference](https://docs.typo3.org/m/typo3/reference-tca/main/en-us/Index.html)
* [Sitepackage Tutorial: Fluid templates](https://docs.typo3.org/m/typo3/tutorial-sitepackage/main/en-us/FluidTemplates/FromTheScratch.html)
* [TYPO3 v14 Documentation](https://docs.typo3.org)