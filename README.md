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
rake db:schema:load
rails runner scripts/grab_boxoffice_from_m1905.rb
rails runner scripts/grab_boxoffice_from_mtime.rb
rails runner scripts/grab_oscar_from_m1905.rb
whenever -i
```
This will take a while. Be patient, pls.
Wait for data import is complete, then run your server.
```
rails s
```
