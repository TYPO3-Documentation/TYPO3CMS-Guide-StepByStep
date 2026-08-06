# Show a Custom Field Only When It Has a Value

<!-- #TYPO3v13 #Beginner #Frontend #Templating #SitePackage @dragos_tuluc -->

Custom fields are usually optional — only some pages have a teaser, only some have a hero image. Outputting markup unconditionally produces empty `<p>` tags or broken `<img>` references on pages where the field is empty. Fluid's `<f:if>` ViewHelper handles this cleanly: it renders content only when a condition is truthy, and lets you provide alternate markup with `<f:then>` and `<f:else>`.

## Learning objective

In this step-by-step guide you will use `<f:if>` to conditionally render custom field values in the frontend, and use `<f:then>` / `<f:else>` to display different markup for empty and non-empty cases — particularly useful for boolean checkbox fields.

## Prerequisites

### Tools and technology

* A Composer-based TYPO3 v13 installation
* A Site Package with a working Fluid page template, as described in [Render a Custom Page Field in a Fluid Template](RenderACustomPageFieldInAFluidTemplate.md)
* At least one custom field on the `pages` table — for example, [Add a Text Field to a Page Record](AddATextFieldToAPageRecord.md) or [Add a Checkbox Field to a Page Record](AddACheckboxFieldToAPageRecord.md)
* For the combined-conditions examples in the last task: a dropdown field, as described in [Add a Dropdown Field to a Page Record](AddADropdownFieldToAPageRecord.md)

### Knowledge and skills

* Basic understanding of HTML
* Familiarity with Fluid ViewHelpers

> [!NOTE]
> In the examples below, replace `my_site_package` with your own extension key, and the field names with the ones you used when adding your custom fields.

## Use the simple if pattern

The most common case: render markup only if the field has a value, and render nothing otherwise.

1. Open the file `packages/my_site_package/Resources/Private/Templates/Page/Default.html`.
2. Wrap any field output in `<f:if condition="...">`:

    ```html
    <f:if condition="{data.tx_my_site_package_teaser}">
        <p class="teaser">{data.tx_my_site_package_teaser}</p>
    </f:if>
    ```

3. Save the file.

On pages where the teaser is empty, no `<p class="teaser"></p>` tag is rendered. On pages where it has a value, the paragraph is rendered with that value inside.

> [!NOTE]
> Fluid treats the following as falsy in a condition: an empty string `""`, the integer `0`, the string `"0"`, `null`, `false`, and an empty array `[]`. Anything else is truthy. This works perfectly for both text fields (empty string when blank) and checkbox fields (`0` when unchecked, `1` when checked).

## Use the if/then/else pattern for boolean output

When you want to render *something different* in both cases — for example, a "Featured" badge for highlighted pages and a "Standard" badge otherwise — use `<f:then>` and `<f:else>`.

1. In the same template file, add the following block:

    ```html
    <f:if condition="{data.tx_my_site_package_highlight_page}">
        <f:then>
            <span class="badge badge-featured">★ Featured</span>
        </f:then>
        <f:else>
            <span class="badge badge-standard">Standard</span>
        </f:else>
    </f:if>
    ```

2. Save the file.

Pages where the **Highlight this page** checkbox is checked will render the gold-star featured badge. All other pages will render the standard badge.

> [!TIP]
> If you only need the `<f:then>` branch, you can omit the `<f:then>` and `<f:else>` tags entirely — the simple if pattern from the first task is exactly that. Use `<f:then>` / `<f:else>` only when you want different markup in both cases.

## Combine conditions with logical operators

Sometimes you need to check multiple conditions at once. Fluid's condition syntax supports `&&` (and), `||` (or), `==` (equal), `!=` (not equal), and parentheses.

1. Add a block that only shows when both teaser and category are set:

    ```html
    <f:if condition="{data.tx_my_site_package_teaser} && {data.tx_my_site_package_category}">
        <p class="meta">
            {data.tx_my_site_package_teaser} — category: {data.tx_my_site_package_category}
        </p>
    </f:if>
    ```

2. Or check a specific value:

    ```html
    <f:if condition="{data.tx_my_site_package_category} == 'event'">
        <p class="event-banner">This page is an event!</p>
    </f:if>
    ```

3. Save the file.

## Verify the result in the frontend

Finally, clear the caches and check the frontend on different pages.

1. [Log in to the TYPO3 backend](LogInToTheTypo3Backend.md).
2. Click the **Clear all caches** lightning bolt icon in the top toolbar.
3. Visit a page where the field has a value — your conditional block should render.
4. Visit a page where the field is empty — your conditional block should not render at all (no empty tags).
5. View the page source to confirm the markup is genuinely absent on empty pages, not just visually hidden by CSS.

## Summary

Congratulations! You can now conditionally render custom field values, including using if/then/else for boolean fields and combining multiple conditions. Your frontend output stays clean: no empty tags, no broken layouts, no special-casing in CSS.

## Next steps

Now that you can render fields conditionally, you might like to:

* [Format a Date Value in the Frontend](FormatADateValueInTheFrontend.md)
* [Display an Image from a File Reference Field](DisplayAnImageFromAFileReferenceField.md)
* [Show a Dropdown Selection Label in the Frontend](ShowADropdownSelectionLabelInTheFrontend.md)

## Resources

* [`<f:if>` ViewHelper](https://docs.typo3.org/other/typo3/view-helper-reference/main/en-us/typo3/fluid/latest/If.html)
* [`<f:then>` ViewHelper](https://docs.typo3.org/other/typo3/view-helper-reference/main/en-us/typo3/fluid/latest/Then.html)
* [`<f:else>` ViewHelper](https://docs.typo3.org/other/typo3/view-helper-reference/main/en-us/typo3/fluid/latest/Else.html)
* [Fluid templating engine](https://docs.typo3.org/permalink/t3coreapi:fluid)
