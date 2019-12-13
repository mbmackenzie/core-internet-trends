--- 
title: "Analysis of Internet Core Trends"
author: "Woo Jin Kim, Matt Mackenzie, Mamunur Rashid"
date: "2019-12-12"
description: "The Internet Core Trends survey contains information of how americans view and use the internet."
site: bookdown::bookdown_site
output: bookdown::gitbook
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
colorlinks: yes
github-repo: mbmackenzie/edav-f19-final
editor_options: 
  chunk_output_type: console
---




# Introduction {-}

It is no surprise that the internet is a quintessential aspect of modern life. In 2018, more than 77% of Americans over the age of 18 used the internet at least once per day, and in 2019 that number rose to over 82%. The United States has a $290 Billion digital infrastructure in place, capable of delivering speeds of many gigbits per second.^[https://www.ncta.com/broadband-by-the-numbers] When there is this much bandwidth to go arround, two major questions come to mind: *Who has internet access? And what are they doing with it?* These simple questions are perhaps answered with Occum's razor-esque answers: 

**Everyone has internet access. Everyone is on Facebook.**

While the above is an exageration, despite the small scope of this analysis by only having access to 2018 and 2019 data, we will find our Facebook claim to be remarkably close to the truth (at least with this survey). 

## Background
On October 29, 1969 at Stanford University, the letters "L" and "O" flashed on a monitor, followed by an assumed sigh of frustration, as the first "internet" based transmission crashed the ARPA network. The Advanced Research Projects Agency Network (ARPAnet) was a United States Department of Defense project with the goal of linking computers together. The letter "L" and "O" were the first two letters of the word "LOGIN", and the message that failed at Stanford was sent from UCLA, which is an admirable 650 miles away.^[https://www.history.com/news/who-invented-the-internet]

For the next 20 years, the "interent" continued to advance, with additions like TCP/IP, DNS, .com, and a steadily growing host base of over 100,000 by 1989. In 1990, ARPAnet is no more, however at the same time Tim Berners-Lee develops the Hypertext Markup Language (HTML), the foundation of modern web browsing. In 1991, the world wide web is introduced to the public by Cern. The modern internet is born. 

Many of the websites we cherish today were formed many years ago. Google search was created in 1998, Facebook in 2004, YouTube in 2005, Twitter in 2006. By 2010, Facebook had an active userbase of 400 million.^[https://www.livescience.com/20727-internet-history.html] Today, that number is at 2.45 *billion* users, that means roughly 1 in every 3 people on earth has a Facebook account. Is Facebook the reason we use the internet so much? Or is it the internet that draws us to the dominant social media platform, which right now happens to be Facebook?

## The Analysis
The primary analysis will be diveded in three parts: 

1. How much do people use the internet and what for?
2. Are there any relationships between where people live, their ethnic background, the economic trends of the region, and other demographic characteristics and how they use the internet?
3. How do Americans view the internet as a tool for society both overall and personally? 

All of the code, data, and other resources for this project are on [GitHub](https://github.com/mbmackenzie/edav-f19-final). 
