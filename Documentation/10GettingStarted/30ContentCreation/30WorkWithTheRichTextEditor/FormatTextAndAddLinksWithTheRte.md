# Format Text and Add Links with the Rich Text Editor
**Tested in:** [TYPO3v13](/Tags/TYPO3v13.md)
**Categories:** [Beginner](/Tags/Beginner.html) [Editing](/Tags/Editing.html) [ContentElements](/Tags/ContentElements.html)
**Author:** [@csabareanu](https://my.typo3.org/u/csabareanu)

The Rich Text Editor (RTE) lets editors write and format content like in a word processor, while still producing clean website-ready HTML.

Formatting text and adding links in the RTE helps you publish readable content, keep a consistent style, and guide users to related pages and documents.

## Learning objective

In this step-by-step guide, you will create a text-based content element, format text using common RTE tools, and add both internal and external links safely.

## Prerequisites

### Tools and technology

* Access to the TYPO3 backend with permission to edit page content
* A page where you can add or edit a content element (for example, a “Regular Text” element)

### Knowledge and skills

* Basic TYPO3 backend navigation (Page module, selecting a page, editing content)

## Create a text content element and open the RTE

1. Open the **Page** module and select the page you want to edit in the page tree.
2. Click **+ Content** in the content area where you want to add text.
3. Choose a text-based content element, such as **Regular Text**.
4. Click into the **Text** field to open the Rich Text Editor toolbar.

> [!NOTE]
> The exact toolbar buttons can differ depending on your TYPO3 configuration and RTE presets.

## Format text with headings, lists, and emphasis

1. Type or paste a short paragraph of text into the editor.
2. Apply **bold** or *italic* formatting:
   * Select a word or phrase.
   * Click **B** (bold) or **I** (italic).
3. Create a heading:
   * Place the cursor in the line you want as a heading.
   * Choose a heading style (for example “Heading 2”) from the format dropdown.
4. Create a list:
   * Select multiple lines, or place the cursor on a new line.
   * Click **Bulleted list** or **Numbered list**.
5. Remove formatting if something looks wrong:
   * Select the affected text.
   * Use the **Remove formatting** action (name and icon depend on configuration).

> [!TIP]
> Prefer headings and lists over “manual styling”. It keeps the content consistent and improves readability.

## Add links (internal, external, email) the safe way

1. Select the text that should become a link (for example “Read more”).
2. Click the **Link** button in the RTE toolbar.
3. Create an internal link:
   * Choose **Page** (or “Internal page”) and pick a page from the page tree.
4. Create an external link:
   * Choose **URL** and paste the full URL (including `https://`).
5. Confirm and save the link.

> [!NOTE]
> Avoid pasting raw URLs directly into the text unless your content style guide explicitly allows it. Using linked text is usually clearer.

## Paste content from Word or Google Docs without messy markup

1. Copy your text from Word / Google Docs.
2. In the RTE, use **Paste as plain text** (if available) or paste first into a plain-text editor and then copy again.
3. Re-apply headings and lists using the RTE tools (instead of keeping imported styling).

> [!TIP]
> This prevents inconsistent fonts, random spacing, and hard-to-debug HTML.

## Summary

Congratulations! You now have a text content element formatted with the Rich Text Editor, using consistent headings and lists, and you can add internal and external links correctly.

## Next steps

Now that you can format text and links with the RTE, you might like to:

* [Add Content Elements](/10GettingStarted/30ContentCreation/20AddContentElements/Index.html)
* [Manage Media Assets](/10GettingStarted/30ContentCreation/40ManageMediaAssets/Index.html)

## Resources

* [The rich text editor (TYPO3 Tutorial for Editors)](https://docs.typo3.org/m/typo3/tutorial-editors/main/en-us/ContentElements/RichTextEditor/Index.html)
* [Rich text editors (RTE) in TYPO3 Core API](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ApiOverview/Rte/Index.html)
