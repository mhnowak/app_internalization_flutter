# App Internalization in Flutter

Sometimes, there’s a need for your app to translate into multiple languages. In flutter, it’s pretty simple to implement. Let’s start with creating an empty project.
​
## Installation
​
Add this line to your pubspec.yaml
```yaml
flutter_localizations:
	sdk: flutter
```
​
Now, you can either install a plugin for an IDE you’re using ([AndroidStudio](https://plugins.jetbrains.com/plugin/13666-flutter-intl) or [VSCode](https://marketplace.visualstudio.com/items?itemName=localizely.flutter-intl#user-content-flutter-intl-initialize)) or simply use CLI. I recommend using a plugin for either IDE, since it has really nice features, which we will go through in this article.

However, if you decide to stick with the CLI, you’ll need to install [this package](https://pub.dev/packages/intl_utils#-installing-tab-) instead of the extension.

## Initialize for the project

Let's start with initializing your project, which will generate some files. If you’re using AndroidStudio go to **tools | flutter intl** and run **Initialize for the Project**. It should be fairly similar in VSCode, just follow the steps in the package description.

![img](https://appunite-blog.s3.eu-central-1.amazonaws.com/images/4d094fce/68d5/MS5wbmc=)

Generated files are responsible for connecting your flutter code with the translations from `.arb` files. Speaking of them, they are simply json-like files and you shouldn’t have any problems while working with them.

## Set up your app

There are a few things more we need to set up in our `AppWidget`. Add a `S.delegate `to your `MaterialApp` and specify supported locales like this: 

```dart
return MaterialApp(
 localizationsDelegates: [S.delegate],
 supportedLocales: S.delegate.supportedLocales,
 home: MainPage(),
);
```
​
Don’t forget to `import 'package:appinternalization/generated/l10n.dart';`.
​
You’ll also need to add any of the delegates to the list of delegates shown earlier, if your app needs any of them:  
​
- `GlobalMaterialLocalizations.delegate`, (if your app is using any Material widgets),
- `GlobalWidgetsLocalizations.delegate`, (if your app is using right to left text direction),
- `GlobalCupertinoLocalizations.delegate`, (if your app is using any Cupertino widgets),

If you need more info about them, just check the flutter’s open source documentation. Just remember your widgets might not render correctly if you don’t add the ones you’re using.

## Add words to the dictionary

Aight, after setting this all up, let’s add our first string. Either do it by hand in `.arb` file:

```arb
{
   "helloWorld": "Hello world!"
}
```

Or use a code snippet directly from .dart file (at the time of writing this article there is no such a feature in VSCode, unfortunately)

![img](https://appunite-blog.s3.eu-central-1.amazonaws.com/images/739473a4/3c61/Mi5wbmc=)

It will automatically re-generate all of the files and replace the text with `S.of(context).helloWorld`. If you’ve chosen the first option, you’d need to do it manually. The `S` class is built on top of an inherited widget and if the locale changes during the lifetime of your app, it will automatically refresh all of the texts associated with it.

## Add another language

Since you probably want to have more than one. Again go to **tools | flutter intl** and select **Add Locale,** then, provide translations for whatever words you want to translate, for example: 

```arb
{
 "helloWorld": "Witaj swiecie!"
}
```
​
Or simply create a new `.arb` file named `intl_<locale>.arb` and do the same. 
​
## Additional set up for iOS apps
​
There’s one more important step for the iOS apps that needs to be done. You’ll need to add all supported locales to `info.plist`. It should be consistent with the locales listed in the l10n folder. Without that, the translations simply won’t work for the iOS app: 

![image-20200323101907733](https://appunite-blog.s3.eu-central-1.amazonaws.com/images/ecf74c1d/a4f3/U2NyZWVuc2hvdCAyMDIwLTAzLTIzIGF0IDE0LjAyLjU2LnBuZw==)

And that’s pretty much it. Now, when you change the locale language on your phone, the language in your app should also change!
​
## Parameterized strings
​
Let’s get to something more complex, for example the counter app. In .arb files, you can create argumented strings like this one: `"clickButtonCounterFormat": "You have pushed the button {count} times"`
​
It will create a function that returns a string value with a dynamic parameter in the place of a count. Dart code: 
​
```dart
body: Center(
 child: Text(S.of(context).clickButtonCounterFormat(_count)),
),
```
​
But there is one problem with the current solution. Pay attention that it says that it pushed the button “1 times”. Fortunately, there is a solution! We can use [ICU format](http://userguide.icu-project.org/formatparse/messages) to create some string “patterns” like this one:
```arb
"clickButtonCounterFormat": "{count, plural, one{You have pushed the button 1 time} other{You have pushed the button {count} times}}"
```
​
It will format the string just like it did previously, except when 1 argument occurs. 
​
## Thank you for reading
​
Hope you found this article helpful.

### Sources:
​
- https://flutter.dev/docs/development/accessibility-and-localization/internationalization
- https://plugins.jetbrains.com/plugin/13666-flutter-intl
- https://pub.dev/packages/intl_utils#-installing-tab-
