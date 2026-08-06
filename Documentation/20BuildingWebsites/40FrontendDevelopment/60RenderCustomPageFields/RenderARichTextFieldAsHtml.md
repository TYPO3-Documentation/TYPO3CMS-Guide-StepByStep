# Render a Rich Text Field as HTML

<!-- #TYPO3v13 #Beginner #Frontend #Templating #SitePackage @dragos_tuluc -->

When a textarea field has the rich text editor enabled, editors can format their text with bold, italic, lists, links, and headings. The field stores HTML markup in the database. Outputting `{data.field}` directly would escape the markup — visitors would see literal `<strong>` tags as text. Fluid's `<f:format.html>` ViewHelper renders the stored HTML as actual HTML, while still applying TYPO3's link processing for internal page references.

## Learning objective

In this step-by-step guide you will enable the rich text editor on a textarea field, then render its HTML content correctly in the frontend with `<f:format.html>`.

## Prerequisites

### Tools and technology

* A Composer-based TYPO3 v13 installation
* A Site Package with a working Fluid page template, as described in [Render a Custom Page Field in a Fluid Template](RenderACustomPageFieldInAFluidTemplate.md)
* A custom textarea field on the `pages` table, as described in [Add a Textarea Field to a Page Record](AddATextareaFieldToAPageRecord.md)

### Knowledge and skills

* Basic understanding of HTML
* Familiarity with Fluid ViewHelpers
* You know how to [Log in to the TYPO3 Backend](LogInToTheTypo3Backend.md)

> [!NOTE]
> In the examples below, replace `my_site_package` with your own extension key, and `tx_my_site_package_summary` with the field name you used when adding your custom textarea field.

## Enable the rich text editor on the field

First, let's tell TCA to render the textarea as a rich text editor with formatting toolbar.

1. Open the file `packages/my_site_package/Configuration/TCA/Overrides/pages.php`.
2. Find the `tx_my_site_package_summary` definition.
3. Inside its `config` array, add `'enableRichtext' => true`:

    ```php
    'tx_my_site_package_summary' => [
        'exclude' => true,
        'label' => 'Page summary',
        'config' => [
            'type' => 'text',
            'rows' => 5,
            'cols' => 40,
            'enableRichtext' => true,           // turn the textarea into an RTE
        ],
    ],
    ```

4. Save the file.
5. [Log in to the TYPO3 backend](LogInToTheTypo3Backend.md), clear caches, and open page properties of any page.
6. Confirm the **Page summary** field now displays a formatting toolbar (bold, italic, lists, links).
7. Enter some formatted content — for example, a heading, a bold word, and a paragraph — and save.

The field now stores HTML markup such as `<h2>Title</h2><p>Some <strong>formatted</strong> text.</p>`.

## See what happens without the ViewHelper

To understand why `<f:format.html>` is needed, let's first try outputting the field directly.

1. Open the file `packages/my_site_package/Resources/Private/Templates/Page/Default.html`.
2. Add the following block:

    ```html
    <f:if condition="{data.tx_my_site_package_summary}">
        <div class="summary-broken">
            {data.tx_my_site_package_summary}
        </div>
    </f:if>
    ```

3. Save the file, clear caches, and visit the page in the frontend.

You will see the literal HTML markup as text — including the angle brackets — instead of formatted content. This is Fluid's safe default: it escapes any HTML in variables to prevent injection vulnerabilities.

## Render the field as actual HTML

Now let's wrap the field in `<f:format.html>` so the stored markup renders correctly.

1. In the same template file, replace the block you just added with:

    ```html
    <f:if condition="{data.tx_my_site_package_summary}">
        <div class="summary">
            <f:format.html>{data.tx_my_site_package_summary}</f:format.html>
        </div>
    </f:if>
    ```

2. Save the file.

The template now passes the stored HTML through TYPO3's HTML parser. Beyond simply un-escaping the markup, the parser also resolves internal `t3://` links (such as links to other pages picked through the RTE link browser) and applies any RTE-related cleanup configured for your site.

> [!IMPORTANT]
> Use `<f:format.html>` only on fields that come from a trusted rich text editor. Never use it on fields that accept arbitrary user input from the frontend (form submissions, comments, anything an unauthenticated visitor can write to). Doing so opens the door to cross-site scripting (XSS) attacks. Editor-supplied RTE content is trusted because TYPO3's RTE strips dangerous markup at save time.

## Verify the result in the frontend

Finally, clear the caches and check the frontend.

1. Click the **Clear all caches** lightning bolt icon in the top toolbar.
2. Open the page properties of the page where you entered formatted content.
3. Confirm the content is still there in the RTE, then save.
4. Visit the page in your browser's frontend.
5. View the page source.

You should see your formatted content rendered as actual HTML — headings, bold text, paragraphs — and the page source should show the corresponding `<h2>`, `<strong>`, `<p>` tags.

> [!TIP]
> If the content still appears as escaped text:
>
> * Confirm you wrapped the field in `<f:format.html>...</f:format.html>`, not `<f:format.raw>`. The `raw` ViewHelper outputs unprocessed content (no link resolution), while `html` runs the full HTML parser.
> * Confirm `enableRichtext: true` was applied to the field's TCA configuration.
> * Confirm you cleared the TYPO3 caches after both the TCA and template changes.

## Summary

Congratulations! You enabled the rich text editor on a custom textarea field and rendered its HTML content correctly in the frontend. Editors can now format their text with the familiar toolbar, and visitors see properly formatted output — with internal links resolved automatically.

## Next steps

Now that you can render rich text, you might like to:

* [Format a Date Value in the Frontend](FormatADateValueInTheFrontend.md)
* [Display an Image from a File Reference Field](DisplayAnImageFromAFileReferenceField.md)
* [Show a Custom Field Only When It Has a Value](ShowACustomFieldOnlyWhenItHasAValue.md)

## Resources

* [`<f:format.html>` ViewHelper](https://docs.typo3.org/other/typo3/view-helper-reference/main/en-us/typo3/fluid/latest/Format/Html.html)
* [`enableRichtext` TCA property](https://docs.typo3.org/m/typo3/reference-tca/main/en-us/ColumnsConfig/Type/Text/Properties/EnableRichtext.html)
* [TYPO3 Rich Text Editor reference](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/RteCkeditor/Index.html)
* [Fluid templating engine](https://docs.typo3.org/permalink/t3coreapi:fluid)
