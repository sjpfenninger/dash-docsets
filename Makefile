default:
	@echo Valid build targets:
	@echo "  * build"
	@echo "  * fetch"
	@echo "  * clean"
	@echo "  * clean-docsets -- Warning: removes all docsets!"

clean:
	rm -rf source

clean-docsets:
	rm -rf *.docset

build-ipython:
	./build-docset.sh IPython source/ipython.org/ipython-doc/stable

build-pandas:
	./build-docset.sh pandas source/pandas.pydata.org/pandas-docs/stable

build-numpy:
	./build-docset.sh  NumPy source/numpy

build-scipy:
	./build-docset.sh SciPy source/scipy

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

fetch-pandas:
	wget -r --no-parent -P source http://pandas.pydata.org/pandas-docs/stable/
	# Necessary to get searchtools.js for doc2dash to recognize and parse the directory
	wget -r --no-parent -P source http://pandas.pydata.org/pandas-docs/stable/_static/searchtools.js

fetch-numpy:
	wget http://docs.scipy.org/doc/numpy/numpy-html.zip
	unzip numpy-html.zip -d source/numpy
	rm numpy-html.zip

fetch-scipy:
	wget http://docs.scipy.org/doc/scipy/scipy-html.zip
	unzip scipy-html.zip -d source/scipy
	rm scipy-html.zip

fetch-statsmodels:
	wget -r --no-parent -P source http://statsmodels.sourceforge.net/stable/
	wget -r --no-parent -P source http://statsmodels.sourceforge.net/stable/_static/searchtools.js

fetch-seaborn:
	wget -r --no-parent -P source http://stanford.edu/~mwaskom/software/seaborn/
	wget -r --no-parent -P source http://stanford.edu/~mwaskom/software/seaborn/_static/searchtools.js
	wget -r --no-parent -P source/stanford.edu/~mwaskom/software/seaborn/ http://cdn.mathjax.org/mathjax/latest/MathJax.js
	wget -r --no-parent -P source/stanford.edu/~mwaskom/software/seaborn/ https://netdna.bootstrapcdn.com/bootswatch/3.0.0/flatly/bootstrap.min.css

fetch:
	make fetch-ipython
	make fetch-pandas
	make fetch-numpy
	make fetch-scipy
	make fetch-statsmodels
	make fetch-seaborn

build:
	make build-ipython
	make build-pandas
	make build-numpy
	make build-scipy
	make build-statsmodels
	make build-seaborn
