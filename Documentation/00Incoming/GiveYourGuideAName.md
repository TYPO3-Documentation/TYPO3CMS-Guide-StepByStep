# Create an Extbase Plugin with friendsoftypo3/kickstarter

<!-- #TYPO3v13 #Advanced #kickstarter #Extbase #Plugin #Configuration @lina.wolf -->

Create an extension using friendsoftypo3/kickstarter witch features an Extbase Plugin.

## Learning objective

In this step-by-step guide you will learn to write a custom extension with the Kickstarter.

## Prerequisites

### Tools and technology

* TYPO3 13.4 Composer based installation
  
### Knowledge and skills

* PHP Development
  
## Install the Kickstarter extension

Install kickstarter:

```
ddev composer req friendsoftypo3/kickstarter@dev-main
```

Go to the backend module `Admin Tools > Settings > Extension Configuration`, edit the "Kickstarter" 
settings and user path `packages` as "Export Directory".

## Create a basic extension

```
ddev typo3 make:extension
```

When prompted answer the questions, note the composer name you entered.

## Install you newly created extension

```
ddev composer require myvendor/myextension
```

## Create a site set

```
ddev typo3 make:site-set
```

## Depend on the site set from your site

Go to backend module `Site Management > Sites` and edit your site. In section "Sets for this Site"
choose your newly created site set.

## Create an Extbase Controller

```
ddev typo3 make:controller
```

Create a new Extbase Controller with name `CalculatorController`

When prompted create two actions: 

* form
* result

## Create an Extbase Plugin

```
ddev typo3 make:plugin
```

Choose the controller you just created. Include both actions, action "result" should not be cached.

When prompted place the TypoScript into the site set you created earlier.

## Create Fluid templates

Using an editor create two Fluid templates and put them into folder `packages/my_extension/Ressources/Private/Templates/`

*  Form.html
*  Result.html

Put some example output into these forms.

## Include the plugin into your page

Clear all caches:

```
ddev typo3 cache:flush
```

## Summary

Go to a page on your site and insert the plugin there using the "New Content element wizard". When you 
preview the page you should see the Content of the Form.html template.

Congratulations! You now have now created a basic Extbase plugin.

## Next steps

Now that you have created a basic plugin, you might like to:

* Fill the Controller with life
* Attach a Service that does some actual calculation
* Use a Data Transfer Object (DTO) to pass data around
* Temporarily store the data in the user session
* Permanently store the data into the database

## Resources

* [Kickstarter](https://github.com/FriendsOfTYPO3/kickstarter)
* [The finished example extension "bmi_caluclator"](https://github.com/TYPO3-Documentation/bmi_calculator/tree/main)
* [Site sets ](https://docs.typo3.org/permalink/t3coreapi:site-sets)
* [Extbase controller ](https://docs.typo3.org/permalink/t3coreapi:extbase-controller)
* [Registration of frontend plugins ](https://docs.typo3.org/permalink/t3coreapi:extbase-registration-of-frontend-plugins)
