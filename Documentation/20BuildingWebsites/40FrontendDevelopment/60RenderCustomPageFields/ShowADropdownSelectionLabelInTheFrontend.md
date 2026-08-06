# Show a Dropdown Selection Label in the Frontend

<!-- #TYPO3v13 #Beginner #Frontend #Templating #SitePackage @dragos_tuluc -->

A TCA dropdown stores a short machine value (`news`, `event`, `article`) but editors and visitors expect to see the human-readable label (`News`, `Event`, `Article`). Fluid's `<f:switch>` ViewHelper maps stored values back to display labels, so the frontend shows the right text instead of the raw key.

## Learning objective

In this step-by-step guide you will display the selected option of a custom dropdown field — `tx_my_site_package_category` — in the frontend, mapped from its stored value to a human-readable label.

## Prerequisites

### Tools and technology

* A Composer-based TYPO3 v13 installation
* A Site Package with a working Fluid page template, as described in [Render a Custom Page Field in a Fluid Template](RenderACustomPageFieldInAFluidTemplate.md)
* A custom dropdown field on the `pages` table, as described in [Add a Dropdown Field to a Page Record](AddADropdownFieldToAPageRecord.md)
* A page in the page tree where you have picked a value in the **Category** field

### Knowledge and skills

* Basic understanding of HTML
* Familiarity with Fluid ViewHelpers
* You know how to [Log in to the TYPO3 Backend](LogInToTheTypo3Backend.md)

> [!NOTE]
> In the examples below, replace `my_site_package` with your own extension key, and `tx_my_site_package_category` with the field name you used when adding your custom field.

## Display the raw value (the simple case)

Let's first see what happens if you output the field directly, then improve it.

1. Open the file `packages/my_site_package/Resources/Private/Templates/Page/Default.html`.
2. Inside the `<body>`, below the existing content, add the following block:

    ```html
    <f:if condition="{data.tx_my_site_package_category}">
        <p class="category-raw">Category (raw): {data.tx_my_site_package_category}</p>
    </f:if>
    ```

3. Save the file and visit the page in the frontend.

You will see something like `Category (raw): news` — the stored value, not the label the editor saw in the dropdown.

## Map the value to a human-readable label

Now let's improve it by mapping each stored value to the label that should appear on the website.

1. In the same template file, replace the block you just added with:

    ```html
    <f:if condition="{data.tx_my_site_package_category}">
        <p class="category">
            Category:
            <f:switch expression="{data.tx_my_site_package_category}">
                <f:case value="news">News</f:case>
                <f:case value="event">Event</f:case>
                <f:case value="article">Article</f:case>
                <f:case value="tutorial">Tutorial</f:case>
                <f:defaultCase>{data.tx_my_site_package_category}</f:defaultCase>
            </f:switch>
        </p>
    </f:if>
    ```

2. Save the file.

The template now outputs a friendly label for each stored value. The `<f:defaultCase>` is a safety net: if a value is ever stored that is not in the list (for example, after you add a new category to TCA but forget to update the template), the raw value is shown instead of nothing.

> [!IMPORTANT]
> The labels in `<f:switch>` are duplicated from your TCA `items` array. If you change a label in TCA, you must also change it here. For larger projects, consider using language files (`LLL:EXT:my_site_package/Resources/Private/Language/locallang.xlf`) so labels are defined once and reused in both places. That is beyond the scope of this guide.

## Verify the result in the frontend

Finally, clear the caches and check the frontend.

1. [Log in to the TYPO3 backend](LogInToTheTypo3Backend.md).
2. Click the **Clear all caches** lightning bolt icon in the top toolbar.
3. Open the page properties of a page where you have picked a category.
4. Confirm the **Category** field still has a value, then save.
5. Visit the same page in your browser's frontend.

You should see a `<p class="category">` element with the text "Category:" followed by the human-readable label that matches your selection (for example, "News" if you picked News).

> [!TIP]
> If the label does not appear, check:
>
> * That a category has actually been picked for that page.
> * That the `value=""` attributes in your `<f:case>` tags exactly match the values in your TCA `items` array (case-sensitive).
> * That you cleared the TYPO3 caches.

## Summary

Congratulations! You have mapped a TCA dropdown's machine values to human-readable labels in the frontend. Visitors now see meaningful text instead of internal keys.

## Next steps

Now that you can render dropdown labels, you might like to:

* [Format a Date Value in the Frontend](FormatADateValueInTheFrontend.md)
* [Display an Image from a File Reference Field](DisplayAnImageFromAFileReferenceField.md)
* [Show a Custom Field Only When It Has a Value](ShowACustomFieldOnlyWhenItHasAValue.md)

## Resources

* [`<f:switch>` ViewHelper](https://docs.typo3.org/other/typo3/view-helper-reference/main/en-us/typo3/fluid/latest/Switch.html)
* [`<f:case>` ViewHelper](https://docs.typo3.org/other/typo3/view-helper-reference/main/en-us/typo3/fluid/latest/Case.html)
* [Localization with language files](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ApiOverview/Internationalization/Index.html)
* [Fluid templating engine](https://docs.typo3.org/permalink/t3coreapi:fluid)
