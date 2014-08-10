# Using the Quandl API
# http://mkmanu.wordpress.com/2014/08/03/using-quandl-on-r-tutorial-1/
# http://www.quandl.com/help/api

library(Quandl)
# This will grant you full access to APIs and extend your usage at Quandl.com

# You can check, whether your access and everything else is working fine, by typing:
Quandl.auth("xQrMq4Pc4Tj2qFxfrP-4")
plot(stl(Quandl('GOOG/NASDAQ_GOOG',type='ts',collapse='monthly')[,1],s.window='per'))

# Now, I will explain how to search for something on Quandl from within the R. The search function is:

Quandl.search(query = 'Search Term', page = n, source = 'Specific source to search', silent = TRUE|FALSE)

# Here,
#    Query: Required; Your search term, as a string
#    Page: Optional; page number of search you wish returned, default is page number 1 but if you set it to 2, the search will return page two and so forth.
#    Source: Optional; Name of a specific source you wish to search, as a string e.g. NSE (National Stock Exchange, India)
#    Silent: Optional; specifies whether you wish the first three results printed to the console, default is set to True, which means first three results will be shown.

# Example

Quandl.search('Steel', source = 'NSE')
# JSW ISPAT Steel Limited
# Code: NSE/JSWISPAT
# Desc: Historical prices for JSW ISPAT Steel Limited (JSWISPAT), (ISIN: INE136A01022),  National Stock Exchange of India.
# Freq: daily
# Cols: Date|Open|High|Low|Last|Close|Total Trade Quantity|Turnover (Lacs)
# 
# Lloyds Steel Industries Limited
# Code: NSE/LLOYDSTEEL
# Desc: Historical prices for Lloyds Steel Industries Limited (LLOYDSTEEL), (ISIN: INE292A01015),  National Stock Exchange of India.
# Freq: daily
# Cols: Date|Open|High|Low|Last|Close|Total Trade Quantity|Turnover (Lacs)
# 
# AML Steel Limited
# Code: NSE/AMLSTEEL
# Desc: Historical prices for AML Steel Limited (AMLSTEEL), (ISIN: INE577F01018),  National Stock Exchange of India.
# Freq: daily
# Cols: Date|Open|High|Low|Last|Close|Total Trade Quantity|Turnover (Lacs)

# Tutorial Example

# In this example we will first fetch USD (US Dollar) to INR (Indian Rupees)
# Exchange Rate from January 01, 2013 to July 31, 2014. This data is fetched
# from Quandl and stored in a variable, say, Exchange.

# Load the Quandl package if not already loaded
# library(Quandl)
# Assign to the variable Exchange

Exchange = Quandl('QUANDL/USDINR', start_date='2013-01-01', end_date='2014-07-31')
dim(Exchange)
# Please note, the data are stored as the most recent one in the first row and so forth (chronological order). If we plot this series, it will give us reverse interpretation.
head(Exchange)
# We, therefore, first arrange the order of series using:

Exchange1 = Exchange[order(-1:-413), ]
dim(Exchange1)
# which becomes as:
head(Exchange1)

# And now we can plot

plot(Exchange1$Rate, type="l", main="1 USD = Rupees, Exchange Rate", xlab="Exchange Days Data", ylab="Rupees")

