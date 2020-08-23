# Cats
An iOS application that shows cats breeds and some info about them.

# Installation

Before we open the project, we need to setup some dependencies.


## Bundler

Bundler helps with Ruby dependencies. In the case you don't have Bundler in your system, you can install it by executing the command line below in your terminal:

`gem install bundler`

After that you can install the dependencies of the project executing:

`bundle install`


## Cocoapods

This project uses cocoapods as dependencies manager. To install all the pods using the bundler, execute:

`bundle exec pod install`


## Cocoapods-keys

We are almost done. But, for some security, we need to set up the cats-keys by script in order to not have it hardcoded in the code. Simply execute this command line:

`bundle exec pod keys set apiCatsSecret INSERT_YOUR_CODE_HERE`

Don't forget to substitute for the key you created on https://thecatapi.com/

That was all! Don't forget to open the **Cats.xcworkspace/** as we're using Cocoapods.

# Images 
| Light | Dark |
:-:|:-:
![alt text](https://github.com/sampaioroberto/Cats/blob/master/Images/iPhone8ListLight.png)|![alt text](https://github.com/sampaioroberto/Cats/blob/master/Images/iPhone8ListDark.png)
![alt text](https://github.com/sampaioroberto/Cats/blob/master/Images/iPhone8DetailLight.png)|![alt text](https://github.com/sampaioroberto/Cats/blob/master/Images/iPhone8DetailDark.png)
![alt text](https://github.com/sampaioroberto/Cats/blob/master/Images/iPadLight.png)|![alt text](https://github.com/sampaioroberto/Cats/blob/master/Images/iPadDark.png)


