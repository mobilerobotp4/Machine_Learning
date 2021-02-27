# Scraping IMDB website for favorite genre of movies
## Backgroud
I am always fascinated about Machine Learning and Data Science as a whole. There are plenty of oppertunities of researching over the booming field of data science. The other day I started thinking why I always have to rely on artificial dataset of Kaggle, UCI Machine Learning Repository? Why am I not becoming my own Kaggle? I started searching on my dearest Google and came to know about web scraping. An oppertunity to be my own boss. I found plenty of example projects on web over IMDB (the movie rating) website. So, I start a project to scrap IMDB for my favorite genre. **Horror**. *Sounds scary right!!!*

## Getting Started
The url that I used for my work.[click here](https://www.imdb.com/search/title/?genres=horror&title_type=feature&explore=genres)

The page looks like 

![image](https://github.com/mobilerobotp4/Machine_Learning/blob/sub_ml/Web_scraping/IMDB/horror_movies.jpg)

As per the image of the website there are number of open fields for scraping. Among them I choosed to scrap *name of the movie, its releasing year, rating of the movie, metascore of the movie, genre of the movie, duration of the flim* and last but not the least the *Captain of the ship*, the name of the *director* of the movie.

## Goal

My end goal is to create a csv (comma-separated values) file which will become my own dataset. This will help me to play around with machine learning algorithms. 

## Prerequisites
I implemented the project using Python, the most handy high-level and general-purpose programming language in today's world.

I had to install some libaries for the project

**requests** : Requests allows us to send HTTP/1.1 requests extremely easily. There’s no need to manually add query strings to our URLs

**Installing Requests package**
Write down the following command in the terminal
`pip install requests`

**BeautifulSoup**: Beautiful Soup is a Python library designed for quick turnaround projects. Beautiful Soup tries to organize complexity, it helps to parse,structure and organize the oftentimes very messy web by fixing bad HTML and presenting us with an easy-to-work-with Python structure.

**Installing BeautifulSoup package**
Write down the following command in the terminal
`pip install beautifulsoup4`

**Pandas**: Pandas is a software library written for the Python programming language for data manipulation and analysis.

**Installing Pandas package**
Write down the following command in the terminal  
`pip install pandas`


**Numpy**: Numpy is the core library for scientific computing in Python. It provides a high-performance multidimensional array object and tools for working with these arrays.

**Installing Numpy package**
Write down the following command in the terminal
`pip install numpy`

## Preparing the dataset

I have already mentioned the fields that I have been interested in, now I am going to scrap them.

Here I like to mention that my previous knowledge on HTML (Hypertext Markup Language), CSS (Cascading Style Sheets), JSP (Java Server Pages) help me a lot to understand a webpage completely. 

I developed a **Python script** using the **BeautifulSoup** library, which allows to parse HTML code.

**Analyzing the URL**

`https://www.imdb.com/search/title/?genres=horror&title_type=feature&explore=genres`

`genres=horror&title_type=feature&explore=genres` is the query string which comes at the end of the URL seperated by `?`(question mark). Here we want see the list of the horror movies.

Some URLS also have the a `ref` section at the end of the URL. We can be found that `ref` portion if we inspect the end element of a webpage where we find the link to navigate to the next page or the previous page of a website.

**Inspect HTML**

![image](https://github.com/mobilerobotp4/Machine_Learning/blob/sub_ml/Web_scraping/IMDB/Inspect.jpg)

![image](https://github.com/mobilerobotp4/Machine_Learning/blob/sub_ml/Web_scraping/IMDB/Inspect-element.jpg)

Inspect element can be found after selecting a certain attribute and then right click on it. Inspect help us to naviagte the particular tab of the attribute which we need to scrap.

In the above example we want to find the tag for the duration of the movie. So we select **109 min** in the above picture which is the runtime of the movie **Wrong turn** . 

When I had inspected the runtime I found two tags <p> tag and <span> tag. <span> tag is nested within a <p> tag. So when we write down the code we need to explain this nesting fully. Otherwise, my code unable to find exact tagging. 
  
We can use inspect element for all our desired scraping fields.

Name of the movie:

![image](https://github.com/mobilerobotp4/Machine_Learning/blob/sub_ml/Web_scraping/IMDB/Name.jpg)

Important tags for parsing **h3** and **a**

Year of Release

![image](https://github.com/mobilerobotp4/Machine_Learning/blob/sub_ml/Web_scraping/IMDB/year.jpg)

Important tags for parsing **h3** and **span**

Genre of the movie

![image](https://github.com/mobilerobotp4/Machine_Learning/blob/sub_ml/Web_scraping/IMDB/genre.jpg)

Important tag for parsing **p** and **span**

Metascore of the movie

![image](https://github.com/mobilerobotp4/Machine_Learning/blob/sub_ml/Web_scraping/IMDB/Metascore.jpg)

Important tag for parsing **span**

Name of the director

![image](https://github.com/mobilerobotp4/Machine_Learning/blob/sub_ml/Web_scraping/IMDB/director.png)

Important tag for parsing **p** and **a**

## Outcome of the project

Generate a csv file name **movies.csv**






