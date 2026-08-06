# Display an Image from a File Reference Field

<!-- #TYPO3v13 #Beginner #Frontend #Templating #SitePackage @dragos_tuluc -->

A TCA file reference field stores only the *count* of attached files in the page record. The actual files live in TYPO3's File Abstraction Layer (FAL) and must be fetched explicitly before they can be rendered. The `FilesProcessor` is a built-in TypoScript data processor that resolves a FAL field into ready-to-use file objects in your Fluid template.

## Learning objective

In this step-by-step guide you will configure `FilesProcessor` to expose the files attached to `tx_my_site_package_hero_image`, then render the first attached image as an `<img>` tag in the frontend.

## Prerequisites

### Tools and technology

* A Composer-based TYPO3 v13 installation
* A Site Package with a working Fluid page template, as described in [Render a Custom Page Field in a Fluid Template](RenderACustomPageFieldInAFluidTemplate.md)
* A custom file reference field on the `pages` table, as described in [Add a File Reference Field to a Page Record](AddAFileReferenceFieldToAPageRecord.md)
* A page in the page tree where you have attached an image to the **Hero image** field

### Knowledge and skills

* Basic understanding of HTML
* Familiarity with Fluid ViewHelpers
* You know how to [Log in to the TYPO3 Backend](LogInToTheTypo3Backend.md)

> [!NOTE]
> In the examples below, replace `my_site_package` with your own extension key, and `tx_my_site_package_hero_image` with the field name you used when adding your custom field.

## Configure the FilesProcessor in your Site Set

First, let's tell TYPO3 to fetch the file references for our custom field and expose them as a Fluid variable named `heroImage`.

1. Open the file `packages/my_site_package/Configuration/Sets/SitePackage/setup.typoscript`.
2. Inside the existing `page.10 = FLUIDTEMPLATE` block, add or extend the `dataProcessing` section:

    ```typoscript
    page.10 {
        dataProcessing {
            30 = TYPO3\CMS\Frontend\DataProcessing\FilesProcessor
            30 {
                references.fieldName = tx_my_site_package_hero_image
                as = heroImage
            }
        }
    }
    ```

3. Save the file.

TYPO3 will now resolve the file references for that column on every page request and expose them in Fluid as `{heroImage}` — an array of file objects.

> [!NOTE]
> The numeric key (`30` in this example) is just the order in which data processors run. If your `dataProcessing` already uses `10` and `20` for other processors, pick the next free number. The exact value doesn't matter as long as it's unique within the block.

## Render the image in the template

Now let's open the page template and add a block that renders the first attached image.

1. Open the file `packages/my_site_package/Resources/Private/Templates/Page/Default.html`.
2. Inside the `<body>`, below the existing content, add the following block:

    ```html
    <f:if condition="{heroImage.0}">
        <figure class="hero">
            <f:image
                image="{heroImage.0}"
                alt="{heroImage.0.alternative}"
                title="{heroImage.0.title}"
                width="1200"
            />
        </figure>
    </f:if>
    ```

3. Save the file.

The template now renders the first attached image inside a `<figure>` element, with the editor-supplied alternative text and title, scaled to a width of 1200 pixels.

> [!TIP]
> The `<f:image>` ViewHelper handles the heavy lifting: it resolves the FAL reference, generates a properly sized image variant via TYPO3's image processing, and outputs a fully formed `<img>` tag with `src`, `width`, and `height`.

## Verify the result in the frontend

Finally, clear the caches and check the frontend.

1. [Log in to the TYPO3 backend](LogInToTheTypo3Backend.md).
2. Click the **Clear all caches** lightning bolt icon in the top toolbar.
3. Open the page properties of a page where you have attached an image to **Hero image**.
4. Confirm the image is still attached, then save the page.
5. Visit the same page in your browser's frontend.

You should see a `<figure class="hero">` element containing a properly sized `<img>` tag with the image you attached. View the page source to confirm the `src` attribute points to a TYPO3-processed image variant in `/fileadmin/_processed_/...`.

> [!TIP]
> If the image does not appear, check:
>
> * That an image is actually attached to that specific page (the `<f:if>` hides the block when no image is present).
> * That the `references.fieldName` value in `setup.typoscript` matches your TCA field name exactly.
> * That you cleared the TYPO3 caches after both the TypoScript and template changes.

## Summary

Congratulations! You have rendered an image from a custom file reference field in the frontend. Editors can now attach a hero image to any page, and TYPO3 outputs a properly processed `<img>` tag with the right dimensions and accessibility attributes.

## Next steps

Now that you can display an image, you might like to:

* [Format a Date Value in the Frontend](FormatADateValueInTheFrontend.md)
* [Show a Dropdown Selection Label in the Frontend](ShowADropdownSelectionLabelInTheFrontend.md)
* [Show a Custom Field Only When It Has a Value](ShowACustomFieldOnlyWhenItHasAValue.md)

## Resources

* [`<f:image>` ViewHelper](https://docs.typo3.org/other/typo3/view-helper-reference/main/en-us/typo3/fluid/latest/Image.html)
* [FilesProcessor reference](https://docs.typo3.org/m/typo3/reference-typoscript/main/en-us/ContentObjects/Fluidtemplate/Dataprocessing/FilesProcessor.html)
* [File Abstraction Layer (FAL)](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ApiOverview/Fal/Index.html)
* [Image rendering in TYPO3](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ApiOverview/FileAbstractionLayer/UsingFilesInFluidTemplates.html)
