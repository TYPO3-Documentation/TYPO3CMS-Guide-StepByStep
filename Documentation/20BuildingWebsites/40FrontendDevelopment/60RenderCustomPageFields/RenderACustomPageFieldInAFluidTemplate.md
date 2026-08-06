# Render a Custom Page Field in a Fluid Template

<!-- #TYPO3v13 #Beginner #Frontend #Templating #SitePackage @dragos_tuluc -->

After adding a custom field to a TYPO3 page record, the next step is to actually display that data on your website. The standard way to render TYPO3 pages with Fluid is the `FLUIDTEMPLATE` content object. When `FLUIDTEMPLATE` is the page renderer, the current page record — including any custom TCA fields — is automatically available in your template through the `{data}` variable.

## Learning objective

In this step-by-step guide you will configure `FLUIDTEMPLATE` in a Site Set, create a Fluid page template, and display the value of a custom page field — `tx_my_site_package_teaser` — in the frontend.

## Prerequisites

### Tools and technology

* A Composer-based TYPO3 v13 installation
* A Site Package created and installed as described in [Create the Site Package File Structure](CreateTheSitePackageFileStructure.md) and [Register and Install a Site Package](RegisterAndInstallSitePackage.md)
* A custom text field on the `pages` table, as described in [Add a Text Field to a Page Record](AddATextFieldToAPageRecord.md)
* A page in the page tree where you have entered a value in the **Teaser text** field
* A code editor

### Knowledge and skills

* Basic knowledge of working with files in a Site Package
* Basic understanding of HTML
* You know how to [Log in to the TYPO3 Backend](LogInToTheTypo3Backend.md)

> [!NOTE]
> In the examples below, replace `my_site_package` with your own extension key, and `my-vendor/my-site-package` with the Composer name of your Site Package.
>
> Replace `tx_my_site_package_teaser` with the field name you used when adding your custom field.

> [!NOTE]
> If your Site Set already has a `setup.typoscript` with a `page = PAGE` block (for example, if you followed [Create a Site Set with Editable Settings and Custom CSS](CreateASiteSet.md) earlier), you can either replace that block with the configuration below or merge the two — only one `page = PAGE` definition can be active at a time.

## Configure FLUIDTEMPLATE in your Site Set

First, let's tell TYPO3 to render pages through `FLUIDTEMPLATE` and point it at the folder where your Fluid templates will live.

1. Open the file `packages/my_site_package/Configuration/Sets/SitePackage/setup.typoscript`.
2. If the file does not exist yet, create it.
3. Add the following TypoScript:

    ```typoscript
    page = PAGE
    page.typeNum = 0
    page.10 = FLUIDTEMPLATE
    page.10 {
        # Fluid resolves the template name to Default.html
        templateName = Default
        templateRootPaths.10 = EXT:my_site_package/Resources/Private/Templates/Page/
    }
    ```

> [!WARNING]
> Never put a `#` comment on the same line *after* a TypoScript assignment. Everything after the `=` — including the would-be comment — becomes part of the value, so `templateName = Default  # comment` makes TYPO3 look for a template literally named `Default  # comment`, and the page fails to render. Comments must go on their own line.

4. Save the file.

TYPO3 now knows to render every page through the `FLUIDTEMPLATE` object, looking for `Default.html` inside the configured `Page/` folder.

> [!TIP]
> `FLUIDTEMPLATE` is the long-established way to render TYPO3 pages with Fluid. TYPO3 v13 also offers the newer `PAGEVIEW` content object as a more concise alternative, but `FLUIDTEMPLATE` remains the broadly used standard across the TYPO3 ecosystem (Bootstrap Package, sitepackagebuilder.com scaffolding, most existing tutorials).

## Create the Page template directory

Next, we'll create the folder where Fluid will look for the page template.

1. Inside your Site Package, create the following folder structure if it does not exist yet:

    ```text
    packages/my_site_package/
    └── Resources/
        └── Private/
            └── Templates/
                └── Page/
    ```

2. Make sure the path matches exactly what you configured under `templateRootPaths.10` in `setup.typoscript`.

The folder is now ready to hold the page template.

> [!NOTE]
> The convention `Templates/Page/` (singular) is what most TYPO3 site packages use. If you have followed a tutorial that uses `Templates/Pages/` (plural) instead — for example, the `PAGEVIEW`-based approach — keep the folder name and the TypoScript path consistent with each other.

## Create the page template

Now we'll create the Fluid template that `FLUIDTEMPLATE` will render.

