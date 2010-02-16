require 'open-uri'
require 'json'

class Person < SourceAdapter
  def initialize(source,credential)
    @remote_host = "localhost:3333"
    # @remote_home = mobileruby.heroku.com
    #
    super(source,credential)
  end
 
  def login
    # no login required
  end
 
  def query
    parsed=nil
    open("http://#{@remote_host}/people.json") do |f|
      parsed=JSON.parse(f.read)
    end
    @result={}
    parsed.each {|item| @result[item["person"]["id"].to_s]=item["person"]} if parsed
    @result    
  end
 
  def sync
    super # this creates object value triples from an @result variable that contains a hash of hashes 
  end
 
  def create(name_value_list,blob=nil)
    puts "------------------------------------------------- puts create"
    attrvals={}
    name_value_list.each { |nv| attrvals["person["+nv["name"]+"]"]=nv["value"]} # convert name-value list to hash
    res = Net::HTTP.post_form(URI.parse("http://#{@remote_host}/people/create"),attrvals)  
  
  end
 
  def update(name_value_list)
    #TODO: write some code here
    # be sure to have a hash key and value for "object"
    raise "Please provide some code to update a single object in the backend application using the hash values in name_value_list"
  end
 
  def delete(name_value_list)
    #TODO: write some code here if applicable
    # be sure to have a hash key and value for "object"
    # for now, we'll say that its OK to not have a delete operation
    # raise "Please provide some code to delete a single object in the backend application using the hash values in name_value_list"
  end
 
  def logoff
    #TODO: write some code here if applicable
    # no need to do a raise here
  end
end
