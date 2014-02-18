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

build-pandas:
	./build-docset.sh pandas source/pandas.pydata.org/pandas-docs/stable

build-numpy:
	./build-docset.sh  NumPy source/numpy

build-scipy:
	./build-docset.sh SciPy source/scipy

build-statsmodels:
	./build-docset.sh statsmodels source/statsmodels.sourceforge.net/stable
	
build-matplotlib:
	./build-docset.sh Matplotlib source/matplotlib.org

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
	
fetch-matplotlib:
	wget -r --no-parent -P source http://matplotlib.org/contents.html

fetch:
	make fetch-pandas
	make fetch-numpy
	make fetch-scipy
	make fetch-statsmodels
	make fetch-matplotlib

build:
	make build-pandas
	make build-numpy
	make build-scipy
	make build-statsmodels
	make build-matplotlib
