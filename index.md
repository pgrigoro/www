---
title: "Overview"
keywords: fog, ubiquity, cloud, computing
permalink: /index.html
toc: false
comments: false
---

<h2>Last 3 Updates</h2>

<div class="home">

    <div class="latest-content">
	{% assign valid_pages = site.pages | where_exp: "page", "page.tags" %}
    	{% assign content = site.posts | concat: valid_pages | sort_natural: "last_updated" %}
    	{% for post in content limit:3 %}


    <h2><a class="post-link" href="{{ post.url | remove: "/" }}">{{ post.title }}</a></h2>
    <span class="post-meta">{% if post.last_updated %}{{ post.last_updated | date: "%b %-d " }}{% else %}{{ post.date | date: "%b %-d " }}{% endif %} /
            {% for tag in post.tags %}

                <a href="{{ "tag_" | append: tag | append: ".html"}}">{{tag}}</a>{% unless forloop.last %}, {% endunless%}

                {% endfor %}</span>
        <p>{% if page.summary %} {{ page.summary | strip_html | strip_newlines | truncate: 160 }} {% else %} {{ post.content | truncatewords: 50 | strip_html }} {% endif %}</p>

        {% endfor %}

    </div>
</div>

<h2>Interactive Series</h2>

{% unless site.output == "pdf" %}
<script src="js/jquery.shuffle.min.js"></script>
<script src="js/jquery.ba-throttle-debounce.min.js"></script>
{% endunless %}

      <div class="filter-options">
      <button class="btn btn-primary" data-group="all">All</button>
      <button class="btn btn-primary" data-group="nixos">NixOS</button>
    </div>      

<div id="grid" class="row">


    <div class="col-xs-6 col-sm-4 col-md-4" data-groups='["nixos"]'>

               <div class="panel panel-default">
               <div class="panel-heading">Getting started</div>
               <div class="panel-body">
        	NixOS is awesome! 
                  <ul>
                {% for page in site.pages %}
                {% for tag in page.tags %}
                {% if tag == "nixos" %}
                  <li><a href="{{page.url | remove: '/'}}">{{page.title}}</a></li>
                {% endif %}
                {% endfor %}
                {% endfor %} 
                  </ul>
               </div>
            </div>
    
    </div>
   

          <!-- sizer -->
      <div class="col-xs-6 col-sm-4 col-md-1 shuffle_sizer"></div>          


    </div><!-- /#grid -->

{% unless site.output == "pdf" %}
{% include initialize_shuffle.html %}
{% endunless %}
