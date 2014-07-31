step1
rails new sunspot_test --skip-bundle
Step2:脚手架 
Ruby代码  
rails generate scaffold Production  name:string title:string content:text  


Step3:数据库变更 
Ruby代码  
rake db:migrate  


Step4: 加入gem包 
Ruby代码  
gem 'sunspot_rails'  
gem 'sunspot_solr' # optional pre-packaged Solr distribution for use in development  
gem 'progress_bar'


Step5: 
Ruby代码  
bundle
rails generate sunspot_rails:install  


Step6:启动solr 
Ruby代码  
bundle exec rake sunspot:solr:start # or sunspot:solr:run to start in foreground  


Step7:修改models/production.rb 
Ruby代码  
class Production < ActiveRecord::Base  
attr_accessible :content, :name, :title  
searchable do  
text :content, :name,:title  
text :orders do
orders.map{|order|order.desc}
end
end  
end  
Step8
修改app/views/productions/index.html.erb 添加
<%= form_tag search_students_path, :method => :get do %>
<p>
<%= text_field_tag :query, params[:query] %> <%= submit_tag "Search!" %>
</p>
<% end %>
Step9
修改config/routes.rb大内容 resources:productions 为
resources:productions do
collection do
get :search
end
end
Step10
修改app/controllers/productions_controller.rb添加方法
def search
@productions = Production.search do
keywords params[:query]
end.results
respond_to do |format|
format.html { render :action => "index" }
end
end
Step 11
rails g scaffold order production_id:integer desc:string

说明
bundle exec rake sunspot:reindex 重新生成分词

**Sunspot基于Solr；**
===========================================================

Solr是一个独立的企业级搜索应用服务器，它对外提供类似于Web-service的API接口。
Solr是一个高性能，采用Java5开发，基于Lucene的全文搜索服务器。同时对其进行了扩展，提供了比Lucene更为丰富的查询语言，同时实现了可配置、可扩展并对查询性能进行了优化，并且提供了一个完善的功能管理界面，是一款非常优秀的全文搜索引擎。

Solr优点：
（1）Solr 可以对几乎任何对象进行索引，该对象甚至可以不是ActiveRecord.而Sphinx和RDBMS耦合过于紧密
（2）Solr 索引的对象ID可以非空或者是字符串，而Sphinx要求被索引对象必须拥有非0整数作为ID
（3）Solr 支持Boolean作为查询条件搜索,更加方便 Solr 支持Facets,而Sphinx为此需要做更多工作
（4）Solr是对lucene的包装。所以他可以享受lucene每次升级带来的便利。
