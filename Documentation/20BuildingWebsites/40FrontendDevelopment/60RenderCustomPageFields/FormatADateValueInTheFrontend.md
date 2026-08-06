# Format a Date Value in the Frontend

<!-- #TYPO3v13 #Beginner #Frontend #Templating #SitePackage @dragos_tuluc -->

TYPO3 stores dates as Unix timestamps — large integer numbers that are not human-readable. Outputting `{data.tx_my_site_package_publish_date}` directly would show something like `1730764800` instead of `5 November 2024`. Fluid's `<f:format.date>` ViewHelper turns the timestamp into a properly formatted date string for any locale or layout.

## Learning objective

In this step-by-step guide you will display the value of a custom date field — `tx_my_site_package_publish_date` — in the frontend, formatted as a human-readable date.

## Prerequisites

### Tools and technology

* A Composer-based TYPO3 v13 installation
* A Site Package with a working Fluid page template, as described in [Render a Custom Page Field in a Fluid Template](RenderACustomPageFieldInAFluidTemplate.md)
* A custom date field on the `pages` table, as described in [Add a Date Field to a Page Record](AddADateFieldToAPageRecord.md)
* A page in the page tree where you have picked a date in the **Publish date** field

### Knowledge and skills

* Basic understanding of HTML
* Familiarity with Fluid ViewHelpers
* You know how to [Log in to the TYPO3 Backend](LogInToTheTypo3Backend.md)

> [!NOTE]
> In the examples below, replace `my_site_package` with your own extension key, and `tx_my_site_package_publish_date` with the field name you used when adding your custom field.

## Add the formatted date to the template

Let's open the page template you created in the foundation guide and add a block that formats and displays the date.

1. Open the file `packages/my_site_package/Resources/Private/Templates/Page/Default.html`.
2. Inside the `<body>`, below the existing content, add the following block:

    ```html
    <f:if condition="{data.tx_my_site_package_publish_date}">
        <p class="publish-date">
            Published on:
            <f:format.date format="d.m.Y">{data.tx_my_site_package_publish_date}</f:format.date>
        </p>
    </f:if>
    ```

3. Save the file.

The template now displays a "Published on:" line followed by the formatted date, but only on pages where the date field has a value.

> [!TIP]
> The `format` argument follows PHP's date format syntax. Common patterns:
>
> * `d.m.Y` → `05.11.2024`
> * `Y-m-d` → `2024-11-05`
> * `j F Y` → `5 November 2024`
> * `l, j F Y` → `Tuesday, 5 November 2024`

## Verify the result in the frontend

Finally, clear the caches and check the frontend.

1. [Log in to the TYPO3 backend](LogInToTheTypo3Backend.md).
2. Click the **Clear all caches** lightning bolt icon in the top toolbar.
3. Open the page properties of a page where you have picked a date.
4. Confirm the **Publish date** field still has a value, then save.
5. Visit the same page in your browser's frontend.

You should see a `<p class="publish-date">` element with the text "Published on:" followed by your formatted date.

> [!TIP]
> If the date does not appear, check:
>
> * That the date field has actually been picked for that page (the `<f:if>` hides empty / zero values).
> * That you ran the `<f:format.date>` ViewHelper, not just `{data.tx_my_site_package_publish_date}` (which would show the raw timestamp).
> * That you cleared the TYPO3 caches.

## Summary

Congratulations! You have formatted and displayed a custom date field in the frontend. The Unix timestamp stored by TYPO3 is now presented as a human-readable date in the format you chose.

## Next steps

Now that you can format dates, you might like to:

* [Display an Image from a File Reference Field](DisplayAnImageFromAFileReferenceField.md)
* [Show a Dropdown Selection Label in the Frontend](ShowADropdownSelectionLabelInTheFrontend.md)
* [Show a Custom Field Only When It Has a Value](ShowACustomFieldOnlyWhenItHasAValue.md)

## Resources

* [`<f:format.date>` ViewHelper](https://docs.typo3.org/other/typo3/view-helper-reference/main/en-us/typo3/fluid/latest/Format/Date.html)
* [PHP date format characters](https://www.php.net/manual/en/datetime.format.php)
* [Fluid templating engine](https://docs.typo3.org/permalink/t3coreapi:fluid)
