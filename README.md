##Newnil Boxoffice##
###Installation###
----
Clone repository to your server
```
git clone git@github.com:sunday35034/piaofang.git
```
System initialization
```
bundle install
rake db:scheme:load
rails runner scripts/grab_boxoffice_from_mtime.rb
```
then run your server
```
rails s
```
