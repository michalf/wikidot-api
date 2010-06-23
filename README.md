Wikidot API Client Library for Ruby
===================================

Wikidot-api is a simple client library for [Wikidot Remote API](http://www.wikidot.com/doc:api).
The library provides a simple wrapper around Ruby's [XMLRPC library](http://www.ensta.fr/~diam/ruby/online/ruby-doc-stdlib/libdoc/xmlrpc/rdoc/index.html) and handles authentication, reconnection and provides an easy way to access remote methods.

Installation
------------

Wikidot-api is available as a gem. Installation is as simple as

    gem install wikidot-api
    
(or run with <tt>sudo</tt> if your ruby installation requires it, i.e. <tt>sudo gem install wikidot-api</tt>)
    
Usage
-----

Before you start using the wikidot-api library, you need an API key. Please consult the original [documentation](http://www.wikidot.com/doc:api) on how to get one.

### Connecting

    require "rubygems"
    require "wikidot_api"
    
    api_key = "YOUR_API_KEY_HERE"
    
    wikidot = WikidotAPI::Client.new "wikidot-api", api_key
    
First argument to the #new method is name of the application using the API. E.g. if you are creating an application called "Best Wikidot API Client", please use its name in the constructor.

### Calling remote methods

At this point the <tt>wikidot</tt> object should contain all methods described in the API documentation.
The <tt>WikidotAPI::Client</tt> implements <tt>method_missing</tt> method so that every (non-defined) method you call
is checked agains remote service. This way the library does not need to be updated if RPC methods change, but still provides
convenient solution to query the remote service.

#### Getting list of methods and method descriptions

Using the RPC methods you can get list of implemented methods and their descriptions.

    puts wikidot.system.listMethods

at this moment this prints:
    system.listMethods
    system.methodHelp
    system.methodSignature
    system.multicall
    site.pages
    site.categories
    page.get
    page.files
    page.save
    user.valid
    user.sites

To print help about any particular method, try this:
    
    puts wikidot.system.methodHelp 'page.save'

#### Example: Listing sites

The example below uses the remote method <tt>user.sites</tt> that takes one parameter (<tt>user</tt>) and returns a list of sites that this user owns. The method can be called directly on the <tt>wikidot</tt> object.

    sites = wikidot.user.sites "user" => "YOUR_USER_NAME_HERE"
    sites.each do |site|
      puts "#{site["title"]}, http://#{site["name"]}.wikidot.com" 
    end
    
#### Example: Fetching a page

    page = wikidot.page.get "site" => "YOUR_SITE_NAME_HERE", "page" => "YOUR_PAGE_NAME_HERE"
    puts page["title"]
    puts page["source"]

#### Example: Creating a new page

    args = {
        "title" => "My new page",
        "source" => "Hello world from the new page",
        "page" => "page-name",
        "site" => "site-name"
    }
    
    wikidot.page.save args
    
TODO
----

The library is a work-in-progress, as is the Wikidot API itself. Use at your own risk.
    
    
See also
--------

- Wikidot.com at [http://www.wikidot.com](http://www.wikidot.com)
- API documentation at [http://www.wikidot.com/doc:api](http://www.wikidot.com/doc:api)
- list of available methods at [http://www.wikidot.com/doc:api-methods](http://www.wikidot.com/doc:api-methods)