1. Create a new file at `packages/my_site_package/Resources/Private/Templates/Page/Default.html`.
2. Add the following minimal HTML and Fluid markup:

    ```html
    <html xmlns:f="http://typo3.org/ns/TYPO3/CMS/Fluid/ViewHelpers"
          data-namespace-typo3-fluid="true">
    <body>
        <h1>{data.title}</h1>

        <f:if condition="{data.tx_my_site_package_teaser}">
            <p class="teaser">{data.tx_my_site_package_teaser}</p>
        </f:if>
    </body>
    </html>
    ```

3. Save the file.

The template now outputs the page title and displays the teaser only when the field has a value. Pages where the field is empty will not render the empty `<p>` tag.

> [!NOTE]
> In a `FLUIDTEMPLATE` page template, `{data}` is the current cObject's data. When the cObject is `page.10` — the page renderer — `{data}` is the page record array. This means every column on the `pages` table is directly accessible: `{data.title}`, `{data.subtitle}`, `{data.uid}`, and your own custom fields like `{data.tx_my_site_package_teaser}`.

## Activate the Site Set on your site

For TYPO3 to apply your TypoScript and template, the Site Set must be added to the site configuration.

1. Open your site configuration file at `config/sites/<your-site>/config.yaml`, where `<your-site>` is your site identifier.
2. Under the `dependencies` key, add your Site Set:

    ```yaml
    dependencies:
        - my-vendor/my-site-package
    ```

3. Save the file.

Your site will now load the Site Set's TypoScript and templates on every page request.

> [!IMPORTANT]
> If your TYPO3 installation was created with the setup wizard (the `typo3 setup` command or the graphical installer with "Create a site" enabled), a **sys_template** record named *"Main TypoScript Rendering"* already exists on your root page. A root-level `sys_template` record takes precedence over Site Set TypoScript, so your template will silently not be used — the site keeps showing the default TYPO3 welcome page. Open the **List** module on the root page and delete (or empty) that *Template* record before verifying.

## Verify the result in the frontend

Finally, clear the caches and check the frontend.

1. [Log in to the TYPO3 backend](LogInToTheTypo3Backend.md).
2. Click the **Clear all caches** lightning bolt icon in the top toolbar.
3. Open the page properties of a page where you previously entered a teaser text.
4. Confirm the **Teaser text** field still contains a value, then save the page.
5. Visit the same page in your browser's frontend.

You should see the page title in an `<h1>` element, followed by the teaser text in a `<p class="teaser">` element below it.

> [!TIP]
> If the teaser does not appear, check:
>
> * That you have actually entered a value in the field on that specific page (the `<f:if>` hides empty values).
> * That your Site Set is listed under `dependencies` in `config/sites/<your-site>/config.yaml`.
> * That the path under `templateRootPaths.10` matches the actual folder path of your template.
> * That you cleared the TYPO3 caches after every change.
> * That no `sys_template` record on a parent page has the **Clear** flag set to **Constants** or **Setup** — that flag wipes Site Set TypoScript before it reaches your page.

## Summary

Congratulations! You have rendered a custom page field in the frontend using `FLUIDTEMPLATE`. The value editors enter in page properties now appears on the page itself — closing the loop between TCA configuration and visible output.

## Next steps

Now that you can render plain text fields, you might like to:

* [Format a Date Value in the Frontend](FormatADateValueInTheFrontend.md)
* [Display an Image from a File Reference Field](DisplayAnImageFromAFileReferenceField.md)
* [Show a Dropdown Selection Label in the Frontend](ShowADropdownSelectionLabelInTheFrontend.md)
* [Render a Rich Text Field as HTML](RenderARichTextFieldAsHtml.md)
* [Show a Custom Field Only When It Has a Value](ShowACustomFieldOnlyWhenItHasAValue.md)

## Resources

* [FLUIDTEMPLATE content object](https://docs.typo3.org/m/typo3/reference-typoscript/main/en-us/ContentObjects/Fluidtemplate/Index.html)
* [Site Sets](https://docs.typo3.org/permalink/t3coreapi:site-sets)
* [Fluid templating engine](https://docs.typo3.org/permalink/t3coreapi:fluid)
* [PAGEVIEW content object](https://docs.typo3.org/m/typo3/reference-typoscript/main/en-us/ContentObjects/Pageview/Index.html) — modern alternative to FLUIDTEMPLATE
* [Create a Site Set with Editable Settings and Custom CSS](CreateASiteSet.md) — extends the basic Site Set with site settings and CSS
