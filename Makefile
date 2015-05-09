default:
	@echo Examine Makefile to see valid build targets

clean:
	rm -rf source

clean-docsets:
	rm -rf *.docset

build-ipython:
	./build-docset.sh IPython source/ipython.org/ipython-doc/stable

build-pandas:
	./build-docset.sh pandas source/pandas.pydata.org/pandas-docs/stable

build-statsmodels:
	./build-docset.sh statsmodels source/statsmodels.sourceforge.net/stable

build-seaborn:
	find source/stanford.edu/~mwaskom/software/seaborn -maxdepth 1 -name '*.html' -type f -exec sed -i "" 's|//netdna.bootstrapcdn.com|netdna.bootstrapcdn.com|g' {} \;
	find source/stanford.edu/~mwaskom/software/seaborn -mindepth 2 -name '*.html' -type f -exec sed -i "" 's|//netdna.bootstrapcdn.com|../netdna.bootstrapcdn.com|g' {} \;
	find source/stanford.edu/~mwaskom/software/seaborn -maxdepth 1 -name '*.html' -type f -exec sed -i "" 's|http://cdn.mathjax.org|cdn.mathjax.org|g' {} \;
	find source/stanford.edu/~mwaskom/software/seaborn -mindepth 2 -name '*.html' -type f -exec sed -i "" 's|http://cdn.mathjax.org|../cdn.mathjax.org|g' {} \;
	./build-docset.sh seaborn source/stanford.edu/~mwaskom/software/seaborn js

fetch-ipython:
	wget -r --no-parent -P source http://ipython.org/ipython-doc/stable/
	# Manually copy a searchtools.js file that doc2dash will recognize
	wget -r --no-parent -P source http://ipython.org/ipython-doc/stable/_static/searchtools.js
	cp searchtools.js source/ipython.org/ipython-doc/stable/_static

fetch-pandas:
	wget -r --no-parent -P source http://pandas.pydata.org/pandas-docs/stable/
	# Necessary to get searchtools.js for doc2dash to recognize and parse the directory
	wget -r --no-parent -P source http://pandas.pydata.org/pandas-docs/stable/_static/searchtools.js

fetch-statsmodels:
	wget -r --no-parent -P source http://statsmodels.sourceforge.net/stable/
	wget -r --no-parent -P source http://statsmodels.sourceforge.net/stable/_static/searchtools.js

fetch-seaborn:
	wget -r --no-parent -P source http://stanford.edu/~mwaskom/software/seaborn/
	wget -r --no-parent -P source http://stanford.edu/~mwaskom/software/seaborn/_static/searchtools.js
	wget -r --no-parent -P source/stanford.edu/~mwaskom/software/seaborn/ http://cdn.mathjax.org/mathjax/latest/MathJax.js
	wget -r --no-parent -P source/stanford.edu/~mwaskom/software/seaborn/ http://cdn.mathjax.org/mathjax/latest/extensions/MathZoom.js
	wget -r --no-parent -P source/stanford.edu/~mwaskom/software/seaborn/ http://cdn.mathjax.org/mathjax/latest/extensions/MathMenu.js
	wget -r --no-parent -P source/stanford.edu/~mwaskom/software/seaborn/ https://netdna.bootstrapcdn.com/bootswatch/3.0.0/flatly/bootstrap.min.css

pandas: fetch-pandas build-pandas

ipython: fetch-ipython build-ipython

statsmodels: fetch-statsmodels build-statsmodels

seaborn: fetch-seaborn build-seaborn